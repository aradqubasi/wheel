//
//  SWRecipyListGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWRecipyListGenerator {
    
    func getQuantity(for ingredient: SWIngredient, per servings: Int) -> String
    
    func getName(for ingredient: SWIngredient) -> String
    
    func getKind(for ingredient: SWIngredient) -> String
    
}
