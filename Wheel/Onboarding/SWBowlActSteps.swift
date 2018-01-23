//
//  SWBowlActSteps.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 20/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
enum SWBowlActSteps: String, Codable {
    
    case before
    case inbetween
    case after
    
    static let inital: SWBowlActSteps = .before
    
    func next() -> SWBowlActSteps {
        switch self {
        case .before:
            return .inbetween
        case .inbetween:
            return .after
        case .after:
            return .before
        }
    }
    
    func prev() -> SWBowlActSteps {
        switch self {
        case .before:
            return .after
        case .inbetween:
            return .before
        case .after:
            return .inbetween
        }
    }
    
    static func all() -> [SWBowlActSteps] {
        return [.before, .inbetween, .after]
    }
}
