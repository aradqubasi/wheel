//
//  SWConcreteWheelsAnimationHelper.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWConcreteWheelsAnimationHelper: SWWheelsAnimationHelper {
    
    private var bases: SWAbstractWheelController
    private var fats: SWAbstractWheelController
    private var veggies: SWAbstractWheelController
    private var proteins: SWAbstractWheelController
    private var unexpected: UIButton
    private var fruits: UIButton
    private var dressings: UIButton
    private var scene: UIView
    
    init(bases: SWAbstractWheelController, fats: SWAbstractWheelController, veggies: SWAbstractWheelController, proteins: SWAbstractWheelController, unexpected: UIButton, fruits: UIButton, dressings: UIButton, scene: UIView) {
        self.bases = bases
        self.fats = fats
        self.veggies = veggies
        self.proteins = proteins
        self.unexpected = unexpected
        self.fruits = fruits
        self.dressings = dressings
        self.scene = scene
    }
    
    func getLocation(_ ingredient: SWIngredient) -> SWIngredientLocation {
        return getLocations(of: [ingredient]).first!
    }
    
    func getLocations(of ingredients: [SWIngredient]) -> [SWIngredientLocation] {
        
        var locations: [SWIngredientLocation] = []
        
        for ingredient in ingredients {
            switch ingredient.kind {
            case .base, .fat, .protein, .veggy:
                var wheel: SWAbstractWheelController!
                switch ingredient.kind {
                case .base:
                    wheel = bases
                case .fat:
                    wheel = fats
                case .protein:
                    wheel = proteins
                case .veggy:
                    wheel = veggies
                default:
                    fatalError("there is no wheel for kind \(ingredient.kind)")
                }
                let first = wheel.getIndexesOf(ingredient).first!
                let location = SWWheelIngredientLocation(ingredient: ingredient, index: first, wheel: wheel, scene: scene)
                locations.append(location)
            case .dressing, .fruits, .unexpected:
                var button: UIButton!
                switch ingredient.kind {
                case .dressing:
                    button = dressings
                case .fruits:
                    button = fruits
                case .unexpected:
                    button = unexpected
                default:
                    fatalError("there is no button for kind \(ingredient.kind)")
                }
                let location = SWButtonIngredientLocation(ingredient: ingredient, button: button)
                locations.append(location)
            }
        }
        return locations
    }
    
}
