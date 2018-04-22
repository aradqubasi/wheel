//
//  SWProtebaseNameGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 22/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWProtebaseNameGenerator: SWNameGenerator {
    
    func getName(for ingredients: [SWIngredient]) -> String {
        guard let protein = ingredients.first(where: { $0.kind == .protein }) else {
            fatalError("can not generrator name for salad w/o protein")
        }
        guard let base = ingredients.first(where: { $0.kind == .base }) else {
            fatalError("can not generrator name for salad w/o base")
        }
        
        let extra = ingredients.filter({ !($0.kind != . unexpected && $0.kind != .dressing && $0.kind != .fruits) })
        let index = extra.count.random()
        let third = extra[index]
        
        let full = "\(protein.name.capitalized) and \(base.name.capitalized) with \(third.name.capitalized)"

        return full
    }
}
