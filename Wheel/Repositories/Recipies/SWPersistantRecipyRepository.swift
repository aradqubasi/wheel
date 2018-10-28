//
//  SWPersistantRecipyRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation

class SWPersistantRecipyRepository: SWRecipyRepository {
    
    private static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private static let ArchiveUrl = DocumentsDirectory.appendingPathComponent(String(describing: SWPersistantRecipyRepository.self))
    
    private func getRaw() -> String {
        let jsons = (NSKeyedUnarchiver.unarchiveObject(withFile: SWPersistantRecipyRepository.ArchiveUrl.path) as? String) ?? "[]"
        return jsons
    }
    
    private func setRaw(_ json: String) -> Void {
        NSKeyedArchiver.archiveRootObject(json, toFile: SWPersistantRecipyRepository.ArchiveUrl.path)
    }
    
    private func getEntities() -> [SWRecipy] {
        do {
            let recipies = try JSONDecoder().decode([SWRecipy].self, from: getRaw().data(using: .utf8)!)
            return recipies
        }
        catch {
            fatalError("\(error)")
        }
    }
    
    private func setEntities(_ recipies: [SWRecipy]) {
        do {
            let json = String(data: try JSONEncoder().encode(recipies), encoding: .utf8)!
            self.setRaw(json)
        }
        catch {
            fatalError("\(error)")
        }
    }
    
    func getAll() -> [SWRecipy] {
        return getEntities()
    }
    
    func get(by id: Int) -> SWRecipy? {
        return getEntities().first(where: { $0.id == id })
    }
    
    func save(_ recipy: SWRecipy) -> Void {
        var entities = self.getEntities()
        if let id = recipy.id {
            if let position: Int = entities.index(where: { $0.id == id }) {
                entities.remove(at: position)
            }
        }
        entities.append(recipy)
        self.setEntities(entities)
    }
    
    func create() -> SWRecipy {
        let next = (self.getEntities().map({ $0.id! }).max() ?? 0) + 1
        let new = SWRecipy(id: next, name: "", servings: 0, ingredients: [], calories: 0, fats: 0, carbohydrates: 0, proteins: 0, timestamp: Date(), liked: false/*, photo: nil*/)
        return new
    }
    
}
