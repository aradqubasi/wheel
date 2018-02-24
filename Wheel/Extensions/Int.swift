//
//  Int.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
extension Int {
    
    func random() -> Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
    
}
