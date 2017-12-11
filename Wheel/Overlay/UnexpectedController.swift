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
        let cookedgrains = PinView.create.name("cookedgrains").icon(selected: UIImage.cookedgrains).kind(of: .unexpected)
        let cottagecheese = PinView.create.name("cottagecheese").icon(selected: UIImage.cottagecheese).kind(of: .unexpected)
        let hotpepper = PinView.create.name("hotpepper").icon(selected: UIImage.hotpepper).kind(of: .unexpected)
        let olives = PinView.create.name("olives").icon(selected: UIImage.olives).kind(of: .unexpected)
        let onion = PinView.create.name("onion").icon(selected: UIImage.onion).kind(of: .unexpected)
        let pickledveggies = PinView.create.name("pickledveggies").icon(selected: UIImage.pickledveggies).kind(of: .unexpected)
        
        let pins = [cookedgrains, cottagecheese, hotpepper, olives, onion, pickledveggies]
        super.init(pins)
    }
}
