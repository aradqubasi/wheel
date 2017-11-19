//
//  File.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol RVDelegate: HitDelegate {
    
    func numberOfSpokes(in wheel: RadialView) -> Int

    func radialView(_ wheel: RadialView) -> RVSettings
    
    func radialView(pinFor wheel: RadialView, at index: Int) -> UIView
    
    func radialView(for wheel: RadialView, update pin: UIView, in state: SVState, at index: Int) -> Void
    
    func radialView(backgroundFor wheel: RadialView) -> UIView?
    
    func radialView(for wheel: RadialView, update background: UIView) -> Void

}
