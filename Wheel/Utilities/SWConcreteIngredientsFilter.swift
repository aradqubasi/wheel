//
//  SWConcreteIngredientsFilter.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteIngredientsFilter: SWIngredientsFilter {
    
    private let ingredients: SWIngredientRepository
    
    private let options: SWOptionRepository
    
    private let blockings: SWBlockingRepository
    
    init(ingredients: SWIngredientRepository, options: SWOptionRepository, blockings: SWBlockingRepository) {
        self.ingredients = ingredients
        self.options = options
        self.blockings = blockings
    }
    
    func filterByOptionsAnd(by kind: SWIngredientKinds) -> [SWIngredient] {
        var result: [SWIngredient] = []
        ingredients.getAll(by: kind).forEach({ (ingredient) in
            var match = true
            options.getAll().forEach({ (option) in
                if !option.checked {
                    return
                }
                blockings.getAll().forEach({ (blocking) in
                    if option.id != blocking.optionId {
                        return
                    }
                    else if blocking.ingredientId != ingredient.id {
                        return
                    }
                    else {
                        match = false
                    }
                })
            })
            if match {
                result.append(ingredient)
            }
        })
        return result
    }
}
