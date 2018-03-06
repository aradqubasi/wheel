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
    
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2)
        self.init(origin: origin, size: size)
    }
    
    // MARK: - Helpers
    
    func shrinkify(by margin: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: origin.x + margin, y: origin.y + margin), size: CGSize(width: size.width - margin * 2, height: size.height - margin * 2))
    }
    
}
