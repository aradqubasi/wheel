//
//  SWLessButton.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 27/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWLessButton: UIButton {

    init() {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 32)))
        backgroundColor = .white
        setImage(.decrease, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: 4, y: 4), radius: 3, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 1.5, clockwise: true)
        path.addLine(to: CGPoint(x: 43, y: 1))
        path.addLine(to: CGPoint(x: 43, y: 31))
        path.addLine(to: CGPoint(x: 4, y: 31))
        path.addArc(withCenter: CGPoint(x: 4, y: 28), radius: 3, startAngle: CGFloat.pi * 0.5, endAngle: CGFloat.pi, clockwise: true)
        path.close()
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: 1, y: 1))
//        path.addArc(withCenter: CGPoint(x: 41, y: 3), radius: 3, startAngle: -CGFloat.pi * 0.5, endAngle: 0, clockwise: true)
//        path.addArc(withCenter: CGPoint(x: 41, y: 28), radius: 3, startAngle: 0, endAngle: CGFloat.pi * 0.5, clockwise: true)
//        path.addLine(to: CGPoint(x: 1, y: 31))
//        path.close()
        
        
        path.lineWidth = 1
        
        UIColor.shamrock.setStroke()
        path.stroke()
    }

}
