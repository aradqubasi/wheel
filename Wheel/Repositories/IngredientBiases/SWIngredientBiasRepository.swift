//
//  SWIngredientBiasRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWIngredientBiasRepository {
    
    func getAll() -> [SWIngredientBias]
    
    func saveOne(_ bias: SWIngredientBias) -> Void
    
}
