//
//  SWServingsCaptionGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWServingsGenerator {
    
    func getCaption(for quantity: Int) -> String
    
    func getEnergy(for selection: [SWIngredient], per servings: Int) -> Double
    
    func getFats(for selection: [SWIngredient], per servings: Int) -> Double
    
    func getProteins(for selection: [SWIngredient], per servings: Int) -> Double
    
    func getCarbs(for selection: [SWIngredient], per servings: Int) -> Double
    
}
