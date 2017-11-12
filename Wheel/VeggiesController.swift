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
        
        let aubergine = PinView()
        aubergine.images = [
            .bases : [
                .focused: UIImage.aubergine,
                .visible: UIImage.aubergine,
                .invisible: UIImage.aubergine.alpha(0)
            ],
            .fats : [
                .focused: UIImage.aubergine,
                .visible: UIImage.aubergine,
                .invisible: UIImage.aubergine.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.Aubergine,
                .visible: UIImage.Aubergine.alpha(0.5),
                .invisible: UIImage.Aubergine.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.aubergine,
                .visible: UIImage.aubergine,
                .invisible: UIImage.aubergine.alpha(0)
            ]
        ]
        
        let tomato = PinView()
        tomato.images = [
            .bases : [
                .focused: UIImage.tomato,
                .visible: UIImage.tomato,
                .invisible: UIImage.tomato.alpha(0)
            ],
            .fats : [
                .focused: UIImage.tomato,
                .visible: UIImage.tomato,
                .invisible: UIImage.tomato.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.Tomato,
                .visible: UIImage.Tomato.alpha(0.5),
                .invisible: UIImage.Tomato.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.tomato,
                .visible: UIImage.tomato,
                .invisible: UIImage.tomato.alpha(0)
            ]
        ]
        
        let radish = PinView()
        radish.images = [
            .bases : [
                .focused: UIImage.radish,
                .visible: UIImage.radish,
                .invisible: UIImage.radish.alpha(0)
            ],
            .fats : [
                .focused: UIImage.radish,
                .visible: UIImage.radish,
                .invisible: UIImage.radish.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.Radish,
                .visible: UIImage.Radish.alpha(0.5),
                .invisible: UIImage.Radish.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.radish,
                .visible: UIImage.radish,
                .invisible: UIImage.radish.alpha(0)
            ]
        ]
        
        let pepper = PinView()
        pepper.images = [
            .bases : [
                .focused: UIImage.pepper,
                .visible: UIImage.pepper,
                .invisible: UIImage.pepper.alpha(0)
            ],
            .fats : [
                .focused: UIImage.pepper,
                .visible: UIImage.pepper,
                .invisible: UIImage.pepper.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.Pepper,
                .visible: UIImage.Pepper.alpha(0.5),
                .invisible: UIImage.Pepper.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.pepper,
                .visible: UIImage.pepper,
                .invisible: UIImage.pepper.alpha(0)
            ]
        ]
        
        let broccoli = PinView()
        broccoli.images = [
            .bases : [
                .focused: UIImage.broccoli,
                .visible: UIImage.broccoli,
                .invisible: UIImage.broccoli.alpha(0)
            ],
            .fats : [
                .focused: UIImage.broccoli,
                .visible: UIImage.broccoli,
                .invisible: UIImage.broccoli.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.Broccoli,
                .visible: UIImage.Broccoli.alpha(0.5),
                .invisible: UIImage.Broccoli.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.broccoli,
                .visible: UIImage.broccoli,
                .invisible: UIImage.broccoli.alpha(0)
            ]
        ]
        
        let carrot = PinView()
        carrot.images = [
            .bases : [
                .focused: UIImage.carrot,
                .visible: UIImage.carrot,
                .invisible: UIImage.carrot.alpha(0)
            ],
            .fats : [
                .focused: UIImage.carrot,
                .visible: UIImage.carrot,
                .invisible: UIImage.carrot.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.Carrot,
                .visible: UIImage.Carrot.alpha(0.5),
                .invisible: UIImage.Carrot.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.carrot,
                .visible: UIImage.carrot,
                .invisible: UIImage.carrot.alpha(0)
            ]
        ]
        
        let asparagus = PinView()
        asparagus.images = [
            .bases : [
                .focused: UIImage.asparagus,
                .visible: UIImage.asparagus,
                .invisible: UIImage.asparagus.alpha(0)
            ],
            .fats : [
                .focused: UIImage.asparagus,
                .visible: UIImage.asparagus,
                .invisible: UIImage.asparagus.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.Asparagus,
                .visible: UIImage.Asparagus.alpha(0.5),
                .invisible: UIImage.Asparagus.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.asparagus,
                .visible: UIImage.asparagus,
                .invisible: UIImage.asparagus.alpha(0)
            ]
        ]
        
        let cauliflower = PinView()
        cauliflower.images = [
            .bases : [
                .focused: UIImage.cauliflower,
                .visible: UIImage.cauliflower,
                .invisible: UIImage.cauliflower.alpha(0)
            ],
            .fats : [
                .focused: UIImage.cauliflower,
                .visible: UIImage.cauliflower,
                .invisible: UIImage.cauliflower.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.Cauliflower,
                .visible: UIImage.Cauliflower.alpha(0.5),
                .invisible: UIImage.Cauliflower.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.cauliflower,
                .visible: UIImage.cauliflower,
                .invisible: UIImage.cauliflower.alpha(0)
            ]
        ]
        
        let corn = PinView()
        corn.images = [
            .bases : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.corn,
                .visible: UIImage.corn.alpha(0.5),
                .invisible: UIImage.corn.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ]
        ]
        
        let pins: [PinView] = [aubergine, tomato, radish, pepper, broccoli, carrot, asparagus, cauliflower, corn]
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(240, CGFloat.pi / 5 * 0.5, CGSize(width: 80, height: 40)),
            .fats: WSettings(240, CGFloat.pi / 5 * 0.5, CGSize(width: 80, height: 40)),
            .veggies: WSettings(240, CGFloat.pi / 5 * 0.5, CGSize(width: 100, height: 50)),
            .proteins: WSettings(240, CGFloat.pi / 5 * 0.5, CGSize(width: 80, height: 40))
        ]
        
        super.init(pins, settings)
        
    }
    
}
