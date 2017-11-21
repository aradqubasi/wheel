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
        
        let chickpeas = PinView()
        chickpeas.images = [
            .bases : [
                .focused: UIImage.chickpeas,
                .visible: UIImage.chickpeas,
                .invisible: UIImage.chickpeas.alpha(0)
            ],
            .fats : [
                .focused: UIImage.chickpeas,
                .visible: UIImage.chickpeas,
                .invisible: UIImage.chickpeas.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.chickpeas,
                .visible: UIImage.chickpeas,
                .invisible: UIImage.chickpeas.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.Chickpeas,
                .visible: UIImage.Chickpeas.alpha(0.5),
                .invisible: UIImage.Chickpeas.alpha(0)
            ]
        ]
        
        let fish = PinView()
        fish.images = [
            .bases : [
                .focused: UIImage.fish,
                .visible: UIImage.fish,
                .invisible: UIImage.fish.alpha(0)
            ],
            .fats : [
                .focused: UIImage.fish,
                .visible: UIImage.fish,
                .invisible: UIImage.fish.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.fish,
                .visible: UIImage.fish,
                .invisible: UIImage.fish.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.Fish,
                .visible: UIImage.Fish.alpha(0.5),
                .invisible: UIImage.Fish.alpha(0)
            ]
        ]
        
        let boiledegg = PinView()
        boiledegg.images = [
            .bases : [
                .focused: UIImage.boiledegg,
                .visible: UIImage.boiledegg,
                .invisible: UIImage.boiledegg.alpha(0)
            ],
            .fats : [
                .focused: UIImage.boiledegg,
                .visible: UIImage.boiledegg,
                .invisible: UIImage.boiledegg.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.boiledegg,
                .visible: UIImage.boiledegg,
                .invisible: UIImage.boiledegg.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.Boiledegg,
                .visible: UIImage.Boiledegg.alpha(0.5),
                .invisible: UIImage.Boiledegg.alpha(0)
            ]
        ]
        
        let beans = PinView()
        beans.images = [
            .bases : [
                .focused: UIImage.beans,
                .visible: UIImage.beans,
                .invisible: UIImage.beans.alpha(0)
            ],
            .fats : [
                .focused: UIImage.beans,
                .visible: UIImage.beans,
                .invisible: UIImage.beans.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.beans,
                .visible: UIImage.beans,
                .invisible: UIImage.beans.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.Beans,
                .visible: UIImage.Beans.alpha(0.5),
                .invisible: UIImage.Beans.alpha(0)
            ]
        ]
        
        let peas = PinView()
        peas.images = [
            .bases : [
                .focused: UIImage.peas,
                .visible: UIImage.peas,
                .invisible: UIImage.peas.alpha(0)
            ],
            .fats : [
                .focused: UIImage.peas,
                .visible: UIImage.peas,
                .invisible: UIImage.peas.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.peas,
                .visible: UIImage.peas,
                .invisible: UIImage.peas.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.Peas,
                .visible: UIImage.Peas.alpha(0.5),
                .invisible: UIImage.Peas.alpha(0)
            ]
        ]
        
        let friedegg = PinView()
        friedegg.images = [
            .bases : [
                .focused: UIImage.friedegg,
                .visible: UIImage.friedegg,
                .invisible: UIImage.friedegg.alpha(0)
            ],
            .fats : [
                .focused: UIImage.friedegg,
                .visible: UIImage.friedegg,
                .invisible: UIImage.friedegg.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.friedegg,
                .visible: UIImage.friedegg,
                .invisible: UIImage.friedegg.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.Friedegg,
                .visible: UIImage.Friedegg.alpha(0.5),
                .invisible: UIImage.Friedegg.alpha(0)
            ]
        ]
        
        let lentils = PinView()
        lentils.images = [
            .bases : [
                .focused: UIImage.lentils,
                .visible: UIImage.lentils,
                .invisible: UIImage.lentils.alpha(0)
            ],
            .fats : [
                .focused: UIImage.lentils,
                .visible: UIImage.lentils,
                .invisible: UIImage.lentils.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.lentils,
                .visible: UIImage.lentils,
                .invisible: UIImage.lentils.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.Lentils,
                .visible: UIImage.Lentils.alpha(0.5),
                .invisible: UIImage.Lentils.alpha(0)
            ]
        ]
        
        let mushrooms = PinView()
        mushrooms.images = [
            .bases : [
                .focused: UIImage.mushrooms,
                .visible: UIImage.mushrooms,
                .invisible: UIImage.mushrooms.alpha(0)
            ],
            .fats : [
                .focused: UIImage.mushrooms,
                .visible: UIImage.mushrooms,
                .invisible: UIImage.mushrooms.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.mushrooms,
                .visible: UIImage.mushrooms,
                .invisible: UIImage.mushrooms.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.Mushrooms,
                .visible: UIImage.Mushrooms.alpha(0.5),
                .invisible: UIImage.Mushrooms.alpha(0)
            ]
        ]
        
        let shrimp = PinView()
        shrimp.images = [
            .bases : [
                .focused: UIImage.shrimp,
                .visible: UIImage.shrimp,
                .invisible: UIImage.shrimp.alpha(0)
            ],
            .fats : [
                .focused: UIImage.shrimp,
                .visible: UIImage.shrimp,
                .invisible: UIImage.shrimp.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.shrimp,
                .visible: UIImage.shrimp,
                .invisible: UIImage.shrimp.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.Shrimp,
                .visible: UIImage.Shrimp.alpha(0.5),
                .invisible: UIImage.Shrimp.alpha(0)
            ]
        ]
        
        let pins: [PinView] = [chickpeas, fish, boiledegg, beans, peas, friedegg, lentils, mushrooms, shrimp]
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 52, height: 52)),
            .fats: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 52, height: 52)),
            .veggies: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 52, height: 52)),
            .proteins: WSettings(353, CGFloat.pi / 5 * 0.4, CGSize(width: 66, height: 66))
        ]
        
        super.init(pins, settings, "proteins")
        
    }
    
}

