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
        SWIngredientStats(id: 11, ingredientId: 8, measuresmentId: 4 /*100g*/, proteins: 18.29, carbohydrates: 28.88, fats: 42.16, calories: 534),
        //brazilnut
        SWIngredientStats(id: 12, ingredientId: 9, measuresmentId: 8 /*pieces*/, proteins: 0.66, carbohydrates: 0.5, fats: 2.33, calories: 33.33),
        SWIngredientStats(id: 13, ingredientId: 9, measuresmentId: 4 /*100g*/, proteins: 14.28, carbohydrates: 10.71, fats: 50, calories: 714),
        //cashewnut
        SWIngredientStats(id: 14, ingredientId: 10, measuresmentId: 9 /*ounce*/, proteins: 5.17, carbohydrates: 8.56, fats: 12.43, calories: 157),
        SWIngredientStats(id: 15, ingredientId: 10, measuresmentId: 4 /*100g*/, proteins: 18.22, carbohydrates: 30.19, fats: 43.85, calories: 553),
        //avocado
        SWIngredientStats(id: 16, ingredientId: 11, measuresmentId: 8 /*pieces*/, proteins: 4.02, carbohydrates: 17.15, fats: 29.47, calories: 322),
        SWIngredientStats(id: 17, ingredientId: 11, measuresmentId: 4 /*100g*/, proteins: 2, carbohydrates: 8.53, fats: 14.66, calories: 160),
        //peanut
        SWIngredientStats(id: 18, ingredientId: 12, measuresmentId: 9 /*ounce*/, proteins: 7.848, carbohydrates: 4.272, fats: 14.704, calories: 168),
        SWIngredientStats(id: 19, ingredientId: 12, measuresmentId: 4 /*100g*/, proteins: 28.03, carbohydrates: 15.26, fats: 52.5, calories: 599),
        //aubergine(eggplant)
        SWIngredientStats(id: 20, ingredientId: 13, measuresmentId: 7 /*cup*/, proteins: 0.83, carbohydrates: 4.67, fats: 0.16, calories: 20),
        SWIngredientStats(id: 21, ingredientId: 13, measuresmentId: 4 /*100g*/, proteins: 1.01, carbohydrates: 5.7, fats: 0.19, calories: 24),
        //tomato
        SWIngredientStats(id: 21, ingredientId: 14, measuresmentId: 8 /*piece 1 medium 2-3/5"*/, proteins: 1.08, carbohydrates: 4.82, fats: 0.25, calories: 22),
        SWIngredientStats(id: 22, ingredientId: 14, measuresmentId: 4 /*100g*/, proteins: 0.88, carbohydrates: 3.92, fats: 0.2, calories: 18)
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
