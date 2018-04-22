//
//  SWTipGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 21/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWTipGenerator {
    
    func getTip(for ingredients: [SWIngredient]) -> String
    
}
