//
//  SWButtonIngredientLocation.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWButtonIngredientLocation: SWIngredientLocation {
    
    let ingredient: SWIngredient
    
    var location: Floatable {
        get {
            return self
        }
    }
    
    private let button: UIButton
    
    func move() { }
    
    init(ingredient: SWIngredient, button: UIButton) {
        self.ingredient = ingredient
        self.button = button
    }
}

extension SWButtonIngredientLocation: Floatable {
    
    var asIngridient: SWIngredient {
        get {
            return self.ingredient
        }
    }
    
    func convert(_ point: CGPoint, to coordinateSpace: UICoordinateSpace) -> CGPoint {
        return button.convert(point, to: coordinateSpace)
    }
}
