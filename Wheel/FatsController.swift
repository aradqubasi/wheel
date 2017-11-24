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
//
//        let coconut = PinView()
//        coconut.images = [
//            .bases : [
//                .focused: UIImage.coconut,
//                .visible: UIImage.coconut,
//                .invisible: UIImage.coconut.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.Coconut,
//                .visible: UIImage.Coconut.alpha(0.5),
//                .invisible: UIImage.Coconut.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.coconut,
//                .visible: UIImage.coconut,
//                .invisible: UIImage.coconut.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.coconut,
//                .visible: UIImage.coconut,
//                .invisible: UIImage.coconut.alpha(0)
//            ]
//        ]
//
//        let hazelnut = PinView()
//        hazelnut.images = [
//            .bases : [
//                .focused: UIImage.hazelnut,
//                .visible: UIImage.hazelnut,
//                .invisible: UIImage.hazelnut.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.Hazelnut,
//                .visible: UIImage.Hazelnut.alpha(0.5),
//                .invisible: UIImage.Hazelnut.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.hazelnut,
//                .visible: UIImage.hazelnut,
//                .invisible: UIImage.hazelnut.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.hazelnut,
//                .visible: UIImage.hazelnut,
//                .invisible: UIImage.hazelnut.alpha(0)
//            ]
//        ]
//
//        let seeds = PinView()
//        seeds.images = [
//            .bases : [
//                .focused: UIImage.seeds,
//                .visible: UIImage.seeds,
//                .invisible: UIImage.seeds.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.Seeds,
//                .visible: UIImage.Seeds.alpha(0.5),
//                .invisible: UIImage.Seeds.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.seeds,
//                .visible: UIImage.seeds,
//                .invisible: UIImage.seeds.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.seeds,
//                .visible: UIImage.seeds,
//                .invisible: UIImage.seeds.alpha(0)
//            ]
//        ]
//
//        let brazilnut = PinView()
//        brazilnut.images = [
//            .bases : [
//                .focused: UIImage.brazilnut,
//                .visible: UIImage.brazilnut,
//                .invisible: UIImage.brazilnut.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.Brazilnut,
//                .visible: UIImage.Brazilnut.alpha(0.5),
//                .invisible: UIImage.Brazilnut.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.brazilnut,
//                .visible: UIImage.brazilnut,
//                .invisible: UIImage.brazilnut.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.brazilnut,
//                .visible: UIImage.brazilnut,
//                .invisible: UIImage.brazilnut.alpha(0)
//            ]
//        ]
//
//        let cashewnut = PinView()
//        cashewnut.images = [
//            .bases : [
//                .focused: UIImage.cashewnut,
//                .visible: UIImage.cashewnut,
//                .invisible: UIImage.cashewnut.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.Cashewnut,
//                .visible: UIImage.Cashewnut.alpha(0.5),
//                .invisible: UIImage.Cashewnut.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.cashewnut,
//                .visible: UIImage.cashewnut,
//                .invisible: UIImage.cashewnut.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.cashewnut,
//                .visible: UIImage.cashewnut,
//                .invisible: UIImage.cashewnut.alpha(0)
//            ]
//        ]
//
//        let avocado = PinView()
//        avocado.images = [
//            .bases : [
//                .focused: UIImage.avocado,
//                .visible: UIImage.avocado,
//                .invisible: UIImage.avocado.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.Avocado,
//                .visible: UIImage.Avocado.alpha(0.5),
//                .invisible: UIImage.Avocado.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.avocado,
//                .visible: UIImage.avocado,
//                .invisible: UIImage.avocado.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.avocado,
//                .visible: UIImage.avocado,
//                .invisible: UIImage.avocado.alpha(0)
//            ]
//        ]
//
//        let peanut = PinView()
//        peanut.images = [
//            .bases : [
//                .focused: UIImage.peanut,
//                .visible: UIImage.peanut,
//                .invisible: UIImage.peanut.alpha(0)
//            ],
//            .fats : [
//                .focused: UIImage.Peanut,
//                .visible: UIImage.Peanut.alpha(0.5),
//                .invisible: UIImage.Peanut.alpha(0)
//            ],
//            .veggies : [
//                .focused: UIImage.peanut,
//                .visible: UIImage.peanut,
//                .invisible: UIImage.peanut.alpha(0)
//            ],
//            .proteins : [
//                .focused: UIImage.peanut,
//                .visible: UIImage.peanut,
//                .invisible: UIImage.peanut.alpha(0)
//            ]
//        ]
        let coconut = PinView.create.icon(default: UIImage.coconut).icon(UIImage.Coconut, for: .fats)
        let hazelnut = PinView.create.icon(default: UIImage.hazelnut).icon(UIImage.Hazelnut, for: .fats)
        let seeds = PinView.create.icon(default: UIImage.seeds).icon(UIImage.Seeds, for: .fats)
        let brazilnut = PinView.create.icon(default: UIImage.brazilnut).icon(UIImage.Brazilnut, for: .fats)
        let cashewnut = PinView.create.icon(default: UIImage.cashewnut).icon(UIImage.Cashewnut, for: .fats)
        let avocado = PinView.create.icon(default: UIImage.avocado).icon(UIImage.Avocado, for: .fats)
        let peanut = PinView.create.icon(default: UIImage.peanut).icon(UIImage.Peanut, for: .fats)
        
        var pins = [coconut, hazelnut, seeds, brazilnut, cashewnut, avocado, peanut]
        
        let coconut2 = PinView.create.icon(default: UIImage.coconut).icon(UIImage.Coconut, for: .fats)
        let hazelnut2 = PinView.create.icon(default: UIImage.hazelnut).icon(UIImage.Hazelnut, for: .fats)
        let seeds2 = PinView.create.icon(default: UIImage.seeds).icon(UIImage.Seeds, for: .fats)
        let brazilnut2 = PinView.create.icon(default: UIImage.brazilnut).icon(UIImage.Brazilnut, for: .fats)
        let cashewnut2 = PinView.create.icon(default: UIImage.cashewnut).icon(UIImage.Cashewnut, for: .fats)
        let avocado2 = PinView.create.icon(default: UIImage.avocado).icon(UIImage.Avocado, for: .fats)
        let peanut2 = PinView.create.icon(default: UIImage.peanut).icon(UIImage.Peanut, for: .fats)
        
        pins.append(contentsOf: [coconut2, hazelnut2, seeds2, brazilnut2, cashewnut2, avocado2, peanut2])
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(215, CGFloat.pi / 5 * 0.67, CGSize(width: 52, height: 52)),
            .fats: WSettings(215, CGFloat.pi / 5 * 0.67, CGSize(width: 66, height: 66)),
            .veggies: WSettings(210, CGFloat.pi / 5 * 0.67, CGSize(width: 52, height: 52)),
            .proteins: WSettings(210, CGFloat.pi / 5 * 0.67, CGSize(width: 52, height: 52))
        ]
        
        super.init(pins, settings, "fats")
        
    }
    
}
