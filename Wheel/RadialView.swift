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
    
//    var RVRadius: CGFloat {
//        get {
//            return _radius
//        }
//        set (new) {
//            _radius = new
////            frame.origin = CGPoint(x: _center.x - _radius * CGFloat(2).squareRoot(), y: _center.y - _radius * CGFloat(2).squareRoot())
////            frame.size.width = _radius * 2 * CGFloat(2).squareRoot()
////            frame.size.height = _radius * 2 * CGFloat(2).squareRoot()
//            show()
//        }
//    }
    
    var RVCenter: CGPoint {
        get {
            return _center
        }
        set (new) {
            _center = new
//            frame.origin = CGPoint(x: _center.x - _radius * CGFloat(2).squareRoot(), y: _center.y - _radius * CGFloat(2).squareRoot())
            show()
        }
    }
    
//    var RVDistance: CGFloat {
//        get {
//            return _distance
//        }
//        set (new) {
//            _distance = new
//            show()
//        }
//    }
    
    var RVSettings: RVStateSettings {
        get {
            return _settings
        }
        set (new) {
            _settings = new
            show()
        }
    }
    
    // MARK: - Private Properties
    
    private var _center: CGPoint = .zero
    
    private var _spokes: [SpokeView] = []
    
    private var _focus: Int = -1
    
    private var _current: CGFloat = 0
    
    private var _offset: CGFloat = 0
    
    private var _top: CGFloat = CGFloat.pi / 2
    
    private var _bottom: CGFloat = CGFloat.pi / 2
    
//    private var _radius: CGFloat = 0
    
    private var _tipRadius: CGFloat = 20
    
//    private var _distance: CGFloat = CGFloat.pi / 6
    
    private var _velocity: CGFloat = 0
    
    private var _minvelocity: CGFloat = CGFloat.pi / 6
    
    private var _maxvelocity: CGFloat = CGFloat.pi
    
    private var _topvelocity: CGFloat = CGFloat.pi * 2
    
    private var _decelerate: CGFloat = CGFloat.pi
    
    private var _spinState: RVSpinState = .calm
    
    private var _animating: Bool = false
    
    private var _lastFollowTime: Date?
    
    private var _lastFollowAngle: CGFloat?
    
    private var _settings: RVStateSettings = RVStateSettings(wheelRadius: 100, pinDistance: CGFloat.pi / 6)
    
    // MARK: - Initialization
    
