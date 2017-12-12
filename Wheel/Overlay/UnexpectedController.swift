//
//  UnexpectedController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class UnexpectedController: OverlayController {
    
    // MARK: - Initialization
    
    init() {
//        let cookedgrains = PinView.create.name("cookedgrains").icon(selected: UIImage.cookedgrains).kind(of: .unexpected)
//        let cottagecheese = PinView.create.name("cottagecheese").icon(selected: UIImage.cottagecheese).kind(of: .unexpected)
//        let hotpepper = PinView.create.name("hotpepper").icon(selected: UIImage.hotpepper).kind(of: .unexpected)
//        let olives = PinView.create.name("olives").icon(selected: UIImage.olives).kind(of: .unexpected)
//        let onion = PinView.create.name("onion").icon(selected: UIImage.onion).kind(of: .unexpected)
//        let pickledveggies = PinView.create.name("pickledveggies").icon(selected: UIImage.pickledveggies).kind(of: .unexpected)
        
        let cookedgrains = NamedPinView()
        cookedgrains.name = "COOKED GRAINS"
        cookedgrains.image = UIImage.cookedgrains
        let cottagecheese = NamedPinView()
        cottagecheese.name = "COTTAGE CHEESE"
        cottagecheese.image = UIImage.cottagecheese
        let hotpepper = NamedPinView()
        hotpepper.name = "HOT PEPPER"
        hotpepper.image = UIImage.hotpepper
        let olives = NamedPinView()
        olives.name = "OLIVES"
        olives.image = UIImage.olives
        let onion = NamedPinView()
        onion.name = "OLIVES"
        onion.image = UIImage.onion
        let pickledveggies = NamedPinView()
        pickledveggies.name = "PICKLED VEGGIES"
        pickledveggies.image = UIImage.pickledveggies

        
        let pins = [cookedgrains, cottagecheese, hotpepper, olives, onion, pickledveggies]
        super.init(pins)
    }
}
