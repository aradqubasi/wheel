//
//  SWIngredientStats.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
struct SWIngredientStats {
    
    let id: Int?
    
    var ingredientId: Int
    
    var measuresmentId: Int

    /**proteins in gramms per measuresment*/
    var proteins: Double

    /**carbohydrates in gramms per measuresment*/
    var carbohydrates: Double

    /**fats in gramms per measuresment*/
    var fats: Double

    /**energy in kcal per measuresment*/
    var calories: Double
    
}
