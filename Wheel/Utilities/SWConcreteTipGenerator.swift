//
//  SWConcreteTipGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 21/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteTipGenerator: SWTipGenerator {
    
    func getTip(for ingredients: [SWIngredient]) -> String {
        let bases = ingredients.filter({ $0.kind == .base })
        let proteins = ingredients.filter({ $0.kind == .protein })
        let fats = ingredients.filter({ $0.kind == .fat })
        let veggies = ingredients.filter({ $0.kind == .veggy })
        if bases.count + proteins.count + fats.count + veggies.count < 3 {
            return "Add more ingredients! Your plate is almost empty"
        }
        else if bases.count + proteins.count + fats.count + veggies.count == 3 {
            if bases.count == 0 {
                return "Add leafy green from bases"
            }
            else if proteins.count == 0 {
                return "Add proteins"
            }
            else if fats.count == 0 {
                return "Add healthy fats"
            }
            else if  veggies.count == 0 {
                return "Put some veggies"
            }
        }
        else {
            return "Spice up your salad with special ingredient"
        }
        fatalError("Could not generate tips for selection")
    }
    
}
