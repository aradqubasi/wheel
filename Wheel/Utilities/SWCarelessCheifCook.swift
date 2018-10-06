//
//  SWRandomCookingExpert.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 04/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWCarelessCheifCook: SWCheifCook {
    
    private var repository: SWFullIngredientRepository
    
    init(ingredients: SWFullIngredientRepository) {
        self.repository = ingredients
    }
    
    func suggest() -> [SWIngredient] {
        var selection: [SWIngredient] = []
        
        let ingredients = repository.getAll()
        
        selection.append(ingredients.filter({ $0.ingredient.kind == .base && $0.isBlocked == false }).random()!.ingredient)
        
        selection.append(ingredients.filter({ $0.ingredient.kind == .fat && $0.isBlocked == false}).random()!.ingredient)
        
        do {
            var veggies = ingredients.filter({ $0.ingredient.kind == .veggy && $0.isBlocked == false })
            let first = veggies.random()!.ingredient
            veggies.remove(at: veggies.index(where: { $0.ingredient == first })!)
            let second = veggies.random()!.ingredient
            veggies.remove(at: veggies.index(where: { $0.ingredient == second })!)
            let third = veggies.random()!.ingredient
            selection.append(contentsOf: [first, second, third])
        }
        
        selection.append(ingredients.filter({ $0.ingredient.kind == .protein && $0.isBlocked == false }).random()!.ingredient)
        
        do {
            var enhancers = ingredients.filter({ $0.isBlocked == false && ($0.ingredient.kind == .fruits || $0.ingredient.kind == .dressing || $0.ingredient.kind == .unexpected) })
            let first = enhancers.random()!.ingredient
            enhancers.remove(at: enhancers.index(where: { $0.ingredient == first })!)
            let second = enhancers.random()!.ingredient
            selection.append(contentsOf: [first, second])
        }
        
        return selection
    }
    
    func suggest(_ kind: SWIngredientKinds, for selection: [SWIngredient]) -> SWIngredient {
        
        let ingredient = repository.getAll().filter({ $0.isBlocked == false && $0.ingredient.kind == kind && selection.contains($0.ingredient) == false }).random()!.ingredient
        return ingredient
        
    }
}
