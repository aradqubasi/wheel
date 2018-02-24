//
//  SWNameGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWNameGenerator {
    
    func getName(for ingredients: [SWIngredient]) -> String
    
}
