//
//  DressingController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 15/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class DressingController: OverlayController {
    
    // MARK: - Initialization
    
    init() {
        
        let oliveoil = NamedPinView()
        oliveoil.name = "OLIVE OIL"
        oliveoil.image = UIImage.cookedgrains
        let tahini = NamedPinView()
        tahini.name = "TAHINI"
        tahini.image = UIImage.cottagecheese
        let mustard = NamedPinView()
        mustard.name = "MUSTARD"
        mustard.image = UIImage.hotpepper
        let mayonnaise = NamedPinView()
        mayonnaise.name = "MAYONNAISE"
        mayonnaise.image = UIImage.olives
        let vinegar = NamedPinView()
        vinegar.name = "VINEGAR"
        vinegar.image = UIImage.onion
        let greekyogurt = NamedPinView()
        greekyogurt.name = "GREEK YOGURT"
        greekyogurt.image = UIImage.pickledveggies
        
        
        let pins = [oliveoil, tahini, mustard, mayonnaise, vinegar, greekyogurt]
        super.init(pins)
    }
}
