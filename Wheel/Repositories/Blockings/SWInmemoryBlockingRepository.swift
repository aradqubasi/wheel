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
            SWBlocking(id: 12, ingredientId: 37, optionId: 6),
            SWBlocking(id: 13, ingredientId: 32, optionId: 1),
            SWBlocking(id: 14, ingredientId: 34, optionId: 1),
            SWBlocking(id: 15, ingredientId: 30, optionId: 4),
            SWBlocking(id: 16, ingredientId: 31, optionId: 4),
            SWBlocking(id: 16, ingredientId: 30, optionId: 5),
            SWBlocking(id: 17, ingredientId: 31, optionId: 5),
            SWBlocking(id: 18, ingredientId: 32, optionId: 6),
            SWBlocking(id: 19, ingredientId: 51, optionId: 1),
            SWBlocking(id: 20, ingredientId: 52, optionId: 1),
            SWBlocking(id: 21, ingredientId: 51, optionId: 2),
            SWBlocking(id: 22, ingredientId: 52, optionId: 2),
            SWBlocking(id: 23, ingredientId: 51, optionId: 3),
            SWBlocking(id: 24, ingredientId: 54, optionId: 1),
            SWBlocking(id: 25, ingredientId: 54, optionId: 2),
            SWBlocking(id: 26, ingredientId: 54, optionId: 3),
            
//            SWOption(7, "No fish", of: .block),
            
            SWBlocking(id: 27, ingredientId: 23, optionId: 7), //tuna
            SWBlocking(id: 28, ingredientId: 52, optionId: 7), //salmon
            
//            SWOption(8, "No meat", of: .block),
            
            SWBlocking(id: 29, ingredientId: 51, optionId: 8), //meat
            SWBlocking(id: 30, ingredientId: 54, optionId: 8), //bacon
            
//            SWOption(9, "No gluten", of: .block),
            
            SWBlocking(id: 31, ingredientId: 30, optionId: 9),
            SWBlocking(id: 32, ingredientId: 31, optionId: 9),
            SWBlocking(id: 33, ingredientId: 36, optionId: 9),
            
//            SWOption(10, "No dairy", of: .block),
            
            SWBlocking(id: 34, ingredientId: 32, optionId: 10),
            SWBlocking(id: 35, ingredientId: 37, optionId: 10),
            
//            SWOption(11, "No shellfish", of: .block),
            
            SWBlocking(id: 36, ingredientId: 29, optionId: 11),
            
//            SWOption(12, "No eggs", of: .block)
            
            SWBlocking(id: 37, ingredientId: 24, optionId: 12),
            SWBlocking(id: 38, ingredientId: 26, optionId: 12)
        ]
    }
    
    
    func getAll(by ingredient: SWIngredient) -> [SWBlocking] {
        return self.getAll().filter({ $0.ingredientId == ingredient.id })
    }
    
}
