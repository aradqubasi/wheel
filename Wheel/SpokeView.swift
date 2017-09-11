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
    
    private var _velocity: CGFloat = 0
    
    private var _energy: CGFloat = 0
    
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
    
    // MARK: - Private Methods
    
    func move() {
        UIView.animate(withDuration: 0.2, animations: {
            print("move: \(self._velocity) \(self._energy)")
            let angle = self._velocity * 0.2 / (CGFloat.pi * 2 * self.frame.size.width) + self.offset
            self.transform = CGAffineTransform(rotationAngle: angle)
        }, completion: { (success: Bool) in
            print("completion: \(self._velocity) \(self._energy)")
            self._energy = max(0, self._energy - self._velocity * 0.2)
            if self._energy != 0 {
                self.move()
            }
        })
    }
    
    // MARK: - Public Methods
    
    func push(_ velocity: CGFloat) {
        _velocity = velocity
        _energy = velocity * 3
        move()
    }
}
