//
//  SWWheelIngredientLocation.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWWheelIngredientLocation: SWIngredientLocation {
    
    let ingredient: SWIngredient
    
    var location: Floatable {
        get {
            return self
        }
    }
    
    private let index: Int
    
    private let scene: UIView
    
    private let point: CGPoint
    
    private let wheel: SWAbstractWheelController
    
    func move() {
        wheel.move(to: index)
    }
    
    init(ingredient: SWIngredient, index: Int, wheel: SWAbstractWheelController, scene: UIView) {
        self.ingredient = ingredient
        self.index = index
        self.scene = scene
        self.wheel = wheel
        self.point = wheel.focused.convert(.zero, to: scene)
    }
}

extension SWWheelIngredientLocation: Floatable {
    
    var asIngridient: SWIngredient {
        get {
            return self.ingredient
        }
    }
    
    func convert(_ point: CGPoint, to coordinateSpace: UICoordinateSpace) -> CGPoint {
        return scene.convert(self.point, to: coordinateSpace)
    }
}
