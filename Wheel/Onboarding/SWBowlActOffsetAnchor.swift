//
//  SWBowlActAnchor.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 26/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
enum SWBowlActOffsetAnchor: String, Codable {
    case center
    case bottom
    
    static var fallback: SWBowlActOffsetAnchor {
        get {
            return .center
        }
    }
}
