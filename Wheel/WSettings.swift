//
//  WStateSetting.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 08/10/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct WSettings {
    
    var geometry: RVSettings
    
    var radius: CGFloat
    
    init(_ geometry: RVSettings, _ radius: CGFloat) {
        self.geometry = geometry
        self.radius = radius
    }
}
