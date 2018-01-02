//
//  SWRadialDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWWheelDelegate {
    
    func numberOfSpokes(in wheel: SWWheelView) -> Int
    
    func radialView(_ wheel: SWWheelView) -> SWWheelSettings
    
    func radialView(pinFor wheel: SWWheelView, at index: Int) -> UIView
    
    func radialView(for wheel: SWWheelView, update spoke: SWSpoke) -> Void
    
//    func radialView(backgroundFor wheel: SWWheelView) -> UIView?
    
//    func radialView(for wheel: SWWheelView, update background: UIView) -> Void
    
}

extension SWWheelDelegate {
    
    func numberOfSpokes(in wheel: SWWheelView) -> Int {
        return 6
    }
    
    func radialView(pinFor wheel: SWWheelView, at index: Int) -> UIView {
        let reddot = UIView(frame: CGRect(center: .zero, side: 32))
        reddot.layer.cornerRadius = 16
        reddot.backgroundColor = .red
        reddot.clipsToBounds = true
        let blackmark = UIView(frame: CGRect(x: 16 - 4, y: -8, width: 8, height: 24))
        blackmark.layer.cornerRadius = 4
        blackmark.backgroundColor = index == 0 ? .white : .black
        reddot.addSubview(blackmark)
        return reddot
    }
    
    func radialView(_ wheel: SWWheelView) -> SWWheelSettings {
//        let radius = min(wheel.view.bounds.width, wheel.view.bounds.height) * 0.5
        let radius = min(wheel.bounds.width, wheel.bounds.height) * 0.5
        let distance = 2 * CGFloat.pi / CGFloat(wheel.count)
        let offset = CGFloat(0)
        return SWWheelSettings(radius, distance, offset, 1)
    }
    
    func radialView(for wheel: SWWheelView, update spoke: SWSpoke) -> Void {
        
    }
    
}
