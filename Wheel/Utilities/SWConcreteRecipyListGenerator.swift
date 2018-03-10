//
//  SWConcreteRecipyListGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteRecipyListGenerator: SWRecipyListGenerator {
    
    private var _measuresment: SWMeasuresmentRepository!
    
    init(measuresment: SWMeasuresmentRepository) {
        _measuresment = measuresment
    }
    
    func getQuantity(for ingredient: SWIngredient, per servings: Int) -> String {
        let unit = _measuresment.get(by: ingredient.unit).short
        return "\(Int(ingredient.quantity) * servings) \(unit)"
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
