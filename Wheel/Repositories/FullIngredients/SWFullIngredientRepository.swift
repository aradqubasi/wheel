//
//  SWFullIngredientRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 04/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWFullIngredientRepository {
    
    func getAll() -> [SWFullIngredient]
    
    func get(by predicate: (_:SWIngredientKinds) -> Bool) -> [SWFullIngredient]
    
}
