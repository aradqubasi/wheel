//
//  SWCookingExpert.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 04/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWCheifCook {
    
    func suggest() -> [SWIngredient]
    
    func suggestOne(of kinds: [SWIngredientKinds], for selection: [SWIngredient]) -> SWIngredient
    
}
