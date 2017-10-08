//
//  WChangeOption.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 08/10/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//
import UIKit
enum RVState {
    case active
    case inactive
}
struct RVStateSettings {
    
    var wheelRadius: CGFloat
    
    var pinDistance: CGFloat

    init(wheelRadius: CGFloat, pinDistance: CGFloat) {
        self.wheelRadius = wheelRadius
        self.pinDistance = pinDistance
    }
}
