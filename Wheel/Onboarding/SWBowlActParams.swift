//
//  SWBowlActParams.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 20/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct SWBowlActParams {
    
    /**distance between center of view and superview in superview.bounds coordinate system*/
    let offset: CGPoint
    
    let scale: CGPoint
    
    let alpha: CGFloat
    
    init(offset: CGPoint, scale: CGPoint, alpha: CGFloat) {
        self.offset = offset
        self.scale = scale
        self.alpha = alpha
    }
}
