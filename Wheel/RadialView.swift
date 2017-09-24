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
    
    private var _velocity: CGFloat = 0
    
    private var _maxvelocity: CGFloat = CGFloat.pi
    
    private var _topvelocity: CGFloat = CGFloat.pi * 2
    
    private var _decelerate: CGFloat = CGFloat.pi
    
    private var _moving: Bool = false
    
    private var _following: Bool = false
    
    private var _lastFollowTime: Date?
    
    private var _lastFollowAngle: CGFloat?
    
    private var _translationAngle: CGFloat?
    
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

    func move(override: Bool) {
        if override || !self._moving {
            self._moving = true
            
            let spin = {
                let constrainedVelocity = min(abs(self._velocity), self._maxvelocity)
                let velocity = CGFloat(sign: self._velocity.sign, exponent: constrainedVelocity.exponent, significand: constrainedVelocity.significand)
                self._current += velocity * 0.03
                if !self._following {
                    let newVelocity = max(0, abs(self._velocity) - self._decelerate * 0.03)
                    self._velocity = CGFloat(sign: self._velocity.sign, exponent: newVelocity.exponent, significand: newVelocity.significand)
                }
                for spoke in self._spokes {
                    let angle = self._current + self._offset + spoke.offset
                    spoke.transform = CGAffineTransform(rotationAngle: angle)
                }
            }
            
            let endspin = { (success: Bool) in
                if self._velocity != 0 {
                    self.move(override: true)
                }
                else {
                    self._moving = false
                }
            }
            
            UIView.animate(withDuration: 0.03, animations: spin, completion: endspin)
        }
    }
    /*
    func move(override: Bool) {
        if override || !self._moving {
            self._moving = true
            
            UIView.animate(withDuration: 0.05, animations: {
                let constrainedVelocity = min(abs(self._velocity), self._maxvelocity)
                let velocity = CGFloat(sign: self._velocity.sign, exponent: constrainedVelocity.exponent, significand: constrainedVelocity.significand)
                //self._current += velocity * 0.05 / (CGFloat.pi * 2 * self._radius)
                self._current += velocity * 0.05
                if !self._following {
                    let newVelocity = max(0, abs(self._velocity) - self._decelerate * 0.05)
                    self._velocity = CGFloat(sign: self._velocity.sign, exponent: newVelocity.exponent, significand: newVelocity.significand)
                }
                for spoke in self._spokes {
                    let angle = self._current + self._offset + spoke.offset
                    spoke.transform = CGAffineTransform(rotationAngle: angle)
                }
                //print(self._velocity)
            }, completion: { (success: Bool) in
                if self._velocity != 0 {
                    self.move(override: true)
                }
                else {
                    self._moving = false
                }
                //print(self._velocity)
            })
        }
    }
    */
    func push(_ speed: CGFloat) {
        _velocity += max(_velocity, speed)
        move(override: false)
    }
    
    func beginFollow(at angle: CGFloat) {
        _following = true
        _lastFollowTime = Date()
        _lastFollowAngle = angle
    }
    
    func continueFollow(at angle: CGFloat) {
        guard let lastTime = _lastFollowTime, let lastAngle = _lastFollowAngle else {
            fatalError("following did not start")
        }
        
        let deltaTime = -CGFloat(lastTime.timeIntervalSince(Date()))
        let deltaAngle = angle - lastAngle
        //print("deltatime = \(deltaTime)")
        //print(deltaAngle)
        let newVelocity = deltaAngle / deltaTime
        _velocity = CGFloat(sign: newVelocity.sign, exponent: min(abs(newVelocity), _topvelocity).exponent, significand: min(abs(newVelocity), _topvelocity).significand)
        
        //print(_velocity)
        //rotate(by: deltaAngle)
        move(override: false)
        _lastFollowTime = Date()
        _lastFollowAngle = angle
    }
    
    func endFollow() {
        _following = false
        _lastFollowTime = nil
        _lastFollowAngle = nil
        move(override: false)
    }
    
    func stopMoving() {
        _velocity = 0
        move(override: false)
    }
    
    // MARK: - Placeholders
    
    
}
