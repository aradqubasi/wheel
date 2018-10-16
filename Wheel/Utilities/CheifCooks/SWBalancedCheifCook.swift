//
//  SWBalancedCheifCook.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWBalancedCheifCook: SWCheifCook {
    
    private let attempts = 10
    
    private let dailyCalories: Double = 1800
    
    private let energyByServingByDayHour: [(start: Int, end: Int, min: Double, max: Double)] = [
        (0, 10, 0.167, 0.222),
        (11, 19, 0.278, 0.389),
        (20, 24, 0.167, 0.222),
    ]
    
    private let energyByNutrient: (carbohydrates: (min: Double, max: Double), proteins: (min: Double, max: Double), fats: (min: Double, max: Double)) = ((0.45, 0.65), (0.1, 0.35), (0.2, 0.35))
    
    private var repository: SWFullIngredientRepository
    
    private var randomizer: SWRandomIngredientProvider
    
    init(ingredients: SWFullIngredientRepository, randomizer: SWRandomIngredientProvider) {
        self.repository = ingredients
        
        self.randomizer = randomizer
    }
    
    private func getRaeIndex(actual: [Double], expected: [Double]) -> Double {
        if actual.count != expected.count {
            fatalError("can't calculate rae index for array of unequal length actual.count = \(actual) expected.count = \(expected)")
        }
        var index: Double = 0
        for i in 0..<actual.count {
            index += abs(actual[i] - expected[i])
        }
        index /= Double(actual.count)
        return index
    }
    
    private func rate(ingredients: [SWFullIngredient]) -> Double {
        let zero: (fats: Double, proteins: Double, carbohydrates: Double, energy: Double) = (0, 0, 0, 0)
        let stats = ingredients.map({
            (next: SWFullIngredient) -> (fats: Double, proteins: Double, carbohydrates: Double, energy: Double) in
            return (
                next.stats.fats * next.ingredient.quantity * 6.0,
                next.stats.proteins * 4.0 * next.ingredient.quantity,
                next.stats.carbohydrates * 4.0 * next.ingredient.quantity,
                next.stats.calories * next.ingredient.quantity
            )
        }).reduce(zero, {
            (current, next) -> (fats: Double, proteins: Double, carbohydrates: Double, energy: Double) in
            return (
                current.fats + next.carbohydrates,
                current.proteins + next.proteins,
                current.carbohydrates + next.carbohydrates,
                current.energy + next.energy
            )
        })
        let hour = Calendar.current.component(.hour, from: Date())
        guard let share = energyByServingByDayHour.first(where: { hour >= $0.start && hour <= $0.end }) else {
            fatalError("hour \(hour) is out of bounds 0..<24")
        }
        let mealEnergyShare = (share.max - share.min) * 0.5
        let expected = [
            (energyByNutrient.fats.max + energyByNutrient.fats.min) * 0.5 * mealEnergyShare,
            (energyByNutrient.proteins.max + energyByNutrient.proteins.min) * 0.5 * mealEnergyShare,
            (energyByNutrient.carbohydrates.max + energyByNutrient.carbohydrates.min) * 0.5 * mealEnergyShare
        ]
        //print("expected = [\(expected[0]), \(expected[1]), \(expected[2])]")
        let actual = [
            stats.fats / dailyCalories,
            stats.proteins / dailyCalories,
            stats.carbohydrates / dailyCalories
        ]
        //print("actual = [\(actual[0]), \(actual[1]), \(actual[2])]")
        let rank = getRaeIndex(actual: actual, expected: expected)
        //print("rank = \(rank)")
        return rank
    }
    
    private func random() -> [SWFullIngredient] {
        var selection: [SWFullIngredient] = []
        
        let ingredients = repository.getAll()
        
        selection.append(
            randomizer.random(ingredients: ingredients.filter({ $0.ingredient.kind == .base && $0.isBlocked == false }))
//            ingredients.filter({ $0.ingredient.kind == .base && $0.isBlocked == false }).random()!
        )
        
//        selection.append(ingredients.filter({ $0.ingredient.kind == .fat && $0.isBlocked == false}).random()!)
        selection.append(randomizer.random(ingredients: ingredients.filter({ $0.ingredient.kind == .fat && $0.isBlocked == false})))

        do {
            var veggies = ingredients.filter({ $0.ingredient.kind == .veggy && $0.isBlocked == false })
            let first = randomizer.random(ingredients: veggies)
            veggies.remove(at: veggies.index(where: { $0.ingredient == first.ingredient })!)
            let second = randomizer.random(ingredients: veggies)
            veggies.remove(at: veggies.index(where: { $0.ingredient == second.ingredient })!)
            let third = randomizer.random(ingredients: veggies)
            selection.append(contentsOf: [first, second, third])
        }
        
        selection.append(ingredients.filter({ $0.ingredient.kind == .protein && $0.isBlocked == false }).random()!)
        
        do {
            var enhancers = ingredients.filter({ $0.isBlocked == false && ($0.ingredient.kind == .fruits || $0.ingredient.kind == .dressing || $0.ingredient.kind == .unexpected) })
            let first = randomizer.random(ingredients: enhancers)
            enhancers.remove(at: enhancers.index(where: { $0.ingredient == first.ingredient })!)
            let second = randomizer.random(ingredients: enhancers)
            selection.append(contentsOf: [first, second])
        }
        
        return selection
    }
    
    private func suggest(_ random: () -> [SWFullIngredient]) -> [SWIngredient] {
        var selections: [(rank: Double, suggestion: [SWFullIngredient])] = []
        for _ in 0..<self.attempts {
            let ingredients = self.random()
            let rank = self.rate(ingredients: ingredients)
            selections.append((rank, ingredients))
            do {
                var logLine = ""
                for j in 0..<ingredients.count {
                    logLine += (j != 0 ? ", " : "") + ingredients[j].ingredient.name
                }
                print("\(rank) = [\(logLine)]")
            }
        }
        let lowest = selections.map({ $0.rank }).min()!
        return selections
            .first(where: { $0.rank == lowest })!
            .suggestion
            .map({ $0.ingredient })
    }
    
    func suggestOne(of kinds: [SWIngredientKinds], for selection: [SWIngredient]) -> SWIngredient {
        let presuggestion = suggest({
            var random = self.random().map({
                return (fullIngredient: $0, replaced: false)
            })
            for existing in selection {
                let existingFullIngredient = (repository.getAll().first(where: { $0.ingredient.id == existing.id }))!
                if let index = random.index(where: {
                    $0.fullIngredient.ingredient.kind == existing.kind && $0.replaced == false
                }) {
                    random[index] = (fullIngredient: existingFullIngredient, replaced: true)
                }
                else {
                    random.append((fullIngredient: existingFullIngredient, replaced: true))
                }
            }
            return random.map({ $0.fullIngredient })
        })
        guard let suggestion = presuggestion.first(where: {
            kinds.contains($0.kind) && !selection.contains($0)
        }) else {
            fatalError("error during suggestOne")
        }
        return suggestion
    }
    
    func suggest() -> [SWIngredient] {
        return suggest({ return self.random() })
    }
}
