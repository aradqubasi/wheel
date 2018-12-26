//
//  SWConcreteIngredientsFilter.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteIngredientsFilter: SWIngredientsFilter {
    
    private let ingredients: SWFullIngredientRepository
    
    init(ingredients: SWFullIngredientRepository) {
        self.ingredients = ingredients
    }
    
    func filterByOptionsAnd(by kind: SWIngredientKinds) -> [SWIngredient] {
        let result = ingredients.get(by: { $0 == kind })
        return result.filter({ !$0.isBlocked }).map({ $0.ingredient })
    }
}
