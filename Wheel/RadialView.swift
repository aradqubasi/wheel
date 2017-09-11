//
//  RadialView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class RadialView: UIView {
    
    // MARK: - Public Properties
    
    var delegate: RadialViewDelegate?
    
    var current: CGFloat {
        get {
            var angle = _current
            while angle > CGFloat.pi * 2  {
                angle -= CGFloat.pi * 2
            }
            return angle
        }
    }
    
    // MARK: - Private Properties
    
    private var _spokes: [SpokeView] = []
    
    private var _current: CGFloat = 0
    
    private var _offset: CGFloat = 0
    
    private var _top: CGFloat = CGFloat.pi / 2
    
    private var _bottom: CGFloat = CGFloat.pi / 2
    
    private var _radius: CGFloat = 100
    
    private let _distance: CGFloat = CGFloat.pi / 6
    
    private let _decelerate: CGFloat = 1000
    
    private var _velocity: CGFloat = 0
    
    private var _moving: Bool = false
    
    // MARK: - Initialization
    
    init(center: CGPoint) {
        super.init(frame: .zero)
        self.frame.origin = CGPoint(x: center.x - _radius * CGFloat(2).squareRoot(), y: center.y - _radius * CGFloat(2).squareRoot())
        self.frame.size.width = _radius * 2 * CGFloat(2).squareRoot()
        self.frame.size.height = _radius * 2 * CGFloat(2).squareRoot()
        
        self.backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func onSomething() {

    }
    
    func addSpoke() {
        let offset = CGFloat(_spokes.count) * _distance
        
        let origin = CGPoint(x: frame.width / 2 - _radius, y: frame.width / 2 - _radius)
        
        let spoke = SpokeView(point: origin, radius: _radius / 6, side: _radius * 2, background: UIColor.black, angle: offset)
        
        _spokes.append(spoke)
        
        self.addSubview(spoke)
        
        show()
    }
    
    func rotate(by angle: CGFloat) {
        _current += angle
        
        show()
    }
    
    func left() {
        _current -= CGFloat.pi / 12
        
        show()
    }
    
    func right() {
        _current += CGFloat.pi / 12
        
        show()
    }
    
    func push(_ force: CGFloat) {
        _velocity += force
    }
    
    // MARK: - Private Methods
    
    func show() {
        let angle = _current + _offset
        for spoke in _spokes {
            let spokeAngle = spoke.offset + angle
            spoke.transform = CGAffineTransform(rotationAngle: spokeAngle)
            if spokeAngle > _top + _offset {
                spoke.visibility = false
            }
            else if spokeAngle < -_bottom + _offset {
                spoke.visibility = false
            }
            else {
                spoke.visibility = true
            }
        }
    }
    
    func move() {
        for spoke in _spokes {
            spoke.push(1000)
        }
    }
    
    // MARK: - Placeholders
    
    
}
