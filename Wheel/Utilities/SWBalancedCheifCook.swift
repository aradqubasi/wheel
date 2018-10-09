//
//  SWBalancedCheifCook.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWBalancedCheifCook: SWCheifCook {
    
    private var calloriesPerServing: Double = 333
    
    private var repository: SWFullIngredientRepository
    
    init(ingredients: SWFullIngredientRepository) {
        self.repository = ingredients
    }
    
    private func random() -> [SWFullIngredient] {
        var selection: [SWFullIngredient] = []
        
        let ingredients = repository.getAll()
        
        selection.append(ingredients.filter({ $0.ingredient.kind == .base && $0.isBlocked == false }).random()!)
        
        selection.append(ingredients.filter({ $0.ingredient.kind == .fat && $0.isBlocked == false}).random()!)
        
        do {
            var veggies = ingredients.filter({ $0.ingredient.kind == .veggy && $0.isBlocked == false })
            let first = veggies.random()!
            veggies.remove(at: veggies.index(where: { $0.ingredient == first.ingredient })!)
            let second = veggies.random()!
            selection.append(contentsOf: [first, second])
        }
        
        selection.append(ingredients.filter({ $0.ingredient.kind == .protein && $0.isBlocked == false }).random()!)
        
        do {
            var enhancers = ingredients.filter({ $0.isBlocked == false && ($0.ingredient.kind == .fruits || $0.ingredient.kind == .dressing || $0.ingredient.kind == .unexpected) })
            let first = enhancers.random()!
            enhancers.remove(at: enhancers.index(where: { $0.ingredient == first.ingredient })!)
            let second = enhancers.random()!
            selection.append(contentsOf: [first, second])
        }
        
        return selection
    }
    
    func suggestOne(of kinds: [SWIngredientKinds], for selection: [SWIngredient]) -> SWIngredient {
        
        let ingredients = repository
            .getAll()
        let calories = ingredients.join(with: selection, on: {
            (inner: SWFullIngredient, outer: SWIngredient) -> Bool in
            return inner.ingredient == outer
        }, as: {
            (inner: SWFullIngredient, outer: SWIngredient) -> Double in
            return inner.stats.calories
        }).reduce(0, {
            (prev, current) -> Double in
            return prev + current
        })
        let leftover = self.calloriesPerServing - calories
        let acceptable = ingredients
            .filter({ kinds.contains($0.ingredient.kind) })
            .filter({ $0.stats.calories < leftover })
        if acceptable.count > 0 {
            return acceptable.random()!.ingredient
        }
        else {
            let forced: [SWIngredient] = Array(
                ingredients
                    .filter({ kinds.contains($0.ingredient.kind) })
                    .sorted(by: {
                        (prev, next) -> Bool in
                        return next.stats.calories > prev.stats.calories
                    })
                    .map({ $0.ingredient })
                    .prefix(10))
            return forced.random()!
        }
    }
    
    func suggest() -> [SWIngredient] {
        var match = false
        var counter = 0
        var suggestion: [SWIngredient] = []
        while !match {
            let next = random()
            match = next.map({ $0.stats.calories }).reduce(0, {sum, current in return sum + current}) <= self.calloriesPerServing
            if match {
                suggestion = next.map({ $0.ingredient })
            }
            counter += 1
        }
        print("found in \(counter) attempts")
        return suggestion
    }
}

