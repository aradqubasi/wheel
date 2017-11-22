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
    
    override var active: WState {
        get {
            return .bases
        }
    }
    
    override var initial: WState {
        get {
            return .bases
        }
    }
    
    // MARK: - Initialization
    
    init() {

        let romainelettuce = (PinView()).icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases)
//        let romainelettuce = PinView()
//        romainelettuce.images = [
//            .bases : [
//                .focused: UIImage.Corn,
//                .visible: UIImage.Corn.alpha(0.5),
//                .invisible: UIImage.Corn.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.corn,
//                .visible: UIImage.corn,
//                .invisible: UIImage.corn.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.corn,
//                .visible: UIImage.corn,
//                .invisible: UIImage.corn.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.corn,
//                .visible: UIImage.corn,
//                .invisible: UIImage.corn.alpha(0)
//            ]
//        ]
        
        let salad = (PinView()).icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases)
//        salad.images = [
//            .bases : [
//                .focused: UIImage.Corn,
//                .visible: UIImage.Corn.alpha(0.5),
//                .invisible: UIImage.Corn.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.corn,
//                .visible: UIImage.corn,
//                .invisible: UIImage.corn.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.corn,
//                .visible: UIImage.corn,
//                .invisible: UIImage.corn.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.corn,
//                .visible: UIImage.corn,
//                .invisible: UIImage.corn.alpha(0)
//            ]
//        ]
 
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
            .bases: WSettings(155, CGFloat.pi / 5, CGSize(width: 66, height: 66)),
            .fats: WSettings(141, CGFloat.pi / 5, CGSize(width: 52, height: 52)),
            .veggies: WSettings(141, CGFloat.pi / 5, CGSize(width: 52, height: 52)),
            .proteins: WSettings(141, CGFloat.pi / 5, CGSize(width: 52, height: 52))
        ]
        
        super.init(pins, settings, "bases")
    }
    
}
