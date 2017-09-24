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
    
    private var _minvelocity: CGFloat = CGFloat.pi / 6
    
    private var _maxvelocity: CGFloat = CGFloat.pi
    
    private var _topvelocity: CGFloat = CGFloat.pi * 2
    
    private var _decelerate: CGFloat = CGFloat.pi
    
//    private var _moving: Bool = false
//    
//    private var _following: Bool = false
    
    private var _spinState: RVSpinState = .calm
    
    private var _animating: Bool = false
    
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
//        for spoke in _spokes {
//            let spokeAngle = spoke.offset + _current
//            spoke.transform = CGAffineTransform(rotationAngle: spokeAngle)
//            if spokeAngle > _offset + _top {
//                spoke.visibility = false
//            }
//            else if spokeAngle < _offset - _bottom {
//                spoke.visibility = false
//            }
//            else {
//                spoke.visibility = true
//            }
//        }
        for n in 0..<_spokes.count {
            let spokeAngle = _distance * CGFloat(n) + _current
            let spoke = _spokes[n]
            spoke.transform = CGAffineTransform(rotationAngle: spokeAngle)
            if spokeAngle > _offset + _top {
                spoke.state = .invisible
            }
            else if spokeAngle < _offset - _bottom {
                spoke.state = .invisible
            }
            else if spokeAngle > _offset + _distance / 2 {
                spoke.state = .visible
            }
            else if spokeAngle < _offset - _distance / 2 {
                spoke.state = .visible
            }
            else {
                spoke.state = .focused
            }
        }
    }

    func move(override: Bool) {
        if override || !_animating {
            _animating = true
            let spin = {
                switch self._spinState {
                case .calm:
                    print("calming")
                case .following:
                    print("following")
                    self._current += self._velocity * 0.03
                case .decelerate:
                    print("decelerating")
                    let constrainedVelocity = max(min(abs(self._velocity), self._maxvelocity), self._minvelocity)
                    let velocity = CGFloat(sign: self._velocity.sign, exponent: constrainedVelocity.exponent, significand: constrainedVelocity.significand)
                    self._current += velocity * 0.03
                    let newVelocity = max(0, abs(self._velocity) - self._decelerate * 0.03)
                    self._velocity = CGFloat(sign: self._velocity.sign, exponent: newVelocity.exponent, significand: newVelocity.significand)
                case .normalize:
                    print("normalizing")
                    let currentSpokeNumber = (self._offset - self._current) / self._distance
                    let targetSpokeNumber = min(self._spokes.count - 1, max(0, Int(round(currentSpokeNumber))))
                    let targetCurrentAngle = self._offset - (CGFloat(targetSpokeNumber)) * self._distance
                    let delta = self._current - targetCurrentAngle
                    if abs(delta) < 0.03 * self._minvelocity {
                        self._current = targetCurrentAngle
                    }
                    else {
                        let velocity = CGFloat(sign: ((-delta).sign), exponent: self._minvelocity.exponent, significand: self._minvelocity.significand)
                        self._current += velocity * 0.03
                    }
                }
                
                self.show()
            }
            
            let endspin = { (success: Bool) in
                switch self._spinState {
                case .calm:
                    print("end of calming")
                case .following:
                    print("end of following")
                    //self._spinState = .decelerate
                    self.move(override: true)
                case .decelerate:
                    print("end of decelerating")
                    if self._current < self._offset - self._distance * CGFloat((self._spokes.count - 1)) {
                        self._velocity = 0
                        self._spinState = .normalize
                        self.move(override: true)
                    }
                    else if self._current > self._offset {
                        self._velocity = 0
                        self._spinState = .normalize
                        self.move(override: true)
                    }
                    else if self._velocity != 0 {
                        self.move(override: true)
                    }
                    else {
                        self._spinState = .normalize
                        self.move(override: true)
                    }
                case .normalize:
                    print("end of normalizing")
                    let currentSpokeNumber = (self._offset - self._current) / self._distance
                    let targetSpokeNumber = min(self._spokes.count - 1, max(0, Int(round(currentSpokeNumber))))
                    let targetCurrentAngle = self._offset - (CGFloat(targetSpokeNumber)) * self._distance
                    let delta = self._current - targetCurrentAngle
                    if delta != 0 {
                        self.move(override: true)
                    }
                    else {
                        self._spinState = .calm
                        self._animating = false
                    }
                }
            }
            
            UIView.animate(withDuration: 0.03, animations: spin, completion: endspin)
        }

    }
    
//    func move(override: Bool) {
//        if override || !self._moving {
//            self._moving = true
//            
//            let spin = {
//                let constrainedVelocity = min(abs(self._velocity), self._maxvelocity)
//                let velocity = CGFloat(sign: self._velocity.sign, exponent: constrainedVelocity.exponent, significand: constrainedVelocity.significand)
//                self._current += velocity * 0.03
//                if !self._following {
//                    let newVelocity = max(0, abs(self._velocity) - self._decelerate * 0.03)
//                    self._velocity = CGFloat(sign: self._velocity.sign, exponent: newVelocity.exponent, significand: newVelocity.significand)
//                }
//                self.show()
//            }
//            
//            let endspin = { (success: Bool) in
//                if self._velocity != 0 {
//                    self.move(override: true)
//                }
//                else {
//                    self._moving = false
//                }
//            }
//            
//            UIView.animate(withDuration: 0.03, animations: spin, completion: endspin)
//        }
//    }
    
    func push(_ speed: CGFloat) {
        _velocity += max(_velocity, speed)
        move(override: false)
    }
    
    func beginFollow(at angle: CGFloat) {
        _spinState = .following
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
        _spinState = .decelerate
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
