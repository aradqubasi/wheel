//
//  ScreenView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 19/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ScreenView: UIView {

    // MARK: - Public properties
    
    var delegate: HitDelegate?
    
    /**inner radius of circle of touch section*/
    var _inner: CGFloat = 0
    
    /**outer radius of circle of touch section*/
    var _outer: CGFloat = 0
    
    /**angle of touch section*/
    var _angle: CGFloat = 0

    // MARK: - Overriden Methods
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let side = frame.width / 2
        let x2 = (point.x - side) * (point.x - side)
        let y2 = (point.y - side) * (point.y - side)
        let ir2 = _inner * _inner
        let or2 = _outer * _outer
        
        let first = CGPoint(x: side, y: side)
        let north = _angle * side
//        print(_angle)
        
        let left = CGPoint(x: side - north / 2, y: 0)
        let mleft = (left.y - first.y) / (left.x - first.x)
        let expectedLeftY = mleft * (point.x - first.x) + first.y
        
        let right = CGPoint(x: side + north / 2, y: 0)
        let mright = (right.y - first.y) / (right.x - first.x)
        let expectedRightY = mright * (point.x - first.x) + first.y
        
        if x2 + y2 >= ir2 && x2 + y2 <= or2 {

            if point.y <= expectedLeftY && point.y <= expectedRightY {
                delegate?.on(hit: self, with: event)
//                let dot = UIView(frame: CGRect(center: point, side: 5))
//                dot.backgroundColor = UIColor.red
//                dot.layer.cornerRadius = 2.5
//                dot.backgroundColor = UIColor.green
//                self.addSubview(dot)
            }
            
        }
        
        return false
    }
}
