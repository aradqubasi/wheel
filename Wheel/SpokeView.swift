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
    
    var SVState: SVState {
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
    
    var SVIndex: Int {
        get {
            return _index
        }
    }
    
    var delegate: SVDelegate?
    
    // MARK: - Subviews

    private var _pin: UIView!
    
//    private var _hitBox: UIView!
    
    private var _socket: UIView!
    
    // MARK: - Private properties
    
    private var _state: SVState = .invisible
    
    private var _side: CGFloat!
    
    private var _point: CGPoint!
    
    private var _angle: CGFloat!
    
    private var _index: Int!
    
    // MARK: - Initialization
    
    init(point: CGPoint, side: CGFloat, index: Int, pin: UIView) {
        self._index = index
        self._angle = 0
        self._point = point
        self._side = side
        super.init(frame: CGRect(origin: .zero, size: .zero))
        _socket = SocketView(frame: CGRect(origin: .zero, size: .zero))
        addSubview(_socket)
        _pin = pin
        _socket.addSubview(_pin)
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
        
        if let settings = delegate?.spokeView(self) {
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
        
        delegate?.spokeView(for: self, update: _pin)
        
        let side = max(_pin.frame.width, _pin.frame.height)
        _socket.frame.size = CGSize(side: side * CGFloat(2).squareRoot())
        _socket.frame.origin = CGPoint(x: _side / 2 - _socket.frame.width / 2, y: -(side * (CGFloat(2).squareRoot() - 1)))
        _socket.layer.borderColor = UIColor.red.cgColor
        _socket.layer.borderWidth = 0
        _pin.frame.origin = CGPoint(x: _socket.frame.width / 2 + abs(side - _pin.frame.width) / 2 - _pin.frame.width / 2, y: abs(side - _pin.frame.height))
        
        transform = CGAffineTransform(rotationAngle: _angle)
        _pin.transform = CGAffineTransform(rotationAngle: -_angle)
    }
    
    // MARK: - Public Methods
    
}
