//
//  SWWheelsAnimationHelper.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol SWWheelsAnimationHelper {
    
    func getLocation(_ ingredient: SWIngredient) -> SWIngredientLocation
    
    func getLocations(of ingredients: [SWIngredient]) -> [SWIngredientLocation]
    
}
