//
//  VeggiesController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 12/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class ProteinsController : RadialController {
    
    // MARK: - Overrided Properties
    
    override var active: WState {
        get {
            return .proteins
        }
    }
    
    override var initial: WState {
        get {
            return .bases
        }
    }
    
    // MARK: - Initialization
    
    init(_ wheel: SWAbstractWheelView) {

        let chickpeas = PinView.create.name("chickpeas").icon(default: UIImage.chickpeas).icon(UIImage.Chickpeas, for: .proteins).icon(selected: UIImage.Chickpeas).kind(of: .protein)
        let fish = PinView.create.name("fish").icon(default: UIImage.fish).icon(UIImage.Fish, for: .proteins).icon(selected: UIImage.Fish).kind(of: .protein)
        let boiledegg = PinView.create.name("boiledegg").icon(default: UIImage.boiledegg).icon(UIImage.Boiledegg, for: .proteins).icon(selected: UIImage.Boiledegg).kind(of: .protein)
        let beans = PinView.create.name("beans").icon(default: UIImage.beans).icon(UIImage.Beans, for: .proteins).icon(selected: UIImage.Beans).kind(of: .protein)
        let peas = PinView.create.name("peas").icon(default: UIImage.peas).icon(UIImage.Peas, for: .proteins).icon(selected: UIImage.Peas).kind(of: .protein)
        let friedegg = PinView.create.name("friedegg").icon(default: UIImage.friedegg).icon(UIImage.Friedegg, for: .proteins).icon(selected: UIImage.Friedegg).kind(of: .protein)
        let lentils = PinView.create.name("lentils").icon(default: UIImage.lentils).icon(UIImage.Lentils, for: .proteins).icon(selected: UIImage.Lentils).kind(of: .protein)
        let mushrooms = PinView.create.name("mushrooms").icon(default: UIImage.mushrooms).icon(UIImage.Mushrooms, for: .proteins).icon(selected: UIImage.Mushrooms).kind(of: .protein)
        let shrimp = PinView.create.name("shrimp").icon(default: UIImage.shrimp).icon(UIImage.Shrimp, for: .proteins).icon(selected: UIImage.Shrimp).kind(of: .protein)
        
        let pins: [PinView] = [chickpeas, fish, boiledegg, beans, peas, friedegg, lentils, mushrooms, shrimp]
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 52, height: 52), CGFloat.pi * 1.5, 1),
            .fats: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 52, height: 52), CGFloat.pi * 1.5, 1),
            .veggies: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 52, height: 52), CGFloat.pi * 1.5, 1),
            .proteins: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 66, height: 66), CGFloat.pi * 1.5, 1)
        ]
        
        super.init(wheel, pins, settings, "proteins")
        
    }
    
}

