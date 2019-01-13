//
//  SWConcreteRecipyListGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWConcreteRecipyListGenerator: SWRecipyListGenerator {
    
    private var _measuresment: SWMeasuresmentRepository!
    
    init(measuresment: SWMeasuresmentRepository) {
        _measuresment = measuresment
    }
    
    func getQuantity(for ingredient: SWIngredient, per servings: Int) -> String {
        let unit = _measuresment.get(by: ingredient.unit)
        // leafs
        if unit.id == 6 {
            return "\(Int(ingredient.quantity) * servings) \(servings == 1 ? unit.short : "leaves")"
        }
        else if unit.id == 7 {
            return "\((CGFloat(ingredient.quantity) * CGFloat(servings)).getFractionString()) \(CGFloat(ingredient.quantity) * CGFloat(servings) == 1 ? unit.short : unit.short + "s")"
        }
        else if unit.id == 8 {
            return "\(Int(ingredient.quantity) * servings) \(servings == 1 ? unit.short : "pieces")"
        }
        else if unit.id == 10 {
            return (CGFloat(ingredient.quantity) * CGFloat(servings)).getFractionString() + " " + unit.short
        }
        else {
            return "\(Int(ingredient.quantity) * servings) \(unit.short)"
        }
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
