//
//  SWConcreteNameGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteNameGenerator: SWNameGenerator {
    
    func getName(for ingredients: [SWIngredient]) -> String {
        var usual = ingredients.filter({ !($0.kind != .base && $0.kind != .fat && $0.kind != .veggy && $0.kind != .protein) })
        let extra = ingredients.filter({ !($0.kind != . unexpected && $0.kind != .dressing && $0.kind != .fruits) })
        
        var index = usual.count.random()
        let first = usual[index]
        usual.remove(at: index)
        
        index = usual.count.random()
        let second = usual[index]
        usual.remove(at: index)
        
        index = extra.count.random()
        let third = extra[index]
        
        return "\(first.name.capitalized) and \(second.name.capitalized) with \(third.name.capitalized)"
    }
    
}
