//
//  SWPieLegend.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/12/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation

struct SWPieLegend: Hashable {
    
    let code: Int
    
    let name: String
    
    var hashValue: Int {
        get {
            return code.hashValue
        }
    }
    
    static func ==(lhs: SWPieLegend, rhs: SWPieLegend) -> Bool {
        return lhs.code == rhs.code
    }
}
