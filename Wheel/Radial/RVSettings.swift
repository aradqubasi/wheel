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
struct RVSettings {
    
    var wheelRadius: CGFloat!
    
    var pinDistance: CGFloat!
    
//    var wheelThickness: CGFloat!
    
    init(_ wheelRadius: CGFloat, _ pinDistance: CGFloat) {
        self.wheelRadius = wheelRadius
        self.pinDistance = pinDistance
//        self.wheelThickness = wheelThickness
    }
}
