//
//  SWIngredientsRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWIngredientRepository {
    
    func getAll() -> [SWIngredient]
    
    func getAll(by kind: SWIngredientKinds) -> [SWIngredient]
    
    func get(by name: String) -> SWIngredient?
    
}
