//
//  SpokeView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/09/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SpokeView: UIView {
    
    init(point: CGPoint, radius: CGFloat, side: CGFloat, background: UIColor, angle: CGFloat) {
        
        super.init(frame: CGRect(origin: point, size: CGSize(width: side, height: side)))
        
        self.backgroundColor = UIColor.clear
        
        let circle = UIView(frame: CGRect(origin: point, size: CGSize(width: radius * 2, height: radius * 2)))
        circle.layer.cornerRadius = radius
        circle.backgroundColor = background
        
        self.addSubview(circle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
