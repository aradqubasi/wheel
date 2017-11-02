//
//  PVDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol PVDelegate {
    func onTouchesBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void
    func onTouchesMoved(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void
    func onTouchesEnded(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void
    func onTouchCanceled(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void
}
extension PVDelegate {
    func onTouchesBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        print("onTouchBegan")
    }
    func onTouchesMoved(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        print("onTouchMove")
    }
    func onTouchesEnded(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        print("onTouchEnd")
    }
    func onTouchCanceled(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        print("onTouchCancel")
    }
}
