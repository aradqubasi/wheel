//
//  SWIngredientsFilter.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation

protocol SWIngredientsFilter {
    
    func filterByOptionsAnd(by kind: SWIngredientKinds) -> [SWIngredient]
    
}
