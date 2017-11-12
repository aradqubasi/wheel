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
    
    init() {
        
        let coconut = PinView()
        coconut.images = [
            .bases : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ]
        ]
        
        let hazelnut = PinView()
        hazelnut.images = [
            .bases : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ]
        ]
        
        let seeds = PinView()
        seeds.images = [
            .bases : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ]
        ]
        
        let brazilnut = PinView()
        brazilnut.images = [
            .bases : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ]
        ]
        
        let cashewnut = PinView()
        cashewnut.images = [
            .bases : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ]
        ]
        
        let avocado = PinView()
        avocado.images = [
            .bases : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ]
        ]
        
        let peanut = PinView()
        peanut.images = [
            .bases : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .veggies : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ],
            .proteins : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
            ]
        ]
        
        let pins = [coconut, hazelnut, seeds, brazilnut, cashewnut, avocado, peanut]
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(180, CGFloat.pi / 5 * 0.67, CGSize(width: 80, height: 40)),
            .fats: WSettings(180, CGFloat.pi / 5 * 0.67, CGSize(width: 100, height: 50)),
            .veggies: WSettings(180, CGFloat.pi / 5 * 0.67, CGSize(width: 80, height: 40)),
            .proteins: WSettings(180, CGFloat.pi / 5 * 0.67, CGSize(width: 80, height: 40))
        ]
        
        super.init(pins, settings)
        
    }
    
}
