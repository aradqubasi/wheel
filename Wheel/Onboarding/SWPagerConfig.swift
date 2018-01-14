//
//  SWOPagerConfig.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct SWPagerConfig {
    /**size of pager dotes*/
    let dot: CGFloat
    
    /**diatnce setween dots*/
    let spacing: CGFloat
    
    /**dot color of active page*/
    let active: UIColor
    
    /**dot color of inactive page*/
    let inactive: UIColor
    
    init(_ dot: CGFloat, _ spacing: CGFloat, _ active: UIColor, _ inactive: UIColor) {
        self.dot = dot
        self.spacing = spacing
        self.active = active
        self.inactive = inactive
    }
}
