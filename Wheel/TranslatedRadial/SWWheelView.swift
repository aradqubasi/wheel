//
//  SWWheelView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWWheelView: SWAbstractWheelView, SWAbstractWheelController {
    
    // MARK: - Initializers
    
    init(in container: UIView) {
        
        _container = container
        
        name = "Bases"
        
        do {
            let romainelettuce = PinView.create.name("romainelettuce").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            _spokes.append(SWSpoke.init(UIView(), romainelettuce, 0, true, 0))
            
            let salad = PinView.create.name("salad").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            _spokes.append(SWSpoke.init(UIView(), salad, 1, false, 0))
            
            let cabbage = PinView.create.name("cabbage").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            _spokes.append(SWSpoke.init(UIView(), cabbage, 2, false, 0))
            
            let lettuce = PinView.create.name("lettuce").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            _spokes.append(SWSpoke.init(UIView(), lettuce, 3, false, 0))
            
            let spinach = PinView.create.name("spinach").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            _spokes.append(SWSpoke.init(UIView(), spinach, 4, false, 0))
            
            let brusselssprouts = PinView.create.name("brusselssprouts").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            _spokes.append(SWSpoke.init(UIView(), brusselssprouts, 5, false, 0))
            
//            zoodles (aka spiralized zucchini)
            let zoodles = PinView.create.name("zoodles").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            _spokes.append(SWSpoke.init(UIView(), zoodles, 6, false, 0))
            
            let shavedfennel = PinView.create.name("shavedfennel").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            _spokes.append(SWSpoke.init(UIView(), shavedfennel, 7, false, 0))
            
            _state = .bases
            
            _settings = [
                .bases: WSettings(155, CGFloat.pi * 2 / 8, .zero, CGFloat.pi, 1.25),
                .fats: WSettings(141, CGFloat.pi * 2 / 8, .zero, CGFloat.pi, 1),
                .veggies: WSettings(141, CGFloat.pi * 2 / 8, .zero, CGFloat.pi, 1),
                .proteins: WSettings(141, CGFloat.pi * 2 / 8, .zero, CGFloat.pi, 1)
            ]
            
            _face = CGFloat.pi //* 0.75
        }
        
        _background = UIView()
        _view = UIView(frame: _container.bounds)
        _view.addSubview(_background)
        _container.addSubview(_view)
        for i in 0..<_spokes.count {
            
            let socket = _spokes[i].socket
            let pin = _spokes[i].pin
            
            pin.frame.origin = CGPoint(x: 52 * 0.125, y: 52 * 0.125)
//            pin.frame.size = CGSize(width: 52, height: 52)
            pin.setPin(size: CGSize(width: 52, height: 52))
            guard let image = pin.images[_state]?[.visible] else {
                fatalError("no image")
            }
            pin.setImage(image, for: .normal)
            
            socket.frame.size = CGSize(width: 52 * 1.25, height: 52 * 1.25)
            socket.center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
            socket.addSubview(pin)
            
            _view.addSubview(socket)
            
            guard var radius = _settings[_state]?.radius else {
                fatalError("no settings for state \(_state)")
            }
            radius -= socket.frame.width * 0.5
            
            let delta = CGFloat.pi * CGFloat(2) / CGFloat(_spokes.count)
            var a = delta * CGFloat(i)
            a = a > CGFloat.pi ? a - 2 * CGFloat.pi : a
            socket.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(a), y: radius * sin(a))
//            print("and the angle is \(a) out of \(delta * CGFloat(i))")
            _spokes[i].angle = a
        }
        
        do {
            //add primary set
            _extended = _spokes.reduce(into: _extended, { dict, next in
                dict[next.angle] = next.index
            })
            //add set for face near pi
            _extended = _spokes.filter({
                return $0.angle <= 0
            }).reduce(into: _extended, { dict, next in
                let adjusted = next.angle + CGFloat.pi * 2
                dict[adjusted] = next.index
            })
            //add set for face near -pi
            _extended = _spokes.filter({
                return $0.angle >= 0
            }).reduce(into: _extended, { dict, next in
                let adjusted = next.angle - 2 * CGFloat.pi
                dict[adjusted] = next.index
            })
            //debug
//            _spokes.sorted(by: {
//                return $0.angle < $1.angle
//            }).forEach({
//                print("original \($0.angle) \($0.index)")
//            })
//            _extended.sorted(by: {
//                return $0.key < $1.key
//            }).forEach({
//                print("extended \($0.key) \($0.value)")
//            })
        }
        
        flush(with: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties
    
    /**angle/spoke index pairs, used for checking whether speicifc spoke is in focus*/
    private var _extended: [CGFloat : Int] = [:]
    
    private var _state: WState!
    
    private var _spokes: [SWSpoke] = []
    
    private var _settings: [WState : WSettings] = [:]
    
    /**angle at which spokes considered focused*/
    private var _face: CGFloat!
    
    /**super view for all wheel heirarchy*/
    private var _container: UIView!
    
    /**subview of _socket, hold spokes, rotates*/
    private var _view: UIView!
    
    /**current angle*/
    private var _current: CGFloat {
        get {
            return atan2(_view.transform.b, _view.transform.a)
        }
    }
    
    /**background view, resize each time state is updated*/
    var _background: UIView!
    
    // MARK: - Private Methods
    


    // MARK: - SWAbstractWheelController
    
    var focused: PinView {
        get {
            guard let focused = _spokes.first(where: { return $0.focused }) else {
                fatalError("no active spoke")
            }
            return focused.pin
        }
    }
    
    func moveToRandomPin() {
        
    }
    
    var state: WState {
        get {
            return _state
        }
        set(new) {
            _state = new
            flush(with: nil)
        }
    }
    
    // MARK: - SWAbstractWheelView
    
    var center: CGPoint {
        get {
            return _container.center
        }
    }
    
    var index: Int {
        get {
            guard let index = _spokes.first(where: { return $0.focused })?.index else {
                fatalError("no active spoke")
            }
            return index
        }
    }
    
    var count: Int {
        get {
            return _spokes.count
        }
    }
    
    /**we do not need it here... do not touch it*/
    var delegate: SWAbstractWheelDelegate?
    
    /**wheel name, aestetics purposes only*/
    var name: String
    
    /**rotate wheel to specific anglew which would bring pin to face*/
    func move(to index: Int) {
        let angle = _face - _spokes[index].angle
        self.move(by: angle)
    }
    
    /**set wheel to correct angle, pins to correct sizes, only transforms allowed*/
    func move(by angle: CGFloat) {
        let new = _current + angle
        _view.transform = CGAffineTransform.identity.rotated(by: new)
        guard let factor = _settings[state]?.scale else {
            fatalError("no settings for state \(state)")
        }
        for spoke in _spokes {
            spoke.pin.transform = CGAffineTransform.identity.scaledBy(x: factor, y: factor).rotated(by: -new)
//            spoke.angle = angle
        }
        
        //check focus
        do {
            guard var delta = _settings[_state]?.distance else {
                fatalError("no settings for state \(_state)")
            }
            delta *= 0.5
            let current = _current
            guard let focused = _extended.first(where: { return $0.key + current <= _face + delta && $0.key + current > _face - delta })?.value else {
                fatalError("no focused pins")
            }
            
            for spoke in _spokes {
//                print("current \(_current)")
                if spoke.index == focused {
                    spoke.focused = true
                    
                    //focus pin
                    do {
                        guard let image = spoke.pin.images[_state]?.first(where: { return $0.key == .focused })?.value else {
                            fatalError("no images for state \(_state):\(SVState.focused) in \(spoke.pin.name)")
                        }
                        spoke.pin.setImage(image, for: .normal)
                    }
                }
                else {
                    spoke.focused = false
                    
                    //unfocus pin
                    do {
                        guard let image = spoke.pin.images[_state]?.first(where: { return $0.key == .visible })?.value else {
                            fatalError("no images for state \(_state):\(SVState.visible) in \(spoke.pin.name)")
                        }
                        spoke.pin.setImage(image, for: .normal)
                    }
                }
            }
        }
    }
    
    func flush(with settings: WSettings?) {
        move(by: 0)
        guard let radius = _settings[_state]?.radius else {
            fatalError("no radius for state \(_state)")
        }
        _background.frame.size = CGSize(width: radius * 2, height: radius * 2)
        _background.center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
        _ = _background.toLayerView
    }

}
