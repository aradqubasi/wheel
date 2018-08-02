//
//  SWConcreteTipGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 21/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteTipGenerator: SWTipGenerator {
    
    var leafs: Int = 1
    
    var fats: Int = 1
    
    var proteins: Int = 1
    
    var veggies: Int = 1
    
    var enhancers: Int = 1
    
    func getTip(for ingredients: [SWIngredient]) -> String {
        var tips: [String] = []
        if ingredients.filter({ $0.kind == .base }).count < self.leafs {
            tips.append("Add leafy green from bases")
        }
        if ingredients.filter({ $0.kind == .protein }).count < self.proteins {
            tips.append("Add proteins")
        }
        if ingredients.filter({ $0.kind == .fat }).count < self.fats {
            tips.append("Add healthy fats")
        }
        if ingredients.filter({ $0.kind == .veggy }).count < self.veggies {
            tips.append("Put some veggies")
        }
        if ingredients.filter({ $0.kind == .fruits || $0.kind == .dressing || $0.kind == .unexpected }).count < self.enhancers {
            tips.append("Spice up your salad with special ingredient")
        }
        return tips.random() ?? "Your salad looks OK"
    }
    
}
