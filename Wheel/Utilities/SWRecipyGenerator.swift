//
//  SWRecipyGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWRecipyGenerator {
    
    func generate(_ selection: [SWIngredient], servings: Int) -> SWRecipy
    
}
