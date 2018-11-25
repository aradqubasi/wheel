//
//  SWPersistantDietSettingsViewModelRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWPersistantDietSettingsViewModelRepository: SWDietSettingsViewModelRepository {
    
    private static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private static let ArchiveUrl = DocumentsDirectory.appendingPathComponent(String(describing: SWPersistantDietSettingsViewModelRepository.self))
    
    private func getRaw() -> String {
        let jsons = (NSKeyedUnarchiver.unarchiveObject(withFile: SWPersistantDietSettingsViewModelRepository.ArchiveUrl.path) as? String) ?? "[]"
        return jsons
    }
    
    private func setRaw(_ json: String) -> Void {
        NSKeyedArchiver.archiveRootObject(json, toFile: SWPersistantDietSettingsViewModelRepository.ArchiveUrl.path)
    }
    
    private func getEntities() -> [SWDietSettingsViewModel] {
        do {
            let recipies = try JSONDecoder().decode([SWDietSettingsViewModel].self, from: getRaw().data(using: .utf8)!)
            return recipies
        }
        catch {
            fatalError("\(error)")
        }
    }
    
    private func setEntities(_ recipies: [SWDietSettingsViewModel]) {
        do {
            let json = String(data: try JSONEncoder().encode(recipies), encoding: .utf8)!
            self.setRaw(json)
        }
        catch {
            fatalError("\(error)")
        }
    }
    
    func get(by id: Int) -> SWDietSettingsViewModel? {
        return getEntities().first(where: { $0.id == id })
    }
    
    func upsert(_ value: SWDietSettingsViewModel) {
        var entities = getEntities()
        entities = entities.filter({ $0.id != value.id })
        entities.append(value)
        setEntities(entities)
    }

}
