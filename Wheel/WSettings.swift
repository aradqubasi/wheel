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
    
    /**angular offset of focus, defaut at the top*/
    var offset: CGFloat
    
    /**pin scale factor*/
    var scale: CGFloat
    
    /**Convert to RVSettings*/
    var asRvSettings: RVSettings {
        get {
            return RVSettings(radius, distance)
        }
    }
    
    /**Convert to RVSettings*/
    var asSwWheelSettings: SWWheelSettings {
        get {
            return SWWheelSettings(radius, distance, offset, scale)
        }
    }
    
    // MARK: - Initializers
    
    init(_ radius: CGFloat, _ distance: CGFloat, _ size: CGSize, _ offset: CGFloat, _ scale: CGFloat) {
        self.radius = radius
        self.distance = distance
        self.size = size
        self.offset = offset
        self.scale = scale
    }
    
    
}
