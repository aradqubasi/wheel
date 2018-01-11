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
            
        let settings: [WState : WSettings] = [
            .bases: WSettings(155, CGFloat.pi * 2 / 8, CGSize(side: 52), CGFloat.pi, 1.25),
            .fats: WSettings(141, CGFloat.pi * 2 / 8, CGSize(side: 52), CGFloat.pi, 1),
            .veggies: WSettings(141, CGFloat.pi * 2 / 8, CGSize(side: 52), CGFloat.pi, 1),
            .proteins: WSettings(141, CGFloat.pi * 2 / 8, CGSize(side: 52), CGFloat.pi, 1)
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
            return .bases
        }
    }
    
}
