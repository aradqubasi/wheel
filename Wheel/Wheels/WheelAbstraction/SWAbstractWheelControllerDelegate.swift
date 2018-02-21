//
//  SWAbstractWheelControllerDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 21/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWAbstractWheelControllerDelegate {
    
    func onStateChange(_ sender: SWAbstractWheelController, to state: WState) -> Void
    
    func onPinClick(_ sender: SWAbstractWheelController, of pin: PinView, at index: Int) -> Void
    
    func onPinPress(_ sender: SWAbstractWheelController, of pin: PinView, at index: Int) -> Void
    
}
