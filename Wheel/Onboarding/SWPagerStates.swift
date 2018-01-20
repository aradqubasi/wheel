//
//  SWOStates.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
enum SWPagerStates {
    case obey
    case leafs
    case proteins
    case veggies
    case fats
    case ehancers
    
    func next() -> SWPagerStates {
        switch self {
        case .obey:
            return .leafs
        case .leafs:
            return .proteins
        case .proteins:
            return .veggies
        case .veggies:
            return .fats
        case .fats:
            return .ehancers
        case .ehancers:
            return .obey
//        default: fatalError("unimplemented next() for state \(self)")
        }
    }
    
    func prev() -> SWPagerStates {
        switch self {
        case .obey:
            return .ehancers
        case .leafs:
            return .obey
        case .proteins:
            return .leafs
        case .veggies:
            return .proteins
        case .fats:
            return .veggies
        case .ehancers:
            return .fats
//        default: fatalError("unimplemented next() for state \(self)")
        }
    }
}
