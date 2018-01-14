//
//  BackgroundView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.tanhide, UIColor.persimmon, UIColor.radicalred]
        gradient.frame = CGRect(origin: .zero, size: frame.size)
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.locations = [0, 0.33, 1]
        layer.addSublayer(gradient)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
