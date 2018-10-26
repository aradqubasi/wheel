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
        SWIngredientStats(id: 14, ingredientId: 10, measuresmentId: 8 /*pieces*/, proteins: 0.2, carbohydrates: 0.5, fats: 0.7, calories: 9),
        SWIngredientStats(id: 15, ingredientId: 10, measuresmentId: 4 /*100g*/, proteins: 18.22, carbohydrates: 30.19, fats: 43.85, calories: 553),
        //avocado
        SWIngredientStats(id: 16, ingredientId: 11, measuresmentId: 8 /*pieces*/, proteins: 4.02, carbohydrates: 17.15, fats: 29.47, calories: 322),
        SWIngredientStats(id: 17, ingredientId: 11, measuresmentId: 4 /*100g*/, proteins: 2, carbohydrates: 8.53, fats: 14.66, calories: 160),
        //peanut
        SWIngredientStats(id: 18, ingredientId: 12, measuresmentId: 9 /*ounce*/, proteins: 7.848, carbohydrates: 4.272, fats: 14.704, calories: 168),
        SWIngredientStats(id: 19, ingredientId: 12, measuresmentId: 1 /*g*/, proteins: 28.03 * 0.01, carbohydrates: 15.26 * 0.01, fats: 52.5 * 0.01, calories: 599 * 0.01),
        SWIngredientStats(id: 19, ingredientId: 12, measuresmentId: 4 /*100g*/, proteins: 28.03, carbohydrates: 15.26, fats: 52.5, calories: 599),
        //aubergine(eggplant)
        SWIngredientStats(id: 20, ingredientId: 13, measuresmentId: 7 /*cup*/, proteins: 0.83, carbohydrates: 4.67, fats: 0.16, calories: 20),
        SWIngredientStats(id: 21, ingredientId: 13, measuresmentId: 4 /*100g*/, proteins: 1.01, carbohydrates: 5.7, fats: 0.19, calories: 24),
        //tomato
        SWIngredientStats(id: 21, ingredientId: 14, measuresmentId: 8 /*piece 1 medium 2-3/5"*/, proteins: 1.08, carbohydrates: 4.82, fats: 0.25, calories: 22),
        SWIngredientStats(id: 22, ingredientId: 14, measuresmentId: 4 /*100g*/, proteins: 0.88, carbohydrates: 3.92, fats: 0.2, calories: 18),
        //radish
        SWIngredientStats(id: 23, ingredientId: 15, measuresmentId: 7 /*cup*/, proteins: 0.79, carbohydrates: 3.94, fats: 0.12, calories: 19),
        SWIngredientStats(id: 24, ingredientId: 15, measuresmentId: 4 /*100g*/, proteins: 0.68, carbohydrates: 3.4, fats: 0.1, calories: 16),
        //pepper
        SWIngredientStats(id: 25, ingredientId: 16, measuresmentId: 10 /*1 medium 2-3/4" long 2-1/2" dia*/, proteins: 1.18, carbohydrates: 7.18, fats: 0.36, calories: 31),
        SWIngredientStats(id: 26, ingredientId: 16, measuresmentId: 4 /*100g*/, proteins: 0.99, carbohydrates: 6.03, fats: 0.3, calories: 26),
        //broccoli
        SWIngredientStats(id: 27, ingredientId: 17, measuresmentId: 7 /*cup*/, proteins: 2.57, carbohydrates: 6.04, fats: 0.34, calories: 31),
        SWIngredientStats(id: 28, ingredientId: 17, measuresmentId: 4 /*100g*/, proteins: 2.82, carbohydrates: 6.64, fats: 0.37, calories: 34),
        //carrot
        SWIngredientStats(id: 29, ingredientId: 18, measuresmentId: 7 /*cup*/, proteins: 1.19, carbohydrates: 12.26, fats: 0.31, calories: 52),
        SWIngredientStats(id: 30, ingredientId: 18, measuresmentId: 4 /*100g*/, proteins: 0.93, carbohydrates: 9.58, fats: 0.24, calories: 41),
        //asparagus
        SWIngredientStats(id: 31, ingredientId: 19, measuresmentId: 7 /*cup*/, proteins: 2.95, carbohydrates: 5.2, fats: 0.16, calories: 27),
        SWIngredientStats(id: 32, ingredientId: 19, measuresmentId: 4 /*100g*/, proteins: 2.2, carbohydrates: 3.88, fats: 0.12, calories: 20),
        //cauliflower
        SWIngredientStats(id: 33, ingredientId: 20, measuresmentId: 7 /*cup*/, proteins: 1.98, carbohydrates: 5.3, fats: 0.1, calories: 25),
        SWIngredientStats(id: 34, ingredientId: 20, measuresmentId: 4 /*100g*/, proteins: 1.98, carbohydrates: 5.3, fats: 0.1, calories: 25),
        //corn (canned)
        SWIngredientStats(id: 35, ingredientId: 21, measuresmentId: 9 /*ounce*/, proteins: 0.51, carbohydrates: 3.63, fats: 0.63, calories: 20),
        SWIngredientStats(id: 36, ingredientId: 21, measuresmentId: 1 /*g*/, proteins: 2.55 * 0.01, carbohydrates: 18.13 * 0.01, fats: 3.17 * 0.01, calories: 98 * 0.01),
        SWIngredientStats(id: 36, ingredientId: 21, measuresmentId: 4 /*100g*/, proteins: 2.55, carbohydrates: 18.13, fats: 3.17, calories: 98),
        //chickpeas
        SWIngredientStats(id: 37, ingredientId: 22, measuresmentId: 7 /*cup 250ml*/, proteins: 11, carbohydrates: 34, fats: 3, calories: 210),
        //fish(tuna)
        SWIngredientStats(id: 38, ingredientId: 23, measuresmentId: 1 /*gram*/, proteins: 0.2338, carbohydrates: 0, fats: 0.0095, calories: 1.08),
        SWIngredientStats(id: 39, ingredientId: 23, measuresmentId: 4 /*100g*/, proteins: 23.38, carbohydrates: 0, fats: 0.95, calories: 108),
        //boiledegg
        SWIngredientStats(id: 40, ingredientId: 24, measuresmentId: 10 /*medium*/, proteins: 5.51, carbohydrates: 0.49, fats: 4.65, calories: 68),
        SWIngredientStats(id: 41, ingredientId: 24, measuresmentId: 4 /*100g*/, proteins: 12.53, carbohydrates: 1.12, fats: 10.57, calories: 154),
        //beans (baked)
        SWIngredientStats(id: 42, ingredientId: 25, measuresmentId: 9 /*ounce*/, proteins: 1.57, carbohydrates: 6.06, fats: 1.46, calories: 43),
        SWIngredientStats(id: 43, ingredientId: 25, measuresmentId: 4 /*100g*/, proteins: 5.54, carbohydrates: 21.39, fats: 5.15, calories: 151),
        SWIngredientStats(id: 43, ingredientId: 25, measuresmentId: 1 /*g*/, proteins: 5.54 * 0.01, carbohydrates: 21.39 * 0.01, fats: 5.15 * 0.01, calories: 151 * 0.01),
        //friedegg
        SWIngredientStats(id: 44, ingredientId: 26, measuresmentId: 10 /*medium*/, proteins: 5.42, carbohydrates: 0.37, fats: 5.88, calories: 78),
        SWIngredientStats(id: 45, ingredientId: 26, measuresmentId: 4 /*100g*/, proteins: 13.56, carbohydrates: 0.93, fats: 14.69, calories: 194),
        //lentils (Goya)
        SWIngredientStats(id: 46, ingredientId: 27, measuresmentId: 3 /*medium*/, proteins: 1.1, carbohydrates: 2.5, fats: 0, calories: 12),
        //mushrooms
        SWIngredientStats(id: 47, ingredientId: 28, measuresmentId: 7 /*cup*/, proteins: 2.16, carbohydrates: 2.3, fats: 0.24, calories: 15),
        SWIngredientStats(id: 48, ingredientId: 28, measuresmentId: 4 /*100g*/, proteins: 3.09, carbohydrates: 3.28, fats: 0.34, calories: 22),
        //shrimp
        SWIngredientStats(id: 49, ingredientId: 29, measuresmentId: 10 /*medium*/, proteins: 2.83333, carbohydrates: 0, fats: 0, calories: 11.66667),
        //mustard
        SWIngredientStats(id: 50, ingredientId: 30, measuresmentId: 3 /*tbsp*/, proteins: 0.2, carbohydrates: 0.39, fats: 0.16, calories: 3),
        SWIngredientStats(id: 51, ingredientId: 30, measuresmentId: 4 /*100g*/, proteins: 3.95, carbohydrates: 7.78, fats: 3.11, calories: 66),
        //tahini
        SWIngredientStats(id: 52, ingredientId: 31, measuresmentId: 3 /*tbsp*/, proteins: 2.5, carbohydrates: 3, fats: 8, calories: 85),
        //yogurt
        SWIngredientStats(id: 53, ingredientId: 32, measuresmentId: 9 /*ounce*/, proteins: 0.625, carbohydrates: 0.75, fats: 0.36, calories: 31),
        SWIngredientStats(id: 53, ingredientId: 32, measuresmentId: 1 /*g*/, proteins: 0.625 * 0.2835, carbohydrates: 0.75 * 0.2835, fats: 0.36 * 0.2835, calories: 31 * 0.2835),
        //vinaigrette
        SWIngredientStats(id: 54, ingredientId: 33, measuresmentId: 3 /*tbsp*/, proteins: 0.06, carbohydrates: 1.53, fats: 4.17, calories: 43),
        SWIngredientStats(id: 55, ingredientId: 33, measuresmentId: 4 /*100g*/, proteins: 0.38, carbohydrates: 10.43, fats: 28.37, calories: 291),
        //honey
        SWIngredientStats(id: 56, ingredientId: 34, measuresmentId: 3 /*tbsp*/, proteins: 0.06, carbohydrates: 17.3, fats: 0, calories: 64),
        SWIngredientStats(id: 57, ingredientId: 34, measuresmentId: 4 /*100g*/, proteins: 0.3, carbohydrates: 82.4, fats: 0, calories: 304),
        //olive oil
        SWIngredientStats(id: 58, ingredientId: 35, measuresmentId: 3 /*tbsp*/, proteins: 0, carbohydrates: 0, fats: 13.5, calories: 119),
        SWIngredientStats(id: 59, ingredientId: 35, measuresmentId: 4 /*100g*/, proteins: 0, carbohydrates: 0, fats: 100, calories: 884),
        //cooked grains (rice)
        SWIngredientStats(id: 60, ingredientId: 36, measuresmentId: 7 /*cup*/, proteins: 4.17, carbohydrates: 43.57, fats: 1.69, calories: 213),
        SWIngredientStats(id: 61, ingredientId: 36, measuresmentId: 4 /*100g*/, proteins: 2.64, carbohydrates: 27.64, fats: 1.07, calories: 135),
        //cottage cheese
        SWIngredientStats(id: 62, ingredientId: 37, measuresmentId: 9 /*ounce*/, proteins: 3.5275, carbohydrates: 0.7575, fats: 1.275, calories: 29),
        SWIngredientStats(id: 63, ingredientId: 37, measuresmentId: 1 /*g*/, proteins: 12.49 * 0.01, carbohydrates: 2.68 * 0.01, fats: 4.51 * 0.01, calories: 103 * 0.01),
        SWIngredientStats(id: 63, ingredientId: 37, measuresmentId: 4 /*100g*/, proteins: 12.49, carbohydrates: 2.68, fats: 4.51, calories: 103),
        //hot pepper
        SWIngredientStats(id: 64, ingredientId: 38, measuresmentId: 10 /*medium*/, proteins: 0.84, carbohydrates: 3.96, fats: 0.2, calories: 18),
        SWIngredientStats(id: 65, ingredientId: 38, measuresmentId: 4 /*100g*/, proteins: 1.87, carbohydrates: 8.81, fats: 0.44, calories: 40),
        //olives (green)
        SWIngredientStats(id: 66, ingredientId: 39, measuresmentId: 10 /*medium*/, proteins: 0.035, carbohydrates: 0.131, fats: 0.521, calories: 4.9),
        SWIngredientStats(id: 67, ingredientId: 39, measuresmentId: 4 /*100g*/, proteins: 1.03, carbohydrates: 3.84, fats: 15.32, calories: 145),
        //onion
        SWIngredientStats(id: 68, ingredientId: 40, measuresmentId: 11 /*slice*/, proteins: 0.08, carbohydrates: 0.91, fats: 0.01, calories: 4),
        SWIngredientStats(id: 69, ingredientId: 40, measuresmentId: 4 /*100g*/, proteins: 0.92, carbohydrates: 10.11, fats: 0.08, calories: 42),
        //pickled veggies
        SWIngredientStats(id: 70, ingredientId: 41, measuresmentId: 10 /*medium*/, proteins: 0.4, carbohydrates: 2.68, fats: 0.12, calories: 12),
        SWIngredientStats(id: 71, ingredientId: 41, measuresmentId: 4 /*100g*/, proteins: 0.62, carbohydrates: 4.12, fats: 0.19, calories: 18),
        //apple
        SWIngredientStats(id: 72, ingredientId: 42, measuresmentId: 10 /*medium*/, proteins: 0.36, carbohydrates: 19.06, fats: 0.23, calories: 72),
        SWIngredientStats(id: 73, ingredientId: 42, measuresmentId: 4 /*100g*/, proteins: 0.26, carbohydrates: 13.81, fats: 0.17, calories: 52),
        //blueberry
        SWIngredientStats(id: 74, ingredientId: 43, measuresmentId: 9 /*ounce*/, proteins: 0.21, carbohydrates: 4.11, fats: 0.09, calories: 16),
        SWIngredientStats(id: 75, ingredientId: 43, measuresmentId: 1 /*g*/, proteins: 0.74 * 0.01, carbohydrates: 14.49 * 0.01, fats: 0.33 * 0.01, calories: 57 * 0.01),
        SWIngredientStats(id: 75, ingredientId: 43, measuresmentId: 4 /*100g*/, proteins: 0.74, carbohydrates: 14.49, fats: 0.33, calories: 57),
        //orange
        SWIngredientStats(id: 76, ingredientId: 44, measuresmentId: 10 /*2-5/8"*/, proteins: 1.23, carbohydrates: 15.39, fats: 0.16, calories: 62),
        SWIngredientStats(id: 77, ingredientId: 44, measuresmentId: 4 /*100g*/, proteins: 0.94, carbohydrates: 11.75, fats: 0.12, calories: 47),
        //grapefruit
        //SWIngredientStats(id: 78, ingredientId: 45, measuresmentId: 10 /*4"*/, proteins: 0.81, carbohydrates: 10.34, fats: 0.13, calories: 41),
        //SWIngredientStats(id: 79, ingredientId: 45, measuresmentId: 4 /*100g*/, proteins: 0.63, carbohydrates: 8.08, fats: 0.1, calories: 32),
        //grapes
        SWIngredientStats(id: 80, ingredientId: 46, measuresmentId: 9 /*ounce*/, proteins: 0.19, carbohydrates: 4.89, fats: 0.04, calories: 19),
        SWIngredientStats(id: 81, ingredientId: 46, measuresmentId: 4 /*100g*/, proteins: 0.72, carbohydrates: 18.1, fats: 0.16, calories: 69),
        //watermelon
        //SWIngredientStats(id: 82, ingredientId: 47, measuresmentId: 12 /*cubes*/, proteins: 0.74, carbohydrates: 9.21, fats: 0.18, calories: 37),
        //SWIngredientStats(id: 83, ingredientId: 47, measuresmentId: 4 /*100g*/, proteins: 0.61, carbohydrates: 7.55, fats: 0.15, calories: 30),
        //pistachio
        SWIngredientStats(id: 84, ingredientId: 48, measuresmentId: 9 /*ounce*/, proteins: 5.84, carbohydrates: 7.93, fats: 12.6, calories: 158),
        SWIngredientStats(id: 85, ingredientId: 48, measuresmentId: 4 /*100g*/, proteins: 20.61, carbohydrates: 27.97, fats: 44.44, calories: 557),
        //pomegranate
        SWIngredientStats(id: 86, ingredientId: 49, measuresmentId: 10 /*medium*/, proteins: 1.46, carbohydrates: 26.44, fats: 0.46, calories: 105),
        SWIngredientStats(id: 87, ingredientId: 49, measuresmentId: 4 /*100g*/, proteins: 0.95, carbohydrates: 17.17, fats: 0.3, calories: 68),
        //lemon juice
        SWIngredientStats(id: 88, ingredientId: 50, measuresmentId: 10 /*medium lemon yields*/, proteins: 0.18, carbohydrates: 4.06, fats: 0, calories: 12),
        SWIngredientStats(id: 89, ingredientId: 50, measuresmentId: 4 /*100g*/, proteins: 0.38, carbohydrates: 8.63, fats: 0, calories: 25),
        //meat
        SWIngredientStats(id: 90, ingredientId: 51, measuresmentId: 1 /*gram*/, proteins: 0.2641, carbohydrates: 0, fats: 0.1929, calories: 2.87),
        SWIngredientStats(id: 91, ingredientId: 51, measuresmentId: 4 /*100g*/, proteins: 26.41, carbohydrates: 0, fats: 19.29, calories: 287),
        //salmon
        SWIngredientStats(id: 92, ingredientId: 52, measuresmentId: 1 /*gram*/, proteins: 0.2162, carbohydrates: 0, fats: 0.0593, calories: 1.46),
        SWIngredientStats(id: 93, ingredientId: 52, measuresmentId: 4 /*100g*/, proteins: 21.62, carbohydrates: 0, fats: 5.93, calories: 146),
        //cucumber
        SWIngredientStats(id: 94, ingredientId: 53, measuresmentId: 7 /*cup ±50g*/, proteins: 0.7 * 0.5, carbohydrates: 1.5 * 0.5, fats: 0.1 * 0.5, calories: 10 * 0.5),
        SWIngredientStats(id: 95, ingredientId: 53, measuresmentId: 4 /*100g*/, proteins: 0.7, carbohydrates: 1.5, fats: 0.1, calories: 10),
        //bacon
        SWIngredientStats(id: 96, ingredientId: 54, measuresmentId: 11 /*slice ±8g*/, proteins: 37 * 0.08, carbohydrates: 1.4 * 0.08, fats: 42 * 0.08, calories: 541 * 0.08),
        SWIngredientStats(id: 97, ingredientId: 54, measuresmentId: 4 /*100g*/, proteins: 37, carbohydrates: 1.4, fats: 42, calories: 541)
    ]

    func get(by ingredient: SWIngredient, and measuresment: SWMeasuresment) -> SWIngredientStats {
        if let stat = SWInmemoryIngredientStatsRepository._stats.first(where: { $0.ingredientId == ingredient.id && $0.measuresmentId == measuresment.id }) {
            return stat
        }
        else {
            return SWIngredientStats(id: -1, ingredientId: ingredient.id!, measuresmentId: measuresment.id!, proteins: 10, carbohydrates: 10, fats: 10, calories: 100)
        }
    }
    
    func getAll() -> [SWIngredientStats] {
        var all: [SWIngredientStats] = []
        all.append(contentsOf: SWInmemoryIngredientStatsRepository._stats)
        return all
    }
    
}
