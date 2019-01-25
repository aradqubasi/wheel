//
//  SWBalancedCheifCook.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWBalancedCheifCook: SWCheifCook {
    
    private let attempts = 100
    
    private var dailyCalories: Double {
        get {
            return diet.get().dailyEnergyIntake
        }
    }
    
    private var energyByServingByDayHour: [(start: Int, end: Int, share: Double)] {
        get {
            let diet = self.diet.get()
            return [
                (0, 10, diet.morningEnergyIntakeShare),
                (11, 19, diet.middayEnergyIntakeShare),
                (20, 24, diet.eveningEnergyIntakeShare)
            ]
        }
    }
    
    private var energyByNutrient: (carbohydrates: Double, proteins: Double, fats: Double) {
        get {
            let diet = self.diet.get()
            return (
                diet.carbohydratesDailyShare,
                diet.proteinsDailyShare,
                diet.fatsDailyShare
            )
        }
    }
    
    private var repository: SWFullIngredientRepository
    
    private var randomizer: SWRandomIngredientProvider
    
    private var diet: SWDietSettingsRepository
    
    init(ingredients: SWFullIngredientRepository, randomizer: SWRandomIngredientProvider, diet: SWDietSettingsRepository) {
        self.repository = ingredients
        self.diet = diet
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
        guard let shareByHours = energyByServingByDayHour.first(where: { hour >= $0.start && hour <= $0.end }) else {
            fatalError("hour \(hour) is out of bounds 0..<24")
        }
        let mealEnergyShare = shareByHours.share
        let expected = [
            energyByNutrient.fats * mealEnergyShare,
            energyByNutrient.proteins * mealEnergyShare,
            energyByNutrient.carbohydrates * mealEnergyShare
        ]
        let actual = [
            stats.fats / dailyCalories,
            stats.proteins / dailyCalories,
            stats.carbohydrates / dailyCalories
        ]
        let rank = getRaeIndex(actual: actual, expected: expected)
        return rank
    }
    
    private func random(from ingredients: [SWFullIngredient]) -> [SWFullIngredient] {
        var selection: [SWFullIngredient] = []

        selection.append(
            randomizer.random(ingredients: ingredients.filter({ $0.ingredient.kind == .base && $0.isBlocked == false }))
        )
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
            let ingredients = random()
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
        let ingredients = repository.getAll()
        let randomizer = self.random(excluding: selection)
        let presuggestion = suggest({
            var random = randomizer().map({
                return (fullIngredient: $0, replaced: false)
            })
            for existing in selection {
                let existingFullIngredient = (ingredients.first(where: { $0.ingredient.id == existing.id }))!
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
    
    private func random(excluding exceptions: [SWIngredient]) -> () -> [SWFullIngredient] {
        let ingredients = self.repository.getAll().filter({ return !exceptions.contains($0.ingredient) })
        return {
            () -> [SWFullIngredient] in
            return self.random(from: ingredients)
        }
    }
    
    func suggest() -> [SWIngredient] {
        return suggest(self.random(excluding: []))
    }
}

