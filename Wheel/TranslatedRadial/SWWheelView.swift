//
//  SWRadialView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWWheelView : UIView {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        _spokes = []
        
        _current = 0
        
        _view = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Properties
    
    var name: String = "Undefined"
    
    var delegate: SWWheelDelegate?
    
    var count: Int {
        get {
            return _spokes.count
        }
    }
    
    /**index of pin which is the closest to focus*/
    var index: Int {
        get {
            return _spokes.first(where: { return $0.focused })?.index ?? 0
        }
    }
    
    // MARK: - Public Methods
    
    func reload() {
        if let delegate = delegate {

            _view.frame = self.bounds
            self.addSubview(_view)
            
            _spokes.removeAll()
            _view.subviews.forEach({ $0.removeFromSuperview() })
            let count = delegate.numberOfSpokes(in: self)
            for index in 0..<count {
                let pin = delegate.radialView(pinFor: self, at: index)
                
                let socket = UIView()
                socket.frame.size = pin.frame.size
                socket.center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
                socket.addSubview(pin)
                pin.frame.origin = .zero
                
                let spoke = SWSpoke(socket, pin, index, false, 0)
                _spokes.append(spoke)
                _view.addSubview(socket)
            }
            
            _settings = delegate.radialView(self)
            
            move(by: _settings.offset)
        }
    }
    
    func resize() {
        if let delegate = delegate {
            
            _view.frame = self.bounds

            for spoke in _spokes {
                
                let pin = spoke.pin
                if pin.frame != .zero {
//                    print("identity rs 1 pin.framee \(pin.frame) .zero \(CGPoint.zero)")
                    pin.transform = CGAffineTransform.identity
                    pin.frame.origin = .zero
                }
                
                let newSocketCenter = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
                let newPinSize = pin.frame.size
                let socket = spoke.socket
                if socket.frame.size != newPinSize || socket.center != newSocketCenter {
//                    print("identity rs 2 socket.frame.size \(socket.frame.size) newPinSize \(newPinSize) socket.center \(socket.center) newSocketCenter \(newSocketCenter)")
                    socket.transform = CGAffineTransform.identity
                    socket.frame.size = pin.frame.size
                    socket.center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
                }
                
            }
            
            _settings = delegate.radialView(self)
            
            move(by: 0)
        }
    }
    
    func rotate(to angle: CGFloat) -> Void {

        var found = false
        var a: CGFloat = 0
        for spoke in _spokes {
            let socket = spoke.socket
            do {
                var unlooped = (a + angle).truncatingRemainder(dividingBy: CGFloat.pi * 2)
                unlooped = unlooped < 0 ? 2 * CGFloat.pi - abs(unlooped) : unlooped
                let delta = _settings.distance * 0.5
                
                if _settings.offset - delta < 0 {
                    spoke.focused = unlooped >= 2 * CGFloat.pi - abs(_settings.offset - delta) || unlooped < _settings.offset + delta
                }
                else if _settings.offset + delta > 2 * CGFloat.pi {
                    spoke.focused = unlooped >= _settings.offset - delta || unlooped < _settings.offset + delta - 2 * CGFloat.pi
                }
                else {
                    spoke.focused = unlooped >= _settings.offset - delta && unlooped < _settings.offset + delta
                }
                spoke.focused = found ? false : spoke.focused
                found = spoke.focused ? true : false
                
                print("spoke \(spoke.index) is \(spoke.focused) at \(unlooped) to \(angle)")
            }
            delegate?.radialView(for: self, update: spoke)
            a += _settings.distance
        }
        
        _view.transform = CGAffineTransform.identity.rotated(by: angle)

        let factor = _settings.scale
        for spoke in _spokes {
            spoke.pin.transform = CGAffineTransform.identity.scaledBy(x: factor, y: factor).rotated(by: -angle)
            spoke.angle = angle
        }
        
        _current = angle
    }
    
    func move(by angle: CGFloat) -> Void {
//        let adjusted = (_current + angle).truncatingRemainder(dividingBy: (2 * CGFloat.pi))
        let adjusted = _current + angle
        rotate(to: adjusted)
    }

    
    func move(to index: Int) -> Void {
        let angle = _settings.offset - _settings.distance * CGFloat(index)
        rotate(to: angle)
    }
    
    // MARK: - Private Properties
    
    private var _spokes: [SWSpoke]!
    
    private var _settings: SWWheelSettings!
    
    /**subview of view, to hold rotating wheel*/
//    private var _socket: UIView!
    
    /**subview of _socket, hold spokes, rotates*/
    private var _view: UIView!
    
    /**current angle [0; 2pi)*/
    private var _current: CGFloat!
    
    /**outer view, which contain _view*/
//    private var _outer: UIView!
    
    // MARK: - Overrided Methods
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//
//        let radius = bounds.width / 2
//        let thickness = max(_pin?.bounds.width ?? 0, _pin?.bounds.height ?? 0)
//        let x2 = (point.x - radius) * (point.x - radius)
//        let y2 = (point.y - radius) * (point.y - radius)
//        let ir2 = (radius - thickness) * (radius - thickness)
//        let or2 = (radius) * (radius)
//
//        let first = CGPoint(x: radius, y: radius)
//        let north = _distance * radius
//
//        let left = CGPoint(x: radius - north / 2, y: 0)
//        let mleft = (left.y - first.y) / (left.x - first.x)
//        let expectedLeftY = mleft * (point.x - first.x) + first.y
//
//        let right = CGPoint(x: radius + north / 2, y: 0)
//        let mright = (right.y - first.y) / (right.x - first.x)
//        let expectedRightY = mright * (point.x - first.x) + first.y
//
//        if x2 + y2 >= ir2 && x2 + y2 <= or2 {
//
//            if point.y <= expectedLeftY && point.y <= expectedRightY {
//                var new = self.convert(point, to: _pin)
//                if !_pin.bounds.contains(new) {
//                    new = .zero
//                }
//                //                let hitView = _pin.hitTest(.zero, with: event)
//                let hitView = _pin.hitTest(new, with: event)
//                print(new)
//                return hitView
//            }
//
//        }
//
//        let hitView = super.hitTest(point, with: event)
//
//        if hitView == self {
//            return nil
//        } else {
//            return hitView
//        }
//    }
}
