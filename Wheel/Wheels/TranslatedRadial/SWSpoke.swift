//
//  SWSpoke.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWSpoke {
    let socket: UIView
    let pin: PinView
    let index: Int
    var focused: Bool
    var angle: CGFloat
    init(_ socket: UIView, _ pin: PinView, _ index: Int, _ focused: Bool, _ angle: CGFloat) {
        self.socket = socket
        self.pin = pin
        self.index = index
        self.focused = focused
        self.angle = angle
    }
}
