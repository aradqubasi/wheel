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
    
    private var _state: RVState = .inactive
    
    // MARK: - SVDelegate Methods
    
//    func getPicture(_ spoke: SpokeView, _ state: RVSpokeState) -> SVSettings {
//        guard let spokeStateSettings = delegate?.radialView(self, _state, spoke, state, -1) else {
//            fatalError("no result for radialView")
//        }
//        return spokeStateSettings
//    }
    func pin(for spoke: SpokeView, as current: UIView?, in state: RVSpokeState) -> UIView {
        
//        let radius: CGFloat
//        switch _state {
//        case .active:
//            radius = 25
//        case .inactive:
//            radius = 20
//        }
//
//        let color: UIColor
//        switch state {
//        case .focused:
//            color = .yellow
//        case .visible:
//            color = .black
//        case .invisible:
//            color = .white
//        }
//
//        let image = UIImage(color: color, size: CGSize(width: radius, height: radius))
//
//        var pin: UIButton
//        if current == nil {
//            pin = UIButton(frame: CGRect(origin: .zero, size: .zero))
//        }
//        else {
//            guard let button = current as? UIButton else {
//                fatalError("pin is not a UIButton")
//            }
//            pin = button
//        }
////        pin.addTarget(self, action: #selector(OnPinClick), for: .touchUpInside)
////        self.addSubview(_circle)
//        pin.setImage(image, for: .normal)
//        //            _circle.image = settings.image
////        pin = radius
//
//        pin.frame.origin = .zero
//        pin.frame.size.width = radius * 2
//        pin.frame.size.height = radius * 2
//        pin.layer.cornerRadius = radius
//        pin.clipsToBounds = true
//
//        return pin
        if delegate != nil {
            let isCurrent = { (current: SpokeView) -> Bool in
                if spoke === current {
                    return true
                }
                else {
                    return false
                }
            }
            guard let spokeIndex = _spokes.index(where: isCurrent) else {
                fatalError("clicked spoke is not found")
            }
            return delegate!.radialView(self, _state, spoke, current, state, spokeIndex)
        }
        else {
            return UIView()
        }
    }
    
//    func onPinClick(_ spoke: SpokeView, _ state: RVSpokeState) {
//        guard let spokeIndex = _spokes.index(where: { (current) -> Bool in
//            if spoke === current {
//                return true
//            }
//            else {
//                return false
//            }
//        }) else {
//            fatalError("clicked spoke is not found")
//        }
//        delegate?.onPinClick(self, _state, spoke, state, spokeIndex)
//    }
    
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
        let sateliteRadius = _tipRadius
        let spokeDiameter = _radius * 2
        let spoke = SpokeView(point: origin, radius: sateliteRadius, side: spokeDiameter)
        spoke.delegate = self
        _spokes.append(spoke)
        
        self.addSubview(spoke)
        
        _current = _offset - (CGFloat(_spokes.count) / 2).rounded(.down) * _distance
        
        show()
    }

    
    // MARK: - Private Methods
    
    private func show() {
        var maxrotation: CGFloat = 0
        
        if let stateSettings = delegate?.radialView(self, _state) {
            _distance = stateSettings.pinDistance
            _radius = stateSettings.wheelRadius
        }
        
        let numberOfSpokes = delegate?.numberOfSpokes(in: self)
        if numberOfSpokes != nil && _spokes.count == 0 {
            for _ in 0..<numberOfSpokes! {
                let origin = CGPoint(x: _radius * (CGFloat(2).squareRoot() - 1), y: _radius * (CGFloat(2).squareRoot() - 1))
                let sateliteRadius = _tipRadius
                let spokeDiameter = _radius * 2
                let spoke = SpokeView(point: origin, radius: sateliteRadius, side: spokeDiameter)
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
            maxrotation = max(maxrotation, spokeAngle)
        }
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
