//
//  SWInmemoryRecipyRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemoryRecipyRepository: SWRecipyRepository {
    
    private static var recipies: [SWRecipy] = []
    
    func getAll() -> [SWRecipy] {
        return SWInmemoryRecipyRepository.recipies
    }
    
    func get(by id: Int) -> SWRecipy? {
        return SWInmemoryRecipyRepository.recipies.first(where: { $0.id == id })
    }
    
    func save(_ recipy: SWRecipy) -> Void {
        if let index = SWInmemoryRecipyRepository.recipies.index(where: { $0.id == recipy.id }) {
            SWInmemoryRecipyRepository.recipies[index] = recipy
        }
    }
    
    func create(_ recipy: SWRecipy) -> SWRecipy {
        let next = (SWInmemoryRecipyRepository.recipies.map({ $0.id ?? 0}).max() ?? 0) + 1
        let new = SWRecipy(id: next, name: recipy.name, servings: recipy.servings)
        SWInmemoryRecipyRepository.recipies.append(new)
        return new
    }
    
}
