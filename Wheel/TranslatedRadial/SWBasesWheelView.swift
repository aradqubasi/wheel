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
        
        var spokes: [SWSpoke] = []
        
        let romainelettuce = PinView.create.name("romainelettuce").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
//        romainelettuce.delegate = self
        spokes.append(SWSpoke.init(UIView(), romainelettuce, 0, true, 0))
        
        let salad = PinView.create.name("salad").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
//        salad.delegate = self
        spokes.append(SWSpoke.init(UIView(), salad, 1, false, 0))
        
        let cabbage = PinView.create.name("cabbage").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
//        cabbage.delegate = self
        spokes.append(SWSpoke.init(UIView(), cabbage, 2, false, 0))
        
        let lettuce = PinView.create.name("lettuce").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
//        lettuce.delegate = self
        spokes.append(SWSpoke.init(UIView(), lettuce, 3, false, 0))
        
        let spinach = PinView.create.name("spinach").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
//        spinach.delegate = self
        spokes.append(SWSpoke.init(UIView(), spinach, 4, false, 0))
        
        let brusselssprouts = PinView.create.name("brusselssprouts").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
//        brusselssprouts.delegate = self
        spokes.append(SWSpoke.init(UIView(), brusselssprouts, 5, false, 0))
        
        let zoodles = PinView.create.name("zoodles").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
//        zoodles.delegate = self
        spokes.append(SWSpoke.init(UIView(), zoodles, 6, false, 0))
        
        let shavedfennel = PinView.create.name("shavedfennel").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
//        shavedfennel.delegate = self
        spokes.append(SWSpoke.init(UIView(), shavedfennel, 7, false, 0))
        
        let basePinWidth: CGFloat = 52
        
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
        
//        let settings: [WState : WSettings] = [
//            .bases: WSettings(169, 1.25),
//            .fats: WSettings(144, 1),
//            .veggies: WSettings(144, 1),
//            .proteins: WSettings(144, 1)
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
            return .bases
        }
    }
    
}
