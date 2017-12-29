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
            
            let count = delegate.numberOfSpokes(in: self)
            for index in 0..<count {
                let pin = delegate.radialView(pinFor: self, at: index)
                let spoke = SWSpoke(pin, index, false)
                _spokes.append(spoke)
                view.addSubview(pin)
            }
            
            _settings = delegate.radialView(self)
            rotate(by: _settings.offset)
//            var a: CGFloat = _settings.offset
//            for index in 0..<count {
//                let pin = _pins[index]
//                let radius = _settings.radius - max(pin.frame.width, pin.frame.height) * 0.5
//                pin.center = view.center
//                pin.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(a), y: radius * sin(a))
//                a += _settings.distance
//            }
        }
    }
    
    func rotate(to angle: CGFloat) -> Void {
        _current = angle
        var a: CGFloat = _current
        for spoke in _spokes {
            let pin = spoke.pin
            let radius = _settings.radius - max(pin.frame.width, pin.frame.height) * 0.5
            pin.center =  view.superview!.convert(view.center, to: view) 
            pin.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(a), y: radius * sin(a))
            let unlooped = a.truncatingRemainder(dividingBy: CGFloat.pi * 2)
            spoke.focused = unlooped - _settings.offset <= _settings.distance * 0.5 && unlooped - _settings.offset > -_settings.distance * 0.5
            
            a += _settings.distance
        }
    }
    
    func rotate(by angle: CGFloat) -> Void {
        let adjusted = (_current + angle).truncatingRemainder(dividingBy: (2 * CGFloat.pi))
        rotate(to: adjusted)
    }

    
    func move(to index: Int) -> Void {
        let angle = _settings.offset - _settings.distance * CGFloat(index)
        rotate(to: angle)
    }
    
    // MARK: - Private Properties
    
    private var _spokes: [SWSpoke]!
    
    private var _settings: SWWheelSettings!
    
    /**current angle [0; 2pi)*/
    private var _current: CGFloat!
}
