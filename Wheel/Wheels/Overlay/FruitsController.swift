//
//  FruitsController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 15/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class FruitsController: OverlayController {
    
    // MARK: - Initialization
    
    init() {
        
        let apple = NamedPinView()
        apple.name = "APPLE"
        apple.image = UIImage.cookedgrains
        let blueberry = NamedPinView()
        blueberry.name = "BLUEBERRY"
        blueberry.image = UIImage.cottagecheese
        let orange = NamedPinView()
        orange.name = "ORANGE"
        orange.image = UIImage.hotpepper
        let grapefruit = NamedPinView()
        grapefruit.name = "GRAPEFRUIT"
        grapefruit.image = UIImage.olives
        let grapes = NamedPinView()
        grapes.name = "GRAPES"
        grapes.image = UIImage.onion
        let watermelon = NamedPinView()
        watermelon.name = "WATERMELON"
        watermelon.image = UIImage.pickledveggies
        
        
        let pins = [apple, blueberry, orange, grapefruit, grapes, watermelon]
        super.init(pins)
    }
}
