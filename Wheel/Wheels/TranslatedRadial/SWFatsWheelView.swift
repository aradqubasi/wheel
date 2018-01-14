//
//  SWFatsWheelView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 12/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWFatsWheelView: SWWheelView {
    
    // MARK: - Initialization
    
    init(in container: UIView) {
        
        let name = "Fats"
        
        var spokes: [SWSpoke] = []
        //real fats
        do {
            let coconut = PinView.create.name("coconut").icon(default: UIImage.coconut).icon(UIImage.Coconut, for: .fats).icon(selected: UIImage.Coconut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), coconut, 0, true, 0))
            
            let hazelnut = PinView.create.name("hazelnut").icon(default: UIImage.hazelnut).icon(UIImage.Hazelnut, for: .fats).icon(selected: UIImage.Hazelnut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), hazelnut, 1, false, 0))
            
            let seeds = PinView.create.name("seeds").icon(default: UIImage.seeds).icon(UIImage.Seeds, for: .fats).icon(selected: UIImage.Seeds).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), seeds, 2, false, 0))
            
            let brazilnut = PinView.create.name("brazilnut").icon(default: UIImage.brazilnut).icon(UIImage.Brazilnut, for: .fats).icon(selected: UIImage.Brazilnut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), brazilnut, 3, false, 0))
            
            let cashewnut = PinView.create.name("cashewnut").icon(default: UIImage.cashewnut).icon(UIImage.Cashewnut, for: .fats).icon(selected: UIImage.Cashewnut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), cashewnut, 4, false, 0))
            
            let avocado = PinView.create.name("avocado").icon(default: UIImage.avocado).icon(UIImage.Avocado, for: .fats).icon(selected: UIImage.Avocado).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), avocado, 5, false, 0))
            
            let peanut = PinView.create.name("peanut").icon(default: UIImage.peanut).icon(UIImage.Peanut, for: .fats).icon(selected: UIImage.Peanut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), peanut, 6, false, 0))
            
        }
        
        //fillers
        do {
            let coconut = PinView.create.name("coconut").icon(default: UIImage.coconut).icon(UIImage.Coconut, for: .fats).icon(selected: UIImage.Coconut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), coconut, 7, false, 0))
            
            let hazelnut = PinView.create.name("hazelnut").icon(default: UIImage.hazelnut).icon(UIImage.Hazelnut, for: .fats).icon(selected: UIImage.Hazelnut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), hazelnut, 8, false, 0))
            
            let seeds = PinView.create.name("seeds").icon(default: UIImage.seeds).icon(UIImage.Seeds, for: .fats).icon(selected: UIImage.Seeds).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), seeds, 9, false, 0))
            
            let brazilnut = PinView.create.name("brazilnut").icon(default: UIImage.brazilnut).icon(UIImage.Brazilnut, for: .fats).icon(selected: UIImage.Brazilnut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), brazilnut, 10, false, 0))
            
            let cashewnut = PinView.create.name("cashewnut").icon(default: UIImage.cashewnut).icon(UIImage.Cashewnut, for: .fats).icon(selected: UIImage.Cashewnut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), cashewnut, 11, false, 0))
            
            let avocado = PinView.create.name("avocado").icon(default: UIImage.avocado).icon(UIImage.Avocado, for: .fats).icon(selected: UIImage.Avocado).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), avocado, 12, false, 0))
            
            let peanut = PinView.create.name("peanut").icon(default: UIImage.peanut).icon(UIImage.Peanut, for: .fats).icon(selected: UIImage.Peanut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), peanut, 13, false, 0))
            
            let coconut2 = PinView.create.name("coconut").icon(default: UIImage.coconut).icon(UIImage.Coconut, for: .fats).icon(selected: UIImage.Coconut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), coconut2, 14, false, 0))
            
            let hazelnut2 = PinView.create.name("hazelnut").icon(default: UIImage.hazelnut).icon(UIImage.Hazelnut, for: .fats).icon(selected: UIImage.Hazelnut).kind(of: .fat)
            spokes.append(SWSpoke.init(UIView(), hazelnut2, 15, false, 0))
        }
        
        let basePinWidth: CGFloat = 42
        
        let inset: CGFloat = 5

        var settings: [WState : WSettings] = [:]
        do {
            let inset = inset
            let activeScale: CGFloat = 1
            let usualScale: CGFloat = 1
            let pin: CGFloat = basePinWidth
            let mark: CGFloat = 14
            let pointer: CGFloat = 12
            let foundation: CGFloat = 78
            let activeState: WState = .fats
            let number: Int = 2
            
            let usualThickness: CGFloat = mark + pin * usualScale + inset
            let activeThickness: CGFloat = pointer + mark + pin * activeScale + inset
            let states: [WState] = [.bases, .fats, .veggies, .proteins]
            var before = true
            for state in states {
                let isActive = state == activeState
                before = isActive ? false : before
                let radius: CGFloat = foundation + CGFloat(number - 1) * usualThickness + (before || isActive ? activeThickness : usualThickness)
                settings[state] = WSettings(radius, isActive ? activeScale : usualScale)
            }
        }
//        let settings: [WState: WSettings] = [
//            .bases: WSettings(235, 1),
//            .fats: WSettings(235, 1.25),
//            .veggies: WSettings(210, 1),
//            .proteins: WSettings(210, 1)
//        ]
        
        let leftward = CGFloat.pi
        
        super.init(in: container, with: spokes, use: settings, facing: leftward, as: name, basePinWidth, inset)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridees
    
    override var active: WState {
        get {
            return .fats
        }
    }
    
}
