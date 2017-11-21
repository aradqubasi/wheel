//
//  SpokeView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/09/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SpokeView: UIView, HitDelegate {
    
    // MARK: - Public Properties
    
    var name: String = ""
    
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
    
    /**expected pin distance*/
    var SVDistance: CGFloat {
        get {
            return _distance
        }
        set (new) {
            _distance = new
            show()
        }
    }
    
    var delegate: SVDelegate?
    
    // MARK: - Subviews

    private var _pin: UIView!
    
//    private var _screen: ScreenView!
    
    private var _socket: UIView!
    
    // MARK: - Private properties
    
    private var _state: SVState = .invisible
    
    private var _side: CGFloat!
    
    private var _point: CGPoint!
    
    private var _angle: CGFloat!
    
    private var _index: Int!
    
    /**expected pin distance*/
    private var _distance: CGFloat = 0
    
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
//        _screen = ScreenView()
//        _screen.delegate = self
//        addSubview(_screen)
        frame.origin.x = _point.x
        frame.origin.y = _point.y
        layer.cornerRadius = frame.width / 2
        show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - HitDelegate
    
    func on(hit sender: Any, with event: UIEvent?) -> Void {
//        if let screen = sender as? ScreenView, screen === _screen {
//            print("spokeview: hit spoke @ \(_index)")
//            delegate?.on(hit: self, with: event)
//        }
    }
    
    // MARK: - Overrided Methods
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
//        if name == "proteins" && _index == 0 {
//            print("!")
//            print(self.bounds)
//        }
        let radius = bounds.width / 2
        let thickness = max(_pin?.bounds.width ?? 0, _pin?.bounds.height ?? 0)
        let x2 = (point.x - radius) * (point.x - radius)
        let y2 = (point.y - radius) * (point.y - radius)
        let ir2 = (radius - thickness) * (radius - thickness)
        let or2 = (radius) * (radius)
        
        let first = CGPoint(x: radius, y: radius)
        let north = _distance * radius
        
        let left = CGPoint(x: radius - north / 2, y: 0)
        let mleft = (left.y - first.y) / (left.x - first.x)
        let expectedLeftY = mleft * (point.x - first.x) + first.y
        
        let right = CGPoint(x: radius + north / 2, y: 0)
        let mright = (right.y - first.y) / (right.x - first.x)
        let expectedRightY = mright * (point.x - first.x) + first.y
        
        if x2 + y2 >= ir2 && x2 + y2 <= or2 {
            
            if point.y <= expectedLeftY && point.y <= expectedRightY {
                return _pin
//                delegate?.on(hit: self, with: event)
//                print("wheel \(name) index \(_index) point \(point) event \(event)")
//                let dot = UIView(frame: CGRect(center: point, side: 5))
//                dot.backgroundColor = UIColor.red
//                dot.layer.cornerRadius = 2.5
//                dot.backgroundColor = UIColor.green
//                self.addSubview(dot)
            }
            
        }
        
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
        _socket.frame.origin = CGPoint(x: _side / 2 - _socket.frame.width / 2, y: -(side * (CGFloat(2).squareRoot() - 1)) / 2)
        _socket.layer.borderColor = UIColor.red.cgColor
        _socket.layer.borderWidth = 0
//        _pin.frame.origin = CGPoint(x: _socket.frame.width / 2 + abs(side - _pin.frame.width) / 2 - _pin.frame.width / 2, y: abs(side - _pin.frame.height))
        _pin.frame.origin = CGPoint(x: _socket.frame.width / 2 + abs(side - _pin.frame.width) / 2 - _pin.frame.width / 2, y: _socket.frame.height / 2 + abs(side - _pin.frame.height) - _pin.frame.height / 2)
        
//        _screen.frame = self.bounds
//        _screen._outer = _side / 2
//        _screen._inner = _side / 2 - side
//        _screen._angle = _distance
        
        transform = CGAffineTransform(rotationAngle: _angle)
        _pin.transform = CGAffineTransform(rotationAngle: -_angle)
    }
    
    // MARK: - Public Methods
    
}
