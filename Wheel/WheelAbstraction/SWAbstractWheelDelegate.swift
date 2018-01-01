//
//  SWAbstractWheelDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol SWAbstractWheelDelegate {
    
    func numberOfSpokes(in wheel: SWAbstractWheelView) -> Int
    
    func radialView(_ wheel: SWAbstractWheelView) -> SWWheelSettings
    
    func radialView(pinFor wheel: SWAbstractWheelView, at index: Int) -> UIView
    
    func radialView(for wheel: SWAbstractWheelView, update pin: UIView, in state: SVState, at index: Int) -> Void
    
    func radialView(backgroundFor wheel: SWAbstractWheelView) -> UIView?
    
    func radialView(for wheel: SWAbstractWheelView, update background: UIView) -> Void
    
}
