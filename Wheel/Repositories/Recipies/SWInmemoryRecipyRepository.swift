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

    func create() -> SWRecipy {
        let next = (SWInmemoryRecipyRepository.recipies.map({ $0.id ?? 0}).max() ?? 0) + 1
        let new = SWRecipy(id: next, name: "", servings: 0, ingredients: [], calories: 0, fats: 0, carbohydrates: 0, proteins: 0, timestamp: Date(), liked: false, photo: nil)
        SWInmemoryRecipyRepository.recipies.append(new)
        return new
    }

}

