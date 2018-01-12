//
//  SWVeggiesWheelView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 12/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWVeggiesWheelView: SWWheelView {
    
    // MARK: - Initialization
    
    init(in container: UIView) {
        
        let name = "Veggies"
        
        var spokes: [SWSpoke] = []
        //real
        do {

            let aubergine = PinView.create.name("aubergine").icon(default: UIImage.aubergine).icon(UIImage.Aubergine, for: .veggies).icon(selected: UIImage.Aubergine).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), aubergine, 0, true, 0))
            
            let tomato = PinView.create.name("tomato").icon(default: UIImage.tomato).icon(UIImage.Tomato, for: .veggies).icon(selected: UIImage.Tomato).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), tomato, 1, false, 0))
            
            let radish = PinView.create.name("radish").icon(default: UIImage.radish).icon(UIImage.Radish, for: .veggies).icon(selected: UIImage.Radish).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), radish, 2, false, 0))
            
            let pepper = PinView.create.name("pepper").icon(default: UIImage.pepper).icon(UIImage.Pepper, for: .veggies).icon(selected: UIImage.Pepper).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), pepper, 3, false, 0))
            
            let broccoli = PinView.create.name("broccoli").icon(default: UIImage.broccoli).icon(UIImage.Broccoli, for: .veggies).icon(selected: UIImage.Broccoli).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), broccoli, 4, false, 0))
            
            let carrot = PinView.create.name("carrot").icon(default: UIImage.carrot).icon(UIImage.Carrot, for: .veggies).icon(selected: UIImage.Carrot).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), carrot, 5, false, 0))
            
            let asparagus = PinView.create.name("asparagus").icon(default: UIImage.asparagus).icon(UIImage.Asparagus, for: .veggies).icon(selected: UIImage.Asparagus).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), asparagus, 6, false, 0))
            
            let cauliflower = PinView.create.name("cauliflower").icon(default: UIImage.cauliflower).icon(UIImage.Cauliflower, for: .veggies).icon(selected: UIImage.Cauliflower).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), cauliflower, 7, false, 0))
            
            let corn = PinView.create.name("corn").icon(default: UIImage.corn).icon(UIImage.Corn, for: .veggies).icon(selected: UIImage.Corn).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), corn, 8, false, 0))
            
        }
        
        //fillers
        do {
            let aubergine = PinView.create.name("aubergine").icon(default: UIImage.aubergine).icon(UIImage.Aubergine, for: .veggies).icon(selected: UIImage.Aubergine).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), aubergine, 9, false, 0))
            
            let tomato = PinView.create.name("tomato").icon(default: UIImage.tomato).icon(UIImage.Tomato, for: .veggies).icon(selected: UIImage.Tomato).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), tomato, 10, false, 0))
            
            let radish = PinView.create.name("radish").icon(default: UIImage.radish).icon(UIImage.Radish, for: .veggies).icon(selected: UIImage.Radish).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), radish, 11, false, 0))
            
            let pepper = PinView.create.name("pepper").icon(default: UIImage.pepper).icon(UIImage.Pepper, for: .veggies).icon(selected: UIImage.Pepper).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), pepper, 12, false, 0))
            
            let broccoli = PinView.create.name("broccoli").icon(default: UIImage.broccoli).icon(UIImage.Broccoli, for: .veggies).icon(selected: UIImage.Broccoli).kind(of: .veggy)
            spokes.append(SWSpoke.init(UIView(), broccoli, 13, false, 0))
        }
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(284, CGFloat.pi * 2 / 14, CGSize(width: 52, height: 52), CGFloat.pi, 1),
            .fats: WSettings(284, CGFloat.pi * 2 / 14, CGSize(width: 52, height: 52), CGFloat.pi, 1),
            .veggies: WSettings(284, CGFloat.pi * 2 / 14, CGSize(width: 66, height: 66), CGFloat.pi, 1.25),
            .proteins: WSettings(279, CGFloat.pi * 2 / 14, CGSize(width: 52, height: 52), CGFloat.pi, 1)
        ]
        
        let leftward = CGFloat.pi
        
        super.init(in: container, with: spokes, use: settings, facing: leftward, as: name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overridees
    
    override var active: WState {
        get {
            return .veggies
        }
    }
    
}
