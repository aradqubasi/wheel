//
//  SWConcreteServingsCaptionGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteServingsGenerator: SWServingsGenerator {
    
    func getCaption(for quantity: Int) -> String {
        switch quantity {
        case Int.min...0:
            return "0 Servings"
        case 1:
            return "1 Serving"
        case 2...Int.max:
            return "\(quantity) Servings"
        default:
            fatalError("Unimplemented case quantity = \(quantity)")
        }
    }
    
}
