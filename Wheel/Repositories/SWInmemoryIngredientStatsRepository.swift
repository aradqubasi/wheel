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
        SWIngredientStats(id: 1, ingredientId: 1, measuresmentId: 6, proteins: 0.3, carbohydrates: 0.9, fats: 0.1, calories: 5),
        SWIngredientStats(id: 2, ingredientId: 2, measuresmentId: 7, proteins: 1, carbohydrates: 2, fats: 0, calories: 10)
    ]

    func get(by ingredient: SWIngredient, and measuresment: SWMeasuresment) -> SWIngredientStats {
        if let stat = SWInmemoryIngredientStatsRepository._stats.first(where: { $0.ingredientId == ingredient.id && $0.measuresmentId == measuresment.id }) {
            return stat
        }
        else {
            return SWIngredientStats(id: -1, ingredientId: ingredient.id!, measuresmentId: measuresment.id!, proteins: 10, carbohydrates: 10, fats: 10, calories: 100)
        }
    }
    
}
