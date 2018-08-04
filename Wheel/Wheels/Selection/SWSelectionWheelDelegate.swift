//
//  SWSelectionWheelDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWSelectionWheelDelegate {
    
    func onKindSwitched(from prev: SWIngredientKinds, to next: SWIngredientKinds)
    
    func onCook()
    
    func onTriggerRandomIngredient(of kind: [SWIngredientKinds])
    
}
