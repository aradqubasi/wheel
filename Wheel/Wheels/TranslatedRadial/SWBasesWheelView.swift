//
//  SWBasesWheelView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWBasesWheelView: SWWheelView {
    
    // MARK: - Initialization
    
    init(in container: UIView) {
        
        let name = "Bases"
        
        var pins: [PinView] = [
            .romainelettuce,
            .salad,
            .cabbage,
            .lettuce,
            .spinach,
            // loop over
            .romainelettuce,
            .salad,
            .cabbage,
            .lettuce,
            .spinach,
            .romainelettuce,
            .salad
        ]
        
        var spokes: [SWSpoke] = []
        for index in 0..<pins.count {
            spokes.append(SWSpoke.init(UIView(), pins[index], index, false, 0))
        }
        spokes.first!.focused = true

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
            let activeState: WState = .bases
            let number: Int = 1
            
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
        
        let leftward = CGFloat.pi
        
        super.init(in: container, with: spokes, use: settings, facing: leftward, as: name, basePinWidth, inset)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridees
    
    override var active: WState {
        get {
            return .bases
        }
    }
    
}
