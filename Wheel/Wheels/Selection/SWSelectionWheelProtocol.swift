//
//  SWSelectionWheelProtocol.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWSelectionWheelProtocol {
    
    func push(_ ingredient: SWIngredient)
    
    func push(_ floatables: [Floatable])
    
    func pop(_ ingredient: SWIngredient)
    
    func getFocusedKind() -> [SWIngredientKinds]
    
    func getFocusedIngredient() -> SWIngredient?
    
}
