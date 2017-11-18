//
//  CGRect.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
extension CGRect {
    
    // MARK: - Custom Initializer
    
    init(center: CGPoint, side: CGFloat) {
        let origin = CGPoint(x: center.x - side / 2, y: center.y - side / 2)
        let size = CGSize(side: side)
        self.init(origin: origin, size: size)
    }
}
