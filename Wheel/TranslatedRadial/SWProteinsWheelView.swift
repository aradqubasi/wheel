//
//  SWProteinsWheelView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 12/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWProteinsWheelView: SWWheelView {
    
    // MARK: - Initialization
    
    init(in container: UIView) {
        
        let name = "Proteins"
        
        var spokes: [SWSpoke] = []
        //real
        do {
            
            let chickpeas = PinView.create.name("chickpeas").icon(default: UIImage.chickpeas).icon(UIImage.Chickpeas, for: .proteins).icon(selected: UIImage.Chickpeas).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), chickpeas, 0, true, 0))
            
            let fish = PinView.create.name("fish").icon(default: UIImage.fish).icon(UIImage.Fish, for: .proteins).icon(selected: UIImage.Fish).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), fish, 1, false, 0))
            
            let boiledegg = PinView.create.name("boiledegg").icon(default: UIImage.boiledegg).icon(UIImage.Boiledegg, for: .proteins).icon(selected: UIImage.Boiledegg).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), boiledegg, 2, false, 0))
            
            let beans = PinView.create.name("beans").icon(default: UIImage.beans).icon(UIImage.Beans, for: .proteins).icon(selected: UIImage.Beans).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), beans, 3, false, 0))
            
            let peas = PinView.create.name("peas").icon(default: UIImage.peas).icon(UIImage.Peas, for: .proteins).icon(selected: UIImage.Peas).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), peas, 4, false, 0))
            
            let friedegg = PinView.create.name("friedegg").icon(default: UIImage.friedegg).icon(UIImage.Friedegg, for: .proteins).icon(selected: UIImage.Friedegg).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), friedegg, 5, false, 0))
            
            let lentils = PinView.create.name("lentils").icon(default: UIImage.lentils).icon(UIImage.Lentils, for: .proteins).icon(selected: UIImage.Lentils).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), lentils, 6, false, 0))
            
            let mushrooms = PinView.create.name("mushrooms").icon(default: UIImage.mushrooms).icon(UIImage.Mushrooms, for: .proteins).icon(selected: UIImage.Mushrooms).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), mushrooms, 7, false, 0))
            
            let shrimp = PinView.create.name("shrimp").icon(default: UIImage.shrimp).icon(UIImage.Shrimp, for: .proteins).icon(selected: UIImage.Shrimp).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), shrimp, 8, false, 0))
            
        }
        
        //fillers
        do {
            
            let chickpeas = PinView.create.name("chickpeas").icon(default: UIImage.chickpeas).icon(UIImage.Chickpeas, for: .proteins).icon(selected: UIImage.Chickpeas).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), chickpeas, 9, true, 0))
            
            let fish = PinView.create.name("fish").icon(default: UIImage.fish).icon(UIImage.Fish, for: .proteins).icon(selected: UIImage.Fish).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), fish, 10, false, 0))
            
            let boiledegg = PinView.create.name("boiledegg").icon(default: UIImage.boiledegg).icon(UIImage.Boiledegg, for: .proteins).icon(selected: UIImage.Boiledegg).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), boiledegg, 11, false, 0))
            
            let beans = PinView.create.name("beans").icon(default: UIImage.beans).icon(UIImage.Beans, for: .proteins).icon(selected: UIImage.Beans).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), beans, 12, false, 0))
            
            let peas = PinView.create.name("peas").icon(default: UIImage.peas).icon(UIImage.Peas, for: .proteins).icon(selected: UIImage.Peas).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), peas, 13, false, 0))
            
            let friedegg = PinView.create.name("friedegg").icon(default: UIImage.friedegg).icon(UIImage.Friedegg, for: .proteins).icon(selected: UIImage.Friedegg).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), friedegg, 14, false, 0))
            
            let lentils = PinView.create.name("lentils").icon(default: UIImage.lentils).icon(UIImage.Lentils, for: .proteins).icon(selected: UIImage.Lentils).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), lentils, 15, false, 0))
            
            let mushrooms = PinView.create.name("mushrooms").icon(default: UIImage.mushrooms).icon(UIImage.Mushrooms, for: .proteins).icon(selected: UIImage.Mushrooms).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), mushrooms, 16, false, 0))
            
            let shrimp = PinView.create.name("shrimp").icon(default: UIImage.shrimp).icon(UIImage.Shrimp, for: .proteins).icon(selected: UIImage.Shrimp).kind(of: .protein)
            spokes.append(SWSpoke.init(UIView(), shrimp, 17, false, 0))
            
        }
        
        let settings: [WState: WSettings] = [
            .bases: WSettings(353, CGFloat.pi * 2 / 18, CGSize(width: 52, height: 52), CGFloat.pi, 1),
            .fats: WSettings(353, CGFloat.pi * 2 / 18, CGSize(width: 52, height: 52), CGFloat.pi, 1),
            .veggies: WSettings(353, CGFloat.pi * 2 / 18, CGSize(width: 52, height: 52), CGFloat.pi, 1),
            .proteins: WSettings(353, CGFloat.pi * 2 / 18, CGSize(width: 66, height: 66), CGFloat.pi, 1.25)
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
            return .proteins
        }
    }
    
}
