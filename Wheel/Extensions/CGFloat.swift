//
//  CGFloat.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 19/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
extension CGFloat {
    
    static var leftward: CGFloat {
        get {
            return CGFloat.pi
        }
    }
    
    static var rightward: CGFloat {
        get {
            return 0
        }
    }
    
    static var top: CGFloat {
        get {
            return -CGFloat.pi * 0.5
        }
    }
    
    static var bottom: CGFloat {
        get {
            return CGFloat.pi * 0.5
        }
    }
    
}
