//
//  SWDietSettingsViewModel.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct SWDietSettingsViewModel: Codable {
    
    let id: Int
    
    var fatsStartAngle: CGFloat
    
    var fatsEndAngle: CGFloat
    
    var proteinStartAngle: CGFloat
    
    var proteinEndAngle: CGFloat
    
    var carbohydratesStartAngle: CGFloat
    
    var carbohydratesEndAngle: CGFloat
    
}
