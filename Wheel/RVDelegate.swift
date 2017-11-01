//
//  File.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol RVDelegate {
    func numberOfSpokes(in wheel: RadialView) -> Int
    
    func radialView(_ wheel: RadialView, _ wheelAt: RVState) -> RVSettings
    
//    func radialView(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ spokeAt: RVSpokeState, _ indexIs: Int) -> SVSettings
    
    func radialView(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ pin: UIView?, _ spokeAt: RVSpokeState, _ indexIs: Int) -> UIView

    func onPinClick(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ spokeAt: RVSpokeState, _ indexIs: Int) -> Void
}
