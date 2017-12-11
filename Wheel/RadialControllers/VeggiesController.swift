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
    
    init() {
        
//        let aubergine = PinView()
//        aubergine.images = [
//            .bases : [
//                .focused: UIImage.aubergine,
//                .visible: UIImage.aubergine,
//                .invisible: UIImage.aubergine.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.aubergine,
//                .visible: UIImage.aubergine,
//                .invisible: UIImage.aubergine.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.Aubergine,
//                .visible: UIImage.Aubergine.alpha(0.5),
//                .invisible: UIImage.Aubergine.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.aubergine,
//                .visible: UIImage.aubergine,
//                .invisible: UIImage.aubergine.alpha(0)
//            ]
//        ]
//
//        let tomato = PinView()
//        tomato.images = [
//            .bases : [
//                .focused: UIImage.tomato,
//                .visible: UIImage.tomato,
//                .invisible: UIImage.tomato.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.tomato,
//                .visible: UIImage.tomato,
//                .invisible: UIImage.tomato.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.Tomato,
//                .visible: UIImage.Tomato.alpha(0.5),
//                .invisible: UIImage.Tomato.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.tomato,
//                .visible: UIImage.tomato,
//                .invisible: UIImage.tomato.alpha(0)
//            ]
//        ]
//
//        let radish = PinView()
//        radish.images = [
//            .bases : [
//                .focused: UIImage.radish,
//                .visible: UIImage.radish,
//                .invisible: UIImage.radish.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.radish,
//                .visible: UIImage.radish,
//                .invisible: UIImage.radish.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.Radish,
//                .visible: UIImage.Radish.alpha(0.5),
//                .invisible: UIImage.Radish.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.radish,
//                .visible: UIImage.radish,
//                .invisible: UIImage.radish.alpha(0)
//            ]
//        ]
//
//        let pepper = PinView()
//        pepper.images = [
//            .bases : [
//                .focused: UIImage.pepper,
//                .visible: UIImage.pepper,
//                .invisible: UIImage.pepper.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.pepper,
//                .visible: UIImage.pepper,
//                .invisible: UIImage.pepper.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.Pepper,
//                .visible: UIImage.Pepper.alpha(0.5),
//                .invisible: UIImage.Pepper.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.pepper,
//                .visible: UIImage.pepper,
//                .invisible: UIImage.pepper.alpha(0)
//            ]
//        ]
//
//        let broccoli = PinView()
//        broccoli.images = [
//            .bases : [
//                .focused: UIImage.broccoli,
//                .visible: UIImage.broccoli,
//                .invisible: UIImage.broccoli.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.broccoli,
//                .visible: UIImage.broccoli,
//                .invisible: UIImage.broccoli.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.Broccoli,
//                .visible: UIImage.Broccoli.alpha(0.5),
//                .invisible: UIImage.Broccoli.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.broccoli,
//                .visible: UIImage.broccoli,
//                .invisible: UIImage.broccoli.alpha(0)
//            ]
//        ]
//
//        let carrot = PinView()
//        carrot.images = [
//            .bases : [
//                .focused: UIImage.carrot,
//                .visible: UIImage.carrot,
//                .invisible: UIImage.carrot.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.carrot,
//                .visible: UIImage.carrot,
//                .invisible: UIImage.carrot.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.Carrot,
//                .visible: UIImage.Carrot.alpha(0.5),
//                .invisible: UIImage.Carrot.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.carrot,
//                .visible: UIImage.carrot,
//                .invisible: UIImage.carrot.alpha(0)
//            ]
//        ]
//
//        let asparagus = PinView()
//        asparagus.images = [
//            .bases : [
//                .focused: UIImage.asparagus,
//                .visible: UIImage.asparagus,
//                .invisible: UIImage.asparagus.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.asparagus,
//                .visible: UIImage.asparagus,
//                .invisible: UIImage.asparagus.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.Asparagus,
//                .visible: UIImage.Asparagus.alpha(0.5),
//                .invisible: UIImage.Asparagus.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.asparagus,
//                .visible: UIImage.asparagus,
//                .invisible: UIImage.asparagus.alpha(0)
//            ]
//        ]
//
//        let cauliflower = PinView()
//        cauliflower.images = [
//            .bases : [
//                .focused: UIImage.cauliflower,
//                .visible: UIImage.cauliflower,
//                .invisible: UIImage.cauliflower.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.cauliflower,
//                .visible: UIImage.cauliflower,
//                .invisible: UIImage.cauliflower.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.Cauliflower,
//                .visible: UIImage.Cauliflower.alpha(0.5),
//                .invisible: UIImage.Cauliflower.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.cauliflower,
//                .visible: UIImage.cauliflower,
//                .invisible: UIImage.cauliflower.alpha(0)
//            ]
//        ]
//
//        let corn = PinView()
//        corn.images = [
//            .bases : [
//                .focused: UIImage.corn,
//                .visible: UIImage.corn,
//                .invisible: UIImage.corn.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.corn,
//                .visible: UIImage.corn,
//                .invisible: UIImage.corn.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.Corn,
//                .visible: UIImage.Corn.alpha(0.5),
//                .invisible: UIImage.Corn.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.corn,
//                .visible: UIImage.corn,
//                .invisible: UIImage.corn.alpha(0)
//            ]
//        ]
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
        
//        let aubergine2 = PinView.create.name("aubergine2").icon(default: UIImage.aubergine).icon(UIImage.Aubergine, for: .veggies)
//        let tomato2 = PinView.create.name("tomato2").icon(default: UIImage.tomato).icon(UIImage.Tomato, for: .veggies)
//        let radish2 = PinView.create.name("radish2").icon(default: UIImage.radish).icon(UIImage.Radish, for: .veggies)
//        let pepper2 = PinView.create.name("pepper2").icon(default: UIImage.pepper).icon(UIImage.Pepper, for: .veggies)
//        let broccoli2 = PinView.create.name("broccoli2").icon(default: UIImage.broccoli).icon(UIImage.Broccoli, for: .veggies)
//        let carrot2 = PinView.create.name("carrot2").icon(default: UIImage.carrot).icon(UIImage.Carrot, for: .veggies)
//        let asparagus2 = PinView.create.name("asparagus2").icon(default: UIImage.asparagus).icon(UIImage.Asparagus, for: .veggies)
//        let cauliflower2 = PinView.create.name("cauliflower2").icon(default: UIImage.cauliflower).icon(UIImage.Cauliflower, for: .veggies)
//        let corn2 = PinView.create.name("corn2").icon(default: UIImage.corn).icon(UIImage.Corn, for: .veggies)
//        
//        pins.append(contentsOf: [aubergine2, tomato2, radish2, pepper2, broccoli2, carrot2, asparagus2, cauliflower2, corn2])
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(284, CGFloat.pi / 5 * 0.49, CGSize(width: 52, height: 52)),
            .fats: WSettings(284, CGFloat.pi / 5 * 0.49, CGSize(width: 52, height: 52)),
            .veggies: WSettings(284, CGFloat.pi / 5 * 0.49, CGSize(width: 66, height: 66)),
            .proteins: WSettings(279, CGFloat.pi / 5 * 0.49, CGSize(width: 52, height: 52))
        ]
        
        super.init(pins, settings, "veggies")
        
    }
    
}