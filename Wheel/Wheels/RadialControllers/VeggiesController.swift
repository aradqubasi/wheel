//
//  VeggiesController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 12/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class VeggiesController : RadialController {
    
    // MARK: - Overrided Properties
    
    override var active: WState {
        get {
            return .veggies
        }
    }
    
    override var initial: WState {
        get {
            return .bases
        }
    }
    
    // MARK: - Initialization
    
    init(_ wheel: SWAbstractWheelView) {
  
        let aubergine = PinView.create.name("aubergine").icon(default: UIImage.aubergine).icon(UIImage.Aubergine, for: .veggies).icon(selected: UIImage.Aubergine).kind(of: .veggy)
        let tomato = PinView.create.name("tomato").icon(default: UIImage.tomato).icon(UIImage.Tomato, for: .veggies).icon(selected: UIImage.Tomato).kind(of: .veggy)
        let radish = PinView.create.name("radish").icon(default: UIImage.radish).icon(UIImage.Radish, for: .veggies).icon(selected: UIImage.Radish).kind(of: .veggy)
        let pepper = PinView.create.name("pepper").icon(default: UIImage.pepper).icon(UIImage.Pepper, for: .veggies).icon(selected: UIImage.Pepper).kind(of: .veggy)
        let broccoli = PinView.create.name("broccoli").icon(default: UIImage.broccoli).icon(UIImage.Broccoli, for: .veggies).icon(selected: UIImage.Broccoli).kind(of: .veggy)
        let carrot = PinView.create.name("carrot").icon(default: UIImage.carrot).icon(UIImage.Carrot, for: .veggies).icon(selected: UIImage.Carrot).kind(of: .veggy)
        let asparagus = PinView.create.name("asparagus").icon(default: UIImage.asparagus).icon(UIImage.Asparagus, for: .veggies).icon(selected: UIImage.Asparagus).kind(of: .veggy)
        let cauliflower = PinView.create.name("cauliflower").icon(default: UIImage.cauliflower).icon(UIImage.Cauliflower, for: .veggies).icon(selected: UIImage.Cauliflower).kind(of: .veggy)
        let corn = PinView.create.name("corn").icon(default: UIImage.corn).icon(UIImage.Corn, for: .veggies).icon(selected: UIImage.Corn).kind(of: .veggy)
        
        let pins: [PinView] = [aubergine, tomato, radish, pepper, broccoli, carrot, asparagus, cauliflower, corn]
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(284, CGFloat.pi / 5 * 0.49, CGSize(width: 52, height: 52), CGFloat.pi * 1.5, 1),
            .fats: WSettings(284, CGFloat.pi / 5 * 0.49, CGSize(width: 52, height: 52), CGFloat.pi * 1.5, 1),
            .veggies: WSettings(284, CGFloat.pi / 5 * 0.49, CGSize(width: 66, height: 66), CGFloat.pi * 1.5, 1),
            .proteins: WSettings(279, CGFloat.pi / 5 * 0.49, CGSize(width: 52, height: 52), CGFloat.pi * 1.5, 1)
        ]
        
        super.init(wheel, pins, settings, "veggies")
        
    }
    
}
