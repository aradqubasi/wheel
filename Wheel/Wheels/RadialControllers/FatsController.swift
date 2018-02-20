//
//  FatsController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 12/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class FatsController : RadialController {
    
    // MARK: - Overrided Properties
    
    override var active: WState {
        get {
            return .fats
        }
    }
    
    override var initial: WState {
        get {
            return .bases
        }
    }
    
    // MARK: - Initialization
    
    init(_ wheel: SWAbstractWheelView) {

        let coconut = PinView.create.name("coconut").icon(default: UIImage.coconut).icon(UIImage.Coconut, for: .fats).icon(selected: UIImage.Coconut).kind(of: .fat)
        let hazelnut = PinView.create.name("hazelnut").icon(default: UIImage.hazelnut).icon(UIImage.Hazelnut, for: .fats).icon(selected: UIImage.Hazelnut).kind(of: .fat)
        let seeds = PinView.create.name("seeds").icon(default: UIImage.seeds).icon(UIImage.Seeds, for: .fats).icon(selected: UIImage.Seeds).kind(of: .fat)
        let brazilnut = PinView.create.name("brazilnut").icon(default: UIImage.brazilnut).icon(UIImage.Brazilnut, for: .fats).icon(selected: UIImage.Brazilnut).kind(of: .fat)
        let cashewnut = PinView.create.name("cashewnut").icon(default: UIImage.cashewnut).icon(UIImage.Cashewnut, for: .fats).icon(selected: UIImage.Cashewnut).kind(of: .fat)
        let avocado = PinView.create.name("avocado").icon(default: UIImage.avocado).icon(UIImage.Avocado, for: .fats).icon(selected: UIImage.Avocado).kind(of: .fat)
        let peanut = PinView.create.name("peanut").icon(default: UIImage.peanut).icon(UIImage.Peanut, for: .fats).icon(selected: UIImage.Peanut).kind(of: .fat)
        
        let pins = [coconut, hazelnut, seeds, brazilnut, cashewnut, avocado, peanut]
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(215, CGFloat.pi / 5 * 0.67, CGSize(width: 52, height: 52), CGFloat.pi * 1.5, 1),
            .fats: WSettings(215, CGFloat.pi / 5 * 0.67, CGSize(width: 66, height: 66), CGFloat.pi * 1.5, 1),
            .veggies: WSettings(210, CGFloat.pi / 5 * 0.67, CGSize(width: 52, height: 52), CGFloat.pi * 1.5, 1),
            .proteins: WSettings(210, CGFloat.pi / 5 * 0.67, CGSize(width: 52, height: 52), CGFloat.pi * 1.5, 1)
        ]
        
        super.init(wheel, pins, settings, "fats")
        
    }
    
}