//    init(center: CGPoint, radius: CGFloat, orientation: RVOrientation, distance: CGFloat) {
    init(center: CGPoint, orientation: RVOrientation) {
        super.init(frame: .zero)
        _center = center
//        _settings = settings
//        _radius = radius
//        _distance = distance
        switch orientation {
        case .bottom:
            _offset = CGFloat.pi
        case .left:
            _offset = CGFloat.pi * 1.5
        case .right:
            _offset = CGFloat.pi / 2
        case .top:
            _offset = 0
        }
        
//        _center = center
//        self.frame.origin = CGPoint(x: center.x - _radius * CGFloat(2).squareRoot(), y: center.y - _radius * CGFloat(2).squareRoot())
//        self.frame.size.width = _radius * 2 * CGFloat(2).squareRoot()
//        self.frame.size.height = _radius * 2 * CGFloat(2).squareRoot()
//        drawWheel()
        self.backgroundColor = UIColor.clear
        show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func addSpoke() {
//        let origin = CGPoint(x: frame.width / 2 - _radius, y: frame.width / 2 - _radius)
        let origin = CGPoint(x: _settings.wheelRadius * (CGFloat(2).squareRoot() - 1), y: _settings.wheelRadius * (CGFloat(2).squareRoot() - 1))
        let sateliteRadius = _tipRadius
        let spokeDiameter = _settings.wheelRadius * 2
        let spoke = SpokeView(point: origin, radius: sateliteRadius, side: spokeDiameter)
        
        _spokes.append(spoke)
        
        self.addSubview(spoke)
        
        _current = _offset - (CGFloat(_spokes.count) / 2).rounded(.down) * _settings.pinDistance
        
        show()
    }

    
    // MARK: - Private Methods
    
    private func show() {
        frame.origin = CGPoint(x: _center.x - _settings.wheelRadius * CGFloat(2).squareRoot(), y: _center.y - _settings.wheelRadius * CGFloat(2).squareRoot())
        frame.size.width = _settings.wheelRadius * 2 * CGFloat(2).squareRoot()
        frame.size.height = _settings.wheelRadius * 2 * CGFloat(2).squareRoot()
        frame.origin = CGPoint(x: _center.x - _settings.wheelRadius * CGFloat(2).squareRoot(), y: _center.y - _settings.wheelRadius * CGFloat(2).squareRoot())
        
        
        for n in 0..<_spokes.count {
            let spokeAngle = _settings.pinDistance * CGFloat(n) + _current
            let spoke = _spokes[n]
            spoke.transform = CGAffineTransform(rotationAngle: 0)
            if spokeAngle > _offset + _top {
                spoke.state = .invisible
            }
            else if spokeAngle < _offset - _bottom {
                spoke.state = .invisible
            }
            else if spokeAngle > _offset + _settings.pinDistance / 2 {
                spoke.state = .visible
            }
            else if spokeAngle < _offset - _settings.pinDistance / 2 {
                spoke.state = .visible
            }
            else {
                spoke.state = .focused
            }
            spoke.transform = CGAffineTransform(rotationAngle: spokeAngle)
        }
//        for n in 0..<_spokes.count {
//            let spokeAngle = _distance * CGFloat(n) + _current
//            let spoke = _spokes[n]
//            spoke.transform = CGAffineTransform(rotationAngle: spokeAngle)
//        }
    }

    func move(by delta: CGFloat) {
        //n spoke in focus
        let minCurrent = _offset - CGFloat(_spokes.count) * _settings.pinDistance
        
        //first spoke in focus
        let maxCurrent = _offset
        
        _current = min(max(_current + delta, minCurrent), maxCurrent)
        
        show()
        
    }
    
    func move(to spoke: Int) {
        
        let constrained = min(max(spoke, 0), _spokes.count)
        
        _current = _offset - CGFloat(constrained) * _settings.pinDistance
        
        show()
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
                    if self._current < self._offset - self._settings.pinDistance * CGFloat((self._spokes.count - 1)) {
                        //do nothing
                    }
                    else if self._current > self._offset {
                        //do nothing
                    }
                    else {
                        self._current += self._velocity * 0.03
                    }
                case .decelerate:
                    print("decelerating")
                    let constrainedVelocity = max(min(abs(self._velocity), self._maxvelocity), self._minvelocity)
                    let velocity = CGFloat(sign: self._velocity.sign, exponent: constrainedVelocity.exponent, significand: constrainedVelocity.significand)
                    self._current += velocity * 0.03
                    let newVelocity = max(0, abs(self._velocity) - self._decelerate * 0.03)
                    self._velocity = CGFloat(sign: self._velocity.sign, exponent: newVelocity.exponent, significand: newVelocity.significand)
                case .normalize:
                    print("normalizing")
                    let currentSpokeNumber = (self._offset - self._current) / self._settings.pinDistance
                    let targetSpokeNumber = min(self._spokes.count - 1, max(0, Int(round(currentSpokeNumber))))
                    let targetCurrentAngle = self._offset - (CGFloat(targetSpokeNumber)) * self._settings.pinDistance
                    let delta = self._current - targetCurrentAngle
                    if abs(delta) < 0.03 * self._maxvelocity {
                        self._current = targetCurrentAngle
                    }
                    else {
                        let velocity = CGFloat(sign: ((-delta).sign), exponent: self._maxvelocity.exponent, significand: self._maxvelocity.significand)
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
                    if self._current < self._offset - self._settings.pinDistance * CGFloat((self._spokes.count - 1)) {
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
                    let currentSpokeNumber = (self._offset - self._current) / self._settings.pinDistance
                    let targetSpokeNumber = min(self._spokes.count - 1, max(0, Int(round(currentSpokeNumber))))
                    let targetCurrentAngle = self._offset - (CGFloat(targetSpokeNumber)) * self._settings.pinDistance
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
    
    // MARK: - Placeholders
    
    func enlarge() {
        
//        RVRadius = min(150, RVRadius + 50)
//        for spoke in _spokes {
//            spoke.transform = CGAffineTransform(rotationAngle: 0)
//            spoke.SVSide = RVRadius * 2
//            spoke.SVPoint = CGPoint(x: (CGFloat(2).squareRoot() - 1) * RVRadius, y: (CGFloat(2).squareRoot() - 1) * RVRadius)
//            
//        }
//        show()
    }
    
    func shrink() {
//        RVRadius = max(50, RVRadius - 50)
//        for spoke in _spokes {
//            spoke.transform = CGAffineTransform(rotationAngle: 0)
//            spoke.SVSide = RVRadius * 2
//            spoke.SVPoint = CGPoint(x: (CGFloat(2).squareRoot() - 1) * RVRadius, y: (CGFloat(2).squareRoot() - 1) * RVRadius)
//        }
//        show()
    }
    
}
