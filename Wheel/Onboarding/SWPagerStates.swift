//
//  SWOStates.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
enum SWPagerStates: String, Codable {
    case obey
    case leafs
    case proteins
    case veggies
    case fats
    case ehancers
    case proceed
    
    static let inital: SWPagerStates = .obey
    
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
            return .proceed
        case .proceed:
            return .obey
        }
    }
    
    func prev() -> SWPagerStates {
        switch self {
        case .obey:
            return .proceed
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
        case .proceed:
            return .ehancers
        }
    }
    
    static func all() -> [SWPagerStates] {
        return [.obey, .leafs, .proteins, .veggies, .fats, .ehancers, .proceed]
    }
}
