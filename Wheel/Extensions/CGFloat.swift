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
    
    func square() -> CGFloat {
        return self * self
    }
    
    func getFractionString() -> String {
        let quantity = self
        let fullPieces = quantity.rounded(.down)
        let extra = quantity - fullPieces
        let extraString = ( {
            () -> String in
            switch extra {
            case 0: return ""
            case 0.25: return "1/4"
            case 0.5: return "1/2"
            default: return String(format: "0.2f", extra)
            }
        })()
        if fullPieces == 0 && extraString == "" {
            return ""
        }
        else if fullPieces == 0 && extraString != "" {
            return "\(extraString)"
        }
        else if fullPieces != 0 && extraString == "" {
            return "\(Int(fullPieces))"
        }
        else /*if fullPieces != 0 && extraString != ""*/ {
            return "\(Int(fullPieces)) \(extraString)"
        }
    }
    
}
