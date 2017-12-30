//
//  SWRadialView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWWheelView {
    
    // MARK: - Initialization
    
    init() {
        
        _spokes = []
        
        _current = 0
        
        _socket = UIView()
        
        _view = UIView()
        _socket.addSubview(_view)
    }
    
    // MARK: - Public Properties
    
    var delegate: SWWheelDelegate?
    
    var view: UIView!
    
    var count: Int {
        get {
            return _spokes.count
        }
    }
    
    /**pin and another which is the closest to focus*/
    var focused: SWSpoke {
        get {
            guard let focused = _spokes.first(where: { return $0.focused }) else {
                fatalError("no focused spokes")
            }
            return focused
        }
    }
    
    // MARK: - Public Methods
    
    func reload() {
        if let delegate = delegate {
            
//            _socket.center = CGPoint(x: view.bounds.width * 0.5, y: view.bounds.height * 0.5)
            _socket.frame.origin = CGPoint(x: -view.bounds.width * (CGFloat(2).squareRoot() - 1), y: -view.bounds.height * (CGFloat(2).squareRoot() - 1))
            _socket.frame.size = CGSize(width: view.bounds.width * CGFloat(2).squareRoot(), height: view.bounds.height * CGFloat(2).squareRoot())
            view.addSubview(_socket)
            
//            _view.center = CGPoint(x: _socket.bounds.width * 0.5, y: _socket.bounds.height * 0.5)
            _view.frame.origin = CGPoint(x: view.bounds.width * (CGFloat(2).squareRoot() - 1), y: view.bounds.height * (CGFloat(2).squareRoot() - 1))
            _view.frame.size = view.bounds.size
            
            let count = delegate.numberOfSpokes(in: self)
            for index in 0..<count {
                let pin = delegate.radialView(pinFor: self, at: index)
                
                let socket = UIView()
                socket.frame.size = pin.frame.size
                socket.center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
                socket.addSubview(pin)
                pin.frame.origin = .zero
                
                let spoke = SWSpoke(socket, pin, index, false)
                _spokes.append(spoke)
//                _view.addSubview(pin)
                _view.addSubview(socket)
            }
            
            _settings = delegate.radialView(self)
            
//            var a: CGFloat = 0
//            for spoke in _spokes {
//                let pin = spoke.pin
//                let radius = _settings.radius - max(pin.frame.width, pin.frame.height) * 0.5
//                pin.center =  CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
//                pin.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(a), y: radius * sin(a))
//                let unlooped = a.truncatingRemainder(dividingBy: CGFloat.pi * 2)
//                spoke.focused = unlooped - _settings.offset <= _settings.distance * 0.5 && unlooped - _settings.offset > -_settings.distance * 0.5
//
//                a += _settings.distance
//            }
            
            rotate(by: _settings.offset)
        }
    }
    
    func rotate(to angle: CGFloat) -> Void {

//        _view.transform = CGAffineTransform.identity
        var found = false
        var a: CGFloat = 0
        for spoke in _spokes {
            let pin = spoke.pin
            let socket = spoke.socket
            let radius = _settings.radius - max(socket.frame.width, socket.frame.height) * 0.5
//            socket.center =  CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
            socket.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(a), y: radius * sin(a))
            
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
            
            pin.backgroundColor = spoke.focused ? .blue : .red
            a += _settings.distance
        }
        
//        _view.transform = CGAffineTransform.identity.rotated(by: abs(angle) == CGFloat.pi ? angle * 1.01 : angle )
        _view.transform = CGAffineTransform.identity.rotated(by: angle)
//        print(angle)
        for spoke in _spokes {
            spoke.pin.transform = CGAffineTransform.identity.rotated(by: -angle)
        }
        
        _current = angle
    }
    
//    func rotate(to angle: CGFloat) -> Void {
//        _current = angle
//        var a: CGFloat = _current
//        for spoke in _spokes {
//            let pin = spoke.pin
//            let radius = _settings.radius - max(pin.frame.width, pin.frame.height) * 0.5
//            pin.center =  CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
//            pin.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi * 0.5).translatedBy(x: radius * cos(a), y: radius * sin(a))
//            let unlooped = a.truncatingRemainder(dividingBy: CGFloat.pi * 2)
//            spoke.focused = unlooped - _settings.offset <= _settings.distance * 0.5 && unlooped - _settings.offset > -_settings.distance * 0.5
//
//            a += _settings.distance
//        }
//    }
    
    func rotate(by angle: CGFloat) -> Void {
//        let adjusted = (_current + angle).truncatingRemainder(dividingBy: (2 * CGFloat.pi))
        let adjusted = _current + angle
        rotate(to: adjusted)
    }

    
    func move(to index: Int) -> Void {
        let angle = _settings.offset + _settings.distance * CGFloat(index)
        rotate(to: angle)
    }
    
    // MARK: - Private Properties
    
    private var _spokes: [SWSpoke]!
    
    private var _settings: SWWheelSettings!
    
    /**subview of view, to hold rotating wheel*/
    private var _socket: UIView!
    
    /**subview of _socket, hold spokes, rotates*/
    private var _view: UIView!
    
    /**current angle [0; 2pi)*/
    private var _current: CGFloat!
}
