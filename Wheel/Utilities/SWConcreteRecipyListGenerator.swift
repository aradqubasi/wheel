//
//  SWConcreteRecipyListGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteRecipyListGenerator: SWRecipyListGenerator {
    
    func getQuantity(for ingredient: SWIngredient, per servings: Int) -> String {
        return "\(50 * servings) g"
    }
    
    func getName(for ingredient: SWIngredient) -> String {
        return ingredient.name
    }
    
    func getKind(for ingredient: SWIngredient) -> String {
        switch ingredient.kind {
        case .base: return "BASE"
        case .fat: return "FAT"
        case .veggy: return "VEGGY"
        case .protein: return "PROTEIN"
        case .dressing: return "DRESSING"
        case .unexpected: return "UNEXPECTED"
        case .fruits: return "FRUITS"
        }
    }
    
}
