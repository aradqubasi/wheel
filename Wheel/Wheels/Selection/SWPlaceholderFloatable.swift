//
//  SWPlaceholderFloatable.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWPlaceholderFloatable: Floatable {
    
    var placeholder: UIView!
    
    var ingredient: SWIngredient!
    
    var asIngridient: SWIngredient {
        get {
            return ingredient
        }
    }
    
    func convert(_ point: CGPoint, to coordinateSpace: UICoordinateSpace) -> CGPoint {
        return placeholder.convert(point, to: coordinateSpace)
    }
    
}
