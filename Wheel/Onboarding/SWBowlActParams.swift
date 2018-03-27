//
//  SWBowlActParams.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 20/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct SWBowlActParams: Codable {
    
    /**distance between center of view and superview in superview.bounds coordinate system*/
    let offset: CGPoint
    
    /**offset anchor*/
    let anchor: SWBowlActOffsetAnchor?
    
    let scale: CGPoint
    
    let alpha: CGFloat
    
    let angle: CGFloat
 
    init(offset: CGPoint, scale: CGPoint, alpha: CGFloat) {
        self.offset = offset
        self.scale = scale
        self.alpha = alpha
        self.angle = 0
        self.anchor = SWBowlActOffsetAnchor.fallback
    }
    
    init(offset: CGPoint, anchor: SWBowlActOffsetAnchor, scale: CGPoint, alpha: CGFloat, angle: CGFloat) {
        self.offset = offset
        self.scale = scale
        self.alpha = alpha
        self.angle = angle
        self.anchor = anchor
    }
}
