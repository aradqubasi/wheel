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
    
    init() {
        
//        let chickpeas = PinView()
//        chickpeas.images = [
//            .bases : [
//                .focused: UIImage.chickpeas,
//                .visible: UIImage.chickpeas,
//                .invisible: UIImage.chickpeas.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.chickpeas,
//                .visible: UIImage.chickpeas,
//                .invisible: UIImage.chickpeas.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.chickpeas,
//                .visible: UIImage.chickpeas,
//                .invisible: UIImage.chickpeas.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.Chickpeas,
//                .visible: UIImage.Chickpeas.alpha(0.5),
//                .invisible: UIImage.Chickpeas.alpha(0)
//            ]
//        ]
//
//        let fish = PinView()
//        fish.images = [
//            .bases : [
//                .focused: UIImage.fish,
//                .visible: UIImage.fish,
//                .invisible: UIImage.fish.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.fish,
//                .visible: UIImage.fish,
//                .invisible: UIImage.fish.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.fish,
//                .visible: UIImage.fish,
//                .invisible: UIImage.fish.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.Fish,
//                .visible: UIImage.Fish.alpha(0.5),
//                .invisible: UIImage.Fish.alpha(0)
//            ]
//        ]
//
//        let boiledegg = PinView()
//        boiledegg.images = [
//            .bases : [
//                .focused: UIImage.boiledegg,
//                .visible: UIImage.boiledegg,
//                .invisible: UIImage.boiledegg.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.boiledegg,
//                .visible: UIImage.boiledegg,
//                .invisible: UIImage.boiledegg.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.boiledegg,
//                .visible: UIImage.boiledegg,
//                .invisible: UIImage.boiledegg.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.Boiledegg,
//                .visible: UIImage.Boiledegg.alpha(0.5),
//                .invisible: UIImage.Boiledegg.alpha(0)
//            ]
//        ]
//
//        let beans = PinView()
//        beans.images = [
//            .bases : [
//                .focused: UIImage.beans,
//                .visible: UIImage.beans,
//                .invisible: UIImage.beans.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.beans,
//                .visible: UIImage.beans,
//                .invisible: UIImage.beans.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.beans,
//                .visible: UIImage.beans,
//                .invisible: UIImage.beans.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.Beans,
//                .visible: UIImage.Beans.alpha(0.5),
//                .invisible: UIImage.Beans.alpha(0)
//            ]
//        ]
//
//        let peas = PinView()
//        peas.images = [
//            .bases : [
//                .focused: UIImage.peas,
//                .visible: UIImage.peas,
//                .invisible: UIImage.peas.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.peas,
//                .visible: UIImage.peas,
//                .invisible: UIImage.peas.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.peas,
//                .visible: UIImage.peas,
//                .invisible: UIImage.peas.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.Peas,
//                .visible: UIImage.Peas.alpha(0.5),
//                .invisible: UIImage.Peas.alpha(0)
//            ]
//        ]
//
//        let friedegg = PinView()
//        friedegg.images = [
//            .bases : [
//                .focused: UIImage.friedegg,
//                .visible: UIImage.friedegg,
//                .invisible: UIImage.friedegg.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.friedegg,
//                .visible: UIImage.friedegg,
//                .invisible: UIImage.friedegg.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.friedegg,
//                .visible: UIImage.friedegg,
//                .invisible: UIImage.friedegg.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.Friedegg,
//                .visible: UIImage.Friedegg.alpha(0.5),
//                .invisible: UIImage.Friedegg.alpha(0)
//            ]
//        ]
//
//        let lentils = PinView()
//        lentils.images = [
//            .bases : [
//                .focused: UIImage.lentils,
//                .visible: UIImage.lentils,
//                .invisible: UIImage.lentils.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.lentils,
//                .visible: UIImage.lentils,
//                .invisible: UIImage.lentils.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.lentils,
//                .visible: UIImage.lentils,
//                .invisible: UIImage.lentils.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.Lentils,
//                .visible: UIImage.Lentils.alpha(0.5),
//                .invisible: UIImage.Lentils.alpha(0)
//            ]
//        ]
//
//        let mushrooms = PinView()
//        mushrooms.images = [
//            .bases : [
//                .focused: UIImage.mushrooms,
//                .visible: UIImage.mushrooms,
//                .invisible: UIImage.mushrooms.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.mushrooms,
//                .visible: UIImage.mushrooms,
//                .invisible: UIImage.mushrooms.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.mushrooms,
//                .visible: UIImage.mushrooms,
//                .invisible: UIImage.mushrooms.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.Mushrooms,
//                .visible: UIImage.Mushrooms.alpha(0.5),
//                .invisible: UIImage.Mushrooms.alpha(0)
//            ]
//        ]
//
//        let shrimp = PinView()
//        shrimp.images = [
//            .bases : [
//                .focused: UIImage.shrimp,
//                .visible: UIImage.shrimp,
//                .invisible: UIImage.shrimp.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.shrimp,
//                .visible: UIImage.shrimp,
//                .invisible: UIImage.shrimp.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.shrimp,
//                .visible: UIImage.shrimp,
//                .invisible: UIImage.shrimp.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.Shrimp,
//                .visible: UIImage.Shrimp.alpha(0.5),
//                .invisible: UIImage.Shrimp.alpha(0)
//            ]
//        ]
        
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
  
//        let chickpeas2 = PinView.create.name("chickpeas2").icon(default: UIImage.chickpeas).icon(UIImage.Chickpeas, for: .proteins)
//        let fish2 = PinView.create.name("fish2").icon(default: UIImage.fish).icon(UIImage.Fish, for: .proteins)
//        let boiledegg2 = PinView.create.name("boiledegg2").icon(default: UIImage.boiledegg).icon(UIImage.Boiledegg, for: .proteins)
//        let beans2 = PinView.create.name("beans2").icon(default: UIImage.beans).icon(UIImage.Beans, for: .proteins)
//        let peas2 = PinView.create.name("peas2").icon(default: UIImage.peas).icon(UIImage.Peas, for: .proteins)
//        let friedegg2 = PinView.create.name("friedegg2").icon(default: UIImage.friedegg).icon(UIImage.Friedegg, for: .proteins)
//        let lentils2 = PinView.create.name("lentils2").icon(default: UIImage.lentils).icon(UIImage.Lentils, for: .proteins)
//        let mushrooms2 = PinView.create.name("mushrooms2").icon(default: UIImage.mushrooms).icon(UIImage.Mushrooms, for: .proteins)
//        let shrimp2 = PinView.create.name("shrimp2").icon(default: UIImage.shrimp).icon(UIImage.Shrimp, for: .proteins)
//
//        pins.append(contentsOf: [chickpeas2, fish2, boiledegg2, beans2, peas2, friedegg2, lentils2, mushrooms2, shrimp2])
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 52, height: 52)),
            .fats: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 52, height: 52)),
            .veggies: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 52, height: 52)),
            .proteins: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 66, height: 66))
        ]
        
        super.init(pins, settings, "proteins")
        
    }
    
}

