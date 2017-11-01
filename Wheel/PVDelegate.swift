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
    func onTouchBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void
    func onTouchMove(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void
    func onTouchEnd(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void
    func onTouchCancel(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void
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
