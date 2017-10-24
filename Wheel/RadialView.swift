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
    
//    var RVSettings: RVStateSettings {
//        get {
//            return _settings
//        }
//        set (new) {
//            _settings = new
//            show()
//        }
//    }
    
    var RVFocused: Int {
        get {
            if _focused == nil {
                return 0
            }
            else {
                return _focused!
            }
        }
    }
    
    // MARK: - Private Properties
    
    private var _center: CGPoint = .zero
    
    private var _focused: Int?
    
    private var _spokes: [SpokeView] = []
    
    private var _current: CGFloat = 0
    
    private var _offset: CGFloat = 0
    
    private var _top: CGFloat = CGFloat.pi / 2
    
    private var _bottom: CGFloat = CGFloat.pi / 2
    
    private var _radius: CGFloat = 100
    
    private var _tipRadius: CGFloat = 20
    
    private var _distance: CGFloat = CGFloat.pi / 6
    
    private var _velocity: CGFloat = 0
    
    private var _minvelocity: CGFloat = CGFloat.pi / 6
    
    private var _maxvelocity: CGFloat = CGFloat.pi
    
    private var _topvelocity: CGFloat = CGFloat.pi * 2
    
    private var _decelerate: CGFloat = CGFloat.pi
    
    private var _spinState: RVSpinState = .calm
    
    private var _animating: Bool = false
    
    private var _lastFollowTime: Date?
    
    private var _lastFollowAngle: CGFloat?
    
    //private var _settings: RVStateSettings = RVStateSettings(wheelRadius: 100, pinDistance: CGFloat.pi / 6)
    
    // MARK: - Initialization
    
//    init(center: CGPoint, radius: CGFloat, orientation: RVOrientation, distance: CGFloat) {
//    init(center: CGPoint, orientation: RVOrientation, radius: CGFloat, distance: CGFloat, tip: CGFloat) {
    init(center: CGPoint, orientation: RVOrientation) {
        super.init(frame: .zero)
        _center = center
//        _radius = radius
//        _distance = distance
//        _tipRadius = tip
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
        let origin = CGPoint(x: _radius * (CGFloat(2).squareRoot() - 1), y: _radius * (CGFloat(2).squareRoot() - 1))
        let sateliteRadius = _tipRadius
        let spokeDiameter = _radius * 2
        let spoke = SpokeView(point: origin, radius: sateliteRadius, side: spokeDiameter)
        
        _spokes.append(spoke)
        
        self.addSubview(spoke)
        
        _current = _offset - (CGFloat(_spokes.count) / 2).rounded(.down) * _distance
        
        show()
    }

    
    // MARK: - Private Methods
    
    private func show() {
        var maxrotation: CGFloat = 0
        
        frame.origin = CGPoint(x: _center.x - _radius * CGFloat(2).squareRoot(), y: _center.y - _radius * CGFloat(2).squareRoot())
        frame.size.width = _radius * 2 * CGFloat(2).squareRoot()
        frame.size.height = _radius * 2 * CGFloat(2).squareRoot()
        frame.origin = CGPoint(x: _center.x - _radius * CGFloat(2).squareRoot(), y: _center.y - _radius * CGFloat(2).squareRoot())
        
        for n in 0..<_spokes.count {
            let spokeAngle = _distance * CGFloat(n) + _current
            let spoke = _spokes[n]
            spoke.transform = CGAffineTransform(rotationAngle: 0)
            let sateliteRadius = _tipRadius
            let spokeDiameter = _radius * 2
            spoke.resize(side: spokeDiameter, radius: sateliteRadius)
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
                _focused = n
            }
            spoke.transform = CGAffineTransform(rotationAngle: spokeAngle)
//            spoke.transform = spoke.transform.rotated(by: spokeAngle)
            maxrotation = max(maxrotation, spokeAngle)
        }
//        print(maxrotation)
//        for n in 0..<_spokes.count {
//            let spokeAngle = _distance * CGFloat(n) + _current
//            let spoke = _spokes[n]
//            spoke.transform = CGAffineTransform(rotationAngle: spokeAngle)
//        }
    }

    
    func resize(_ radius: CGFloat?, _ distance: CGFloat?, _ tip: CGFloat?) {
        
        _radius = radius ?? _radius
        _distance = distance ?? _distance
        _tipRadius = tip ?? _tipRadius
        
        show()
    }
    
    func move(by delta: CGFloat) {
        //n spoke in focus
        let minCurrent = _offset - CGFloat(_spokes.count - 1) * _distance
        
        //first spoke in focus
        let maxCurrent = _offset
        
        _current = min(max(_current + delta, minCurrent), maxCurrent)
        
        show()
        
    }
    
    func move(to spoke: Int) {
        
        let constrained = min(max(spoke, 0), _spokes.count)
        
        _current = _offset - CGFloat(constrained) * _distance
        
        show()
    }
    

    // MARK: - Placeholders

    
}
