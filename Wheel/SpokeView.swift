//
//  SpokeView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/09/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SpokeView: UIView {
    
    // MARK: - Public Properties
    
    var circle: UIView!
    
    var offset: CGFloat!
    
    var visibility: Bool {
        get {
            return _visibility
        }
        set (new) {
            if (new) {
                circle.backgroundColor = UIColor.black
            }
            else {
                circle.backgroundColor = UIColor.white
            }
            _visibility = new
        }
    }
    
    // MARK: - Private properties
    
    private var _visibility: Bool = true
    
    // MARK: - Initialization
    
    init(point: CGPoint, radius: CGFloat, side: CGFloat, background: UIColor, angle: CGFloat) {
        
        super.init(frame: CGRect(origin: point, size: CGSize(width: side, height: side)))
        
        self.backgroundColor = UIColor.clear
        
        self.offset = angle
        
        self.circle = UIView(frame: CGRect(origin: CGPoint(x: side / 2 - radius, y: 0), size: CGSize(width: radius * 2, height: radius * 2)))
        circle.layer.cornerRadius = radius
        circle.backgroundColor = background
        
        self.addSubview(circle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
