//
//  BasesRadialController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class BasesController : RadialController {
    
    // MARK: - Overrided Properties
    
    override var activeState: WState {
        get {
            return .bases
        }
    }
    
    // MARK: - Initialization
    
    init() {

        let romainelettuce = PinView()
        romainelettuce.images = [
            .bases : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
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
        
        let salad = PinView()
        salad.images = [
            .bases : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
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
 
        let cabbage = PinView()
        cabbage.images = [
            .bases : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
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
 
        let lettuce = PinView()
        lettuce.images = [
            .bases : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
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
  
        let spinach = PinView()
        spinach.images = [
            .bases : [
                .focused: UIImage.Corn,
                .visible: UIImage.Corn.alpha(0.5),
                .invisible: UIImage.Corn.alpha(0)
            ],
            .fats : [
                .focused: UIImage.corn,
                .visible: UIImage.corn,
                .invisible: UIImage.corn.alpha(0)
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
        
        let pins = [romainelettuce, salad, cabbage, lettuce, spinach]
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(120, CGFloat.pi / 5, CGSize(width: 100, height: 50)),
            .bases: WSettings(120, CGFloat.pi / 5, CGSize(width: 80, height: 40)),
            .bases: WSettings(120, CGFloat.pi / 5, CGSize(width: 80, height: 40)),
            .bases: WSettings(120, CGFloat.pi / 5, CGSize(width: 80, height: 40))
        ]
        
        super.init(pins, settings)

    }
    
}
