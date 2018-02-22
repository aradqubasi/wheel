//
//  SWInmemoryBlockingRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 20/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemoryBlockingRepoitory: SWBlockingRepository {
    
    func getAll() -> [SWBlocking] {
        return [
            SWBlocking(id: 1, ingredientId: 23, optionId: 1),
            SWBlocking(id: 2, ingredientId: 24, optionId: 1),
            SWBlocking(id: 3, ingredientId: 26, optionId: 1),
            SWBlocking(id: 4, ingredientId: 29, optionId: 1),
            SWBlocking(id: 5, ingredientId: 37, optionId: 1),
            SWBlocking(id: 6, ingredientId: 23, optionId: 2),
            SWBlocking(id: 7, ingredientId: 24, optionId: 2),
            SWBlocking(id: 8, ingredientId: 26, optionId: 2),
            SWBlocking(id: 9, ingredientId: 29, optionId: 2),
            SWBlocking(id: 10, ingredientId: 36, optionId: 4),
            SWBlocking(id: 11, ingredientId: 36, optionId: 5),
            SWBlocking(id: 12, ingredientId: 37, optionId: 6)
        ]
    }
    
    
    func getAll(by ingredient: SWIngredient) -> [SWBlocking] {
        return self.getAll().filter({ $0.ingredientId == ingredient.id })
    }
    
}
