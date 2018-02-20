//
//  WState.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
enum WState: String {
    
    case bases
    
    case fats
    
    case veggies
    
    case proteins
    
    static var all: [WState] {
        get {
            return [.bases, .fats, .veggies, .proteins]
        }
    }
}
