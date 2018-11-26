//
//  SWDietSettings.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
struct SWDietSettings: Codable {
    
    let id: Int
    
    var fatsDailyShare: Double
    
    var proteinsDailyShare: Double
    
    var carbohydratesDailyShare: Double
    
    let morningEnergyIntakeShare: Double
    
    let middayEnergyIntakeShare: Double
    
    let eveningEnergyIntakeShare: Double
    
    let dailyEnergyIntake: Double
    
    let morning: Int
    
    let midday: Int
    
    let evening: Int
    
}
