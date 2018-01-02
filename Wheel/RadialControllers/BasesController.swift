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
    
    init(_ wheel: SWAbstractWheelView) {

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
        
//        let salad = PinView()
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
 
//        let cabbage = PinView()
//        cabbage.images = [
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
        
//        let lettuce = PinView()
//        lettuce.images = [
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
  
//        let spinach = PinView()
//        spinach.images = [
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
        
        let romainelettuce = PinView.create.name("romainelettuce").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
        let salad = PinView.create.name("salad").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
        let cabbage = PinView.create.name("cabbage").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
        let lettuce = PinView.create.name("lettuce").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
        let spinach = PinView.create.name("spinach").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
        
        let pins = [romainelettuce, salad, cabbage, lettuce, spinach]
        
//        let romainelettuce2 = PinView.create.name("romainelettuce2").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases)
//        let salad2 = PinView.create.name("salad2").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases)
//        let cabbage2 = PinView.create.name("cabbage2").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases)
//        let lettuce2 = PinView.create.name("lettuce2").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases)
//        let spinach2 = PinView.create.name("spinach2").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases)
//        
//        pins.append(contentsOf: [romainelettuce2, salad2, cabbage2, lettuce2, spinach2])
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(155, CGFloat.pi / 5, CGSize(width: 66, height: 66), CGFloat.pi, 1),
            .fats: WSettings(141, CGFloat.pi / 5, CGSize(width: 52, height: 52), CGFloat.pi, 1),
            .veggies: WSettings(141, CGFloat.pi / 5, CGSize(width: 52, height: 52), CGFloat.pi, 1),
            .proteins: WSettings(141, CGFloat.pi / 5, CGSize(width: 52, height: 52), CGFloat.pi, 1)
        ]
        
        super.init(wheel, pins, settings, "bases")
    }
    
}
