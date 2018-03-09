//
//  SWInmemoryIngredientStatsRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemoryIngredientStatsRepository : SWIngredientStatsRepository {
    
    private static let _stats: [SWIngredientStats] = [
        
    ]
    
    func get(by ingredient: SWIngredient, and measuresment: SWMeasuresment) -> SWIngredientStats {
//        return SWInmemoryIngredientStatsRepository._stats.first(where: { $0.ingredientId == ingredient.id && $0.measuresmentId == measuresment.id })!
        return SWIngredientStats(id: -1, ingredientId: ingredient.id!, measuresmentId: measuresment.id!, proteins: 10, carbohydrates: 10, fats: 10, calories: 100)
    }
    
}
