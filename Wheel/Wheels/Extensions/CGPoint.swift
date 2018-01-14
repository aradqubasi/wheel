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
    
}
