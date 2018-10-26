//
//  SWBlockingsRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 20/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWBlockingRepository {
    
    func getAll() -> [SWBlocking]
    
    func getAll(by ingredient: SWIngredient) -> [SWBlocking]
    
}
