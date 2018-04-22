//
//  SWRingView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWRingMaskView: UIView {
    
    // MARK: - Public Properties

    /**thickness of the ring, starts at the edge down to center, 0 < _thickness <= _radius */
    var _thickness: CGFloat!
    
    /**center of the ring in the view*/
    var _center: CGPoint!
    
    /**radius of the ring in the view, _radius >= _thickness*/
    var _radius: CGFloat!
    
    /**delegate to report hits through mask to*/
    var delegate: SWRingMaskDelegate?
    
//    var _dots: [UIView] = []
    
    // MARK: - Overrriden Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if event?.type == .touches {
            delegate?.onHit(self, with: event, on: nil)
        }
        super.touchesBegan(touches, with: event)
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        
//        let hitted = super.hitTest(point, with: event)
//        if event?.type == .touches && hitted != nil {
//            delegate?.onHit(self, with: event, on: hitted)
//        }
//        return hitted
//    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let x2 = (point.x - _center.x) * (point.x - _center.x)
        let y2 = (point.y - _center.y) * (point.y - _center.y)
        let ir2 = (_radius - _thickness) * (_radius - _thickness)
        let or2 = (_radius) * (_radius)
        
        if x2 + y2 >= ir2 && x2 + y2 <= or2 {
//            do {
//                print("inside")
//                let dot = UIView()
//                dot.center = point
//                dot.frame.size = CGSize(side: 4)
//                dot.backgroundColor = .green
//                addSubview(dot)
//                _dots.append(dot)
//            }
//            print("point(inside:)->true \(point)")
            return true
        }
        else {
//            do {
//                print("outside")
//                let dot = UIView()
//                dot.center = point
//                dot.frame.size = CGSize(side: 4)
//                dot.backgroundColor = .red
//                addSubview(dot)
//                _dots.append(dot)
//            }
//            print("point(inside:)->false \(point)")
            return false
        }
    }
}
