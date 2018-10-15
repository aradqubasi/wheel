//
//  SWWheelsAligner.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol SWWheelsAligner {
    
    func align(unexpected: UIView)
    
    func align(fruits: UIView)
    
    func align(dressing: UIView)
    
    func align(subwheel: UIView, with button: UIView)
    
    func alignToCenter(subwheel: UIView)
    
    func getOverlayMargin() -> CGFloat
    
    func alignCircle(views: [UIView], center: CGPoint, radius: CGFloat, rotation: CGFloat)
    
}
