//
//  SWIngredientLocation.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation

protocol SWIngredientLocation {
    var ingredient: SWIngredient { get }
    var location: Floatable { get }
    func move() -> Void
}
