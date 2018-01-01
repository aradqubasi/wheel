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
    
    // MARK: - Public Properties
    
    /**Angular distance between pins*/
    var distance: CGFloat
    
    /**Wheel radius*/
    var radius: CGFloat
    
    /**PinView size*/
    var size: CGSize
    
    /**Convert to RVSettings*/
    var asRvSettings: RVSettings {
        get {
            return RVSettings(radius, distance)
        }
    }
    
    /**Convert to RVSettings*/
    var asSwWheelSettings: SWWheelSettings {
        get {
            return SWWheelSettings(radius, distance, 0)
        }
    }
    
    // MARK: - Initializers
    
    init(_ radius: CGFloat, _ distance: CGFloat, _ size: CGSize) {
        self.radius = radius
        self.distance = distance
        self.size = size
    }
    
    
}
