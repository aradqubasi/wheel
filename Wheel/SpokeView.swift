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
    
    var state: RVSpokeState{
        get {
            return _state
        }
        set (new) {
            _state = new
            show()
        }
    }
    
    var SVSide: CGFloat {
        get {
            return _side
        }
        set (new) {
            _side = new
            show()
        }
    }

    var SVPoint: CGPoint {
        get {
            return _point
        }
        set (new) {
            _point = new
            show()
            
        }
    }
    
    var SVAngle: CGFloat {
        get {
            return _angle
        }
        set (new) {
            _angle = new
            show()
        }
    }
//    
//    var SVThickness: CGFloat {
//        get {
//            return _thickness
//        }
//        set (new) {
//            _thickness = new
//            show()
//        }
//    }
    
    var delegate: SVDelegate?
    
    // MARK: - Subviews

    private var _pin: UIView!
    
//    private var _hitBox: UIView!
    
    private var _socket: UIView!
    
    // MARK: - Private properties
    
    private var _state: RVSpokeState = .invisible
    
    private var _side: CGFloat!
    
    private var _point: CGPoint!
    
    private var _angle: CGFloat!
    
    // MARK: - Initialization
    
    init(point: CGPoint, side: CGFloat) {
        self._angle = 0
        self._point = point
//        self._radius = radius
        self._side = side
        super.init(frame: CGRect(origin: .zero, size: .zero))
        _socket = SocketView(frame: CGRect(origin: .zero, size: .zero))
        addSubview(_socket)
//        _circle = UIButton(frame: CGRect(origin: .zero, size: .zero))
//        _circle.addTarget(self, action: #selector(OnPinClick), for: .touchUpInside)
//        self.addSubview(_circle)
//        _hitBox = UIView(frame: CGRect(origin: .zero, size: .zero))
        
        frame.origin.x = _point.x
        frame.origin.y = _point.y
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
    
    // MARK: - Private Methods
    
    private func show() {
        
        transform = CGAffineTransform(rotationAngle: 0)
        _pin?.transform = CGAffineTransform(rotationAngle: 0)
        
        if let settings = delegate?.pin(for: self, in: _state) {
            _point = settings.boxOrigin
            _side = settings.boxSide
        }
        
        frame.origin.x = _point.x
        frame.origin.y = _point.y
        
        frame.origin.x = _point.x
        frame.origin.y = _point.y
        frame.size.width = _side
        frame.size.height = _side
        backgroundColor = UIColor.clear
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0
        
//        if let settings = delegate?.getPicture(self, _state) {
//            _circle.setImage(settings.image, for: .normal)
//            _radius = settings.pinRadius
//        }
//        _circle.frame.origin.x = _side / 2 - _radius
//        _circle.frame.origin.y = 0
//        _circle.frame.size.width = _radius * 2
//        _circle.frame.size.height = _radius * 2
//        _circle.layer.cornerRadius = _radius
//        _circle.clipsToBounds = true
        
        if let pin = delegate?.pin(for: self, as: _pin, in: _state) {
            let side = max(pin.frame.width, pin.frame.height)
            _socket.frame.size = CGSize(side: side * CGFloat(2).squareRoot())
            _socket.frame.origin = CGPoint(x: _side / 2 - _socket.frame.width / 2, y: -(side * (CGFloat(2).squareRoot() - 1)))
            _socket.layer.borderColor = UIColor.red.cgColor
            _socket.layer.borderWidth = 0
//            socket.frame.size =
            pin.frame.origin = CGPoint(x: _socket.frame.width / 2 + abs(side - pin.frame.width) / 2 - pin.frame.width / 2, y: abs(side - pin.frame.height))
            if _pin !== pin {
                _pin?.removeFromSuperview()
                _pin = pin
//                addSubview(pin)
                _socket.addSubview(pin)
            }
        }
        
        transform = CGAffineTransform(rotationAngle: _angle)
        _pin?.transform = CGAffineTransform(rotationAngle: -_angle)
    }
    
    @objc private func OnPinClick() {
        delegate?.onPinClick(self, _state)
    }
    
    // MARK: - Public Methods
    
//    func resize(side: CGFloat) {
//        _side = side
//        show()
//    }
}
