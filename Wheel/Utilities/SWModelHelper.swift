//
//  SWModelHelper.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWModelHelper {
    
    func getKindComparer() -> (_: SWIngredient, _: SWIngredient) -> Bool
    
}
