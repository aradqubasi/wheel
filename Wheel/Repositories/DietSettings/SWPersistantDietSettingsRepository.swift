//
//  SWPersistantDietSettingsRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWPersistantDietSettingsRepository: SWDietSettingsRepository {
    
    private static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private static let ArchiveUrl = DocumentsDirectory.appendingPathComponent(String(describing: SWPersistantDietSettingsRepository.self))
    
    private func getRaw() -> String {
        let jsons = (NSKeyedUnarchiver.unarchiveObject(withFile: SWPersistantDietSettingsRepository.ArchiveUrl.path) as? String) ?? "[]"
        return jsons
    }
    
    private func setRaw(_ json: String) -> Void {
        NSKeyedArchiver.archiveRootObject(json, toFile: SWPersistantDietSettingsRepository.ArchiveUrl.path)
    }
    
    private func getEntities() -> [SWDietSettings] {
        do {
            let recipies = try JSONDecoder().decode([SWDietSettings].self, from: getRaw().data(using: .utf8)!)
            return recipies
        }
        catch {
            fatalError("\(error)")
        }
    }
    
    private func setEntities(_ recipies: [SWDietSettings]) {
        do {
            let json = String(data: try JSONEncoder().encode(recipies), encoding: .utf8)!
            self.setRaw(json)
        }
        catch {
            fatalError("\(error)")
        }
    }
    
    private let defaultSettingsId = 1
    
    func get() -> SWDietSettings {
//        return SWDietSettings(id: 1, fatsDailyShare: 0.225, proteinsDailyShare: 0.275, carbohydratesDailyShare: 0.5, morningEnergyIntakeShare: 0.267, middayEnergyIntakeShare: 0.466, eveningEnergyIntakeShare: 0.267, dailyEnergyIntake: 1000, morning: 5, midday: 15, evening: 22)
        return self.getEntities().first(where: { $0.id == self.defaultSettingsId })!
    }
    
    func upsert(_ entity: SWDietSettings) -> Void {
        var entities = self.getEntities().filter({ $0.id != entity.id })
        entities.append(entity)
        self.setEntities(entities)
    }
    
}
