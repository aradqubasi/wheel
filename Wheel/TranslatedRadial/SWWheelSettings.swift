//
//  SWWheelSettings.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct SWWheelSettings {
    
    /**wheel radius - distance from center to border circle, all pins should be inside of it*/
    let radius: CGFloat
    
    /**angular distance between the pins - pins should be distributed equally*/
    let distance: CGFloat
    
    /**offset to start angle, which is zero and focus pointer*/
    let offset: CGFloat
    
    init(_ radius: CGFloat, _ distance: CGFloat, _ offset: CGFloat) {
        self.radius = radius
        self.distance = distance
        self.offset = offset
    }
    
}
