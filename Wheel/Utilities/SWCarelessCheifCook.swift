//
//  SWRandomCookingExpert.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 04/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWCarelessCheifCook: SWCheifCook {
    
    private let ingredients: SWIngredientRepository
    
    private let measuresments: SWMeasuresmentRepository
    
    private let stats: SWIngredientStats
    
    private let blockings: SWBlockingRepository
    
    init(ingredients: SWIngredientRepository, measuresments: SWMeasuresmentRepository, stats: SWIngredientStats, blockings: SWBlockingRepository) {
        self.ingredients = ingredients
        self.measuresments = measuresments
        self.stats = stats
        self.blockings = blockings
    }
    
    func suggest() -> [SWIngredient] {
//        ingredients.getAll().join(with: measuresments., on: <#T##(SWIngredient, T1) -> Bool#>, as: <#T##(SWIngredient, T1) -> T2#>)
        return []
    }
    
}
