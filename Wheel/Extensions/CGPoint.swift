//
//  CGPoint.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
extension CGPoint: Hashable {
    
    public var hashValue: Int {
        return self.x.hashValue ^ self.y.hashValue
    }
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
}
