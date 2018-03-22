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
        SWIngredientStats(id: 2, ingredientId: 2, measuresmentId: 7, proteins: 1, carbohydrates: 2, fats: 0, calories: 10),
        SWIngredientStats(id: 3, ingredientId: 3, measuresmentId: 6, proteins: 1.28, carbohydrates: 4.97, fats: 0.11, calories: 21),
        //lettuce
        SWIngredientStats(id: 4, ingredientId: 4, measuresmentId: 7, proteins: 0.5, carbohydrates: 1.63, fats: 0.08, calories: 8),
        //spinach
        SWIngredientStats(id: 5, ingredientId: 5, measuresmentId: 4 /*100g*/, proteins: 2.86, carbohydrates: 3.63, fats: 0.39, calories: 23),
        SWIngredientStats(id: 6, ingredientId: 5, measuresmentId: 7 /*cup*/, proteins: 0.86, carbohydrates: 1.09, fats: 0.12, calories: 7),
        //coconut
        SWIngredientStats(id: 7, ingredientId: 6, measuresmentId: 4 /*100g*/, proteins: 3.33, carbohydrates: 15.23, fats: 33.49, calories: 354),
        SWIngredientStats(id: 8, ingredientId: 6, measuresmentId: 8 /*piece 2" x 2" x 1/2"*/, proteins: 1.5, carbohydrates: 6.85, fats: 15.07, calories: 159),
        //hazelnut
        SWIngredientStats(id: 9, ingredientId: 7, measuresmentId: 1 /*g*/, proteins: 0.17, carbohydrates: 0.17, fats: 0.55, calories: 5.88),
        //seeds (flaxseed)
        SWIngredientStats(id: 10, ingredientId: 8, measuresmentId: 3 /*table spoon*/, proteins: 1.88, carbohydrates: 2.97, fats: 4.34, calories: 55),
        SWIngredientStats(id: 11, ingredientId: 8, measuresmentId: 4 /*100g*/, proteins: 18.29, carbohydrates: 28.88, fats: 42.16, calories: 534)
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
