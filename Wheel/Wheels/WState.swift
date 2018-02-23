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
    
    /**map kind to active state*/
    static func map(_ kind: SWIngredientKinds) -> WState {
        switch kind {
        case .base:
            return .bases
        case .fat:
            return .fats
        case .veggy:
            return .veggies
        case .protein:
            return .proteins
        case .dressing:
            fatalError("no active state for kind \(kind)")
        case .unexpected:
            fatalError("no active state for kind \(kind)")
        case .fruits:
            fatalError("no active state for kind \(kind)")
        }
    }
}
