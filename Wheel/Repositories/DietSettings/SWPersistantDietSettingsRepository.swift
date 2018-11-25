//
//  SWPersistantDietSettingsRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWPersistantDietSettingsRepository: SWDietSettingsRepository {
    
    func get() -> SWDietSettings {
        return SWDietSettings(id: 1, fatsDailyShare: 0.225, proteinsDailyShare: 0.275, carbohydratesDailyShare: 0.5, morningEnergyIntakeShare: 0.267, middayEnergyIntakeShare: 0.466, eveningEnergyIntakeShare: 0.267, dailyEnergyIntake: 1000, morning: 5, midday: 15, evening: 22)
    }
    
    func upsert(_ entity: SWDietSettings) -> Void {
//        SWInmemoryDietSettingsRepository.entity = entity
    }
    
}
