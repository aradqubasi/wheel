//
//  SWTipGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 21/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWTipGenerator {
    
    var leafs: Int { get set }

    var fats: Int { get set }

    var proteins: Int { get set }

    var veggies: Int { get set }

    var enhancers: Int { get set }
    
    func getTip(for ingredients: [SWIngredient]) -> String
    
}
