//
//  SWPersistantRecipyRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation

class SWPersistantRecipyRepository: SWPersistantRepository, SWRecipyRepository {

    typealias Repository = SWPersistantRecipyRepository
    
    typealias Entity = SWRecipies
    
    private static var entity: SWRecipies?
    
    private func getEntity() -> SWRecipies {
        if let entity = SWPersistantRecipyRepository.entity {
            return entity
        }
        else {
            guard let entity = self.getEntities().first else {
                let entity = SWRecipies()
                SWPersistantRecipyRepository.entity = entity
                return entity
            }
            SWPersistantRecipyRepository.entity = entity
            return entity
        }
    }
    
    private func setRecipy(_ recipy: SWRecipy) {
        let entity = self.getEntity()
        if let id = recipy.id {
            entity.recipies[id] = recipy
        }
        else if recipy.id == nil {
            let maxId = self.getEntity().recipies.reduce(Int.min, {
                prev, next in
                if let id = next.value.id {
                    if prev < id {
                        return id
                    }
                    else {
                        return prev
                    }
                }
                else {
                    return prev
                }
            })
            entity.recipies[maxId] = SWRecipy(
                id: maxId,
                name: recipy.name,
                servings: recipy.servings,
                ingredients: recipy.ingredients,
                calories: recipy.calories,
                fats: recipy.fats,
                carbohydrates: recipy.carbohydrates,
                proteins: recipy.proteins,
                timestamp: recipy.timestamp,
                liked: recipy.liked
            )
        }
        SWPersistantRecipyRepository.entity = entity
        DispatchQueue.global(qos: .background).async {
            self.setEntities([self.getEntity()])
        }
    }
    
    private func setBookmarkId(_ bookmarkId: Int) {
        let entity = self.getEntity()
        entity.bookmarkRecipyId = bookmarkId
        SWPersistantRecipyRepository.entity = entity
    }
    
    func getBookmark() -> SWRecipy? {
        let entity = self.getEntity()
        if let bookmarkRecipyId = entity.bookmarkRecipyId {
            if let bookmark = entity.recipies[bookmarkRecipyId] {
                return bookmark
            }
            else {
                return nil
            }
        }
        else {
            return nil
        }
    }

    func getAll() -> [SWRecipy] {
        return self.getEntity().recipies.map({ $0.value })
    }
    
    func get(by id: Int) -> SWRecipy? {
        return self.getEntity().recipies[id]
    }
    
    func save(_ recipy: SWRecipy) -> Void {
        self.setRecipy(recipy)
    }
    
    func create() -> SWRecipy {
        let maxId = self.getEntity().recipies.reduce(Int.min, {
            prev, next in
            if let id = next.value.id {
                if prev < id {
                    return id
                }
                else {
                    return prev
                }
            }
            else {
                return prev
            }
            
        })
        let new = SWRecipy(id: maxId + 1, name: "", servings: 0, ingredients: [], calories: 0, fats: 0, carbohydrates: 0, proteins: 0, timestamp: Date(), liked: false/*, photo: nil*/)
        return new
    }
    
    func removeBy(id: Int) -> Void {
        let entity = self.getEntity()
        entity.recipies[id] = nil
        SWPersistantRecipyRepository.entity = entity
        self.setEntities([entity])
    }
    
    func setBookmark(_ recipy: SWRecipy) -> Void {
        if let id = recipy.id {
            self.setBookmarkId(id)
        }
    }

}
