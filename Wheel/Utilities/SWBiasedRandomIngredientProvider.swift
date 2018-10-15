//
//  SWBiasedRandomIngredientProvider.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWBiasedRandomIngredientProvider: SWRandomIngredientProvider {
    
    func random(ingredients: [SWFullIngredient]) -> SWFullIngredient {
        var range: Double = 0
        let marked = ingredients.map({
            (next) -> (SWFullIngredient, min: Double, max: Double) in
            range += next.bias
            return (next, range - next.bias, range)
        })
        let roll = (Double(arc4random()) / Double(UInt32.max)) * range
        let biased = marked.first(where: { $0.min <= roll && $0.max >= roll })!.0
        return biased
    }
    
}
