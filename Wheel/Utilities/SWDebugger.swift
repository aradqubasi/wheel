//
//  SWDebugger.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 22/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWDebugger {
    
    private static let instance = SWDebugger()
    
    static func getInstance() -> SWDebugger {
        return instance
    }
    
    var pins: [PinView] = []
    
}
