//
//  SWMoreButton.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 27/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWMoreButton: UIButton {
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 32)))
        backgroundColor = .white
        setImage(.increase, for: .normal)
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.shamrock.cgColor
//        let path = UIBezierPath(roundedRect:button.bounds, byRoundingCorners:[.topRight, .bottomRight], cornerRadii: CGSize(width: 3, height:  3))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        button.layer.mask = maskLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 0, y: 3))
//        path.addArc(withCenter: CGPoint(x: 3, y: 3), radius: 3, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 1.5, clockwise: true)
//        path.addLine(to: CGPoint(x: 3, y: 0))
//        path.addLine(to: CGPoint(x: 43, y: 0))
//        path.addLine(to: CGPoint(x: 43, y: 31))
//        path.addLine(to: CGPoint(x: 3, y: 31))
//        path.addArc(withCenter: CGPoint(x: 3, y: 28), radius: 3, startAngle: CGFloat.pi * 0.5, endAngle: CGFloat.pi, clockwise: true)
//        path.addLine(to: CGPoint(x: 0, y: 28))
//        path.close()
//
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 1, y: 4))
//        path.addArc(withCenter: CGPoint(x: 3, y: 3), radius: 3, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 1.5, clockwise: true)
//        path.addLine(to: CGPoint(x: 4, y: 1))
//        path.addLine(to: CGPoint(x: 43, y: 1))
//        path.addLine(to: CGPoint(x: 43, y: 31))
//        path.addLine(to: CGPoint(x: 4, y: 31))
//        path.addArc(withCenter: CGPoint(x: 4, y: 28), radius: 3, startAngle: CGFloat.pi * 0.5, endAngle: CGFloat.pi, clockwise: true)
//        path.addLine(to: CGPoint(x: 1, y: 28))
//        path.close()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 1, y: 1))
        path.addArc(withCenter: CGPoint(x: 40, y: 4), radius: 3, startAngle: -CGFloat.pi * 0.5, endAngle: 0, clockwise: true)
        path.addArc(withCenter: CGPoint(x: 40, y: 28), radius: 3, startAngle: 0, endAngle: CGFloat.pi * 0.5, clockwise: true)
        
        path.addLine(to: CGPoint(x: 1, y: 31))

        path.close()
        
        path.lineWidth = 1
        
        UIColor.shamrock.setStroke()
        path.stroke()
    }
}
