//
//  RadialControllerDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol RadialControllerDelegate {
    
    func onStateChange(to state: WState, of wheel: SWAbstractWheelView) -> Void
    
//    func onPinClick(in controller: RadialController, of pin: PinView, at index: Int) -> Void
//
//    func radialController(preesing pin: PinView, in controller: RadialController, at index: Int) -> Void
    
    func onPinClick(in controller: SWAbstractWheelController, of pin: PinView, at index: Int) -> Void
    
    func radialController(preesing pin: PinView, in controller: SWAbstractWheelController, at index: Int) -> Void
    
}