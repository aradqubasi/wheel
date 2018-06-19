//
//  SWSegue.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
struct SWSegue {
    
    let identifier: String
//
//    init(identifier: String) {
//        identifier = identifier
//    }
    
    static func ==(left: SWSegue, right: SWSegue) -> Bool {
        return left.identifier == right.identifier
    }
    
    static func ~=(pattern: () -> SWSegue, value: SWSegue) -> Bool {
        return pattern() == value
    }
    
}
