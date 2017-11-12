//
//  RadialView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class RadialView: UIView, SVDelegate {

    // MARK: - Public Properties
    
    var delegate: RVDelegate?
    
    var current: CGFloat {
        get {
            var angle = _current
            while angle > CGFloat.pi * 2  {
                angle -= CGFloat.pi * 2
            }
            return angle
        }
    }
    
    var RVCenter: CGPoint {
        get {
            return _center
        }
        set (new) {
            _center = new
            show()
        }
    }
    
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
    
    var RVState: RVState {
        get {
            return _state
        }
        set(new) {
            _state = new
            show()
        }
    }
    
    var RVRadius: CGFloat {
        get {
            return _radius
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
    
//    private var _tipRadius: CGFloat = 20
    
    private var _distance: CGFloat = CGFloat.pi / 6
    
    private var _velocity: CGFloat = 0
    
    private var _minvelocity: CGFloat = CGFloat.pi / 6
    
    private var _maxvelocity: CGFloat = CGFloat.pi
    
    private var _topvelocity: CGFloat = CGFloat.pi * 2
    
    private var _decelerate: CGFloat = CGFloat.pi
    
    private var _animating: Bool = false
    
    private var _lastFollowTime: Date?
    
    private var _lastFollowAngle: CGFloat?
    
    private var _state: RVState = .inactive
    
//    private var _thickness: CGFloat = 40
    
    // MARK: - SVDelegate Methods
    
    func spokeView(pinFor spoke: SpokeView) -> UIView {
        return delegate?.radialView(pinFor: self, at: spoke.SVIndex) ?? UIView()
    }
    
    func spokeView(_ spoke: SpokeView) -> SVSettings {
        let origin = CGPoint(x: _radius * (CGFloat(2).squareRoot() - 1), y: _radius * (CGFloat(2).squareRoot() - 1))
        let spokeDiameter = _radius * 2
//        let spokeAreaThinkness = _thickness
        return SVSettings(origin, spokeDiameter)
    }
    
    func spokeView(for spoke: SpokeView, update pin: UIView) -> Void {
        delegate?.radialView(for: self, update: pin, in: spoke.SVState, at: spoke.SVIndex)
    }
    
    // MARK: - Initialization
    
    init(center: CGPoint, orientation: RVOrientation) {
        super.init(frame: .zero)
        _center = center
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
        
        self.backgroundColor = UIColor.clear
        show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrided Methods
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, with: event)
        
        if hitView == self {
            return nil
        } else {
            return hitView
        }
    }
    
    // MARK: - Public Methods
    
    func addSpoke() {
        let origin = CGPoint(x: _radius * (CGFloat(2).squareRoot() - 1), y: _radius * (CGFloat(2).squareRoot() - 1))
        let spokeDiameter = _radius * 2
        let pin = delegate?.radialView(pinFor: self, at: _spokes.count) ?? UIView()
        let spoke = SpokeView(point: origin, side: spokeDiameter, index: _spokes.count, pin: pin)
        spoke.delegate = self
        _spokes.append(spoke)
        
        self.addSubview(spoke)
        
        _current = _offset - (CGFloat(_spokes.count) / 2).rounded(.down) * _distance
        
        show()
    }

    
    // MARK: - Private Methods
    
    private func show() {
        if let stateSettings = delegate?.radialView(self) {
            _distance = stateSettings.pinDistance
            _radius = stateSettings.wheelRadius
//            _thickness = stateSettings.wheelThickness
        }
        
        let numberOfSpokes = delegate?.numberOfSpokes(in: self)
        if numberOfSpokes != nil && _spokes.count == 0 {
            for i in 0..<numberOfSpokes! {
                let origin = CGPoint(x: _radius * (CGFloat(2).squareRoot() - 1), y: _radius * (CGFloat(2).squareRoot() - 1))
                let spokeDiameter = _radius * 2
                let spoke = SpokeView(point: origin, side: spokeDiameter, index: i, pin: delegate?.radialView(pinFor: self, at: i) ?? UIView())
                spoke.delegate = self
                _spokes.append(spoke)
                
                self.addSubview(spoke)
            }
            _current = _offset - (CGFloat(_spokes.count) / 2).rounded(.down) * _distance
        }
        
        frame.origin = CGPoint(x: _center.x - _radius * CGFloat(2).squareRoot(), y: _center.y - _radius * CGFloat(2).squareRoot())
        frame.size.width = _radius * 2 * CGFloat(2).squareRoot()
        frame.size.height = _radius * 2 * CGFloat(2).squareRoot()
        frame.origin = CGPoint(x: _center.x - _radius * CGFloat(2).squareRoot(), y: _center.y - _radius * CGFloat(2).squareRoot())
        
        for n in 0..<_spokes.count {
            let spokeAngle = _distance * CGFloat(n) + _current
            let spoke = _spokes[n]
            if spokeAngle > _offset + _top {
                spoke.SVState = .invisible
            }
            else if spokeAngle < _offset - _bottom {
                spoke.SVState = .invisible
            }
            else if spokeAngle > _offset + _distance / 2 {
                spoke.SVState = .visible
            }
            else if spokeAngle < _offset - _distance / 2 {
                spoke.SVState = .visible
            }
            else {
                spoke.SVState = .focused
                _focused = n
            }
            spoke.SVAngle = spokeAngle
        }
    }

    
    func resize(_ radius: CGFloat?, _ distance: CGFloat?, _ tip: CGFloat?) {
        
        _radius = radius ?? _radius
        _distance = distance ?? _distance
        show()
    }
    
    func move(by delta: CGFloat) {
        //n spoke in focus
        let minCurrent = _offset - CGFloat(_spokes.count - 1) * _distance
        
        //first spoke in focus
        let maxCurrent = _offset
        print("now \(_current) next \(min(max(_current + delta, minCurrent), maxCurrent))")
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
