//
//  SWWheelView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWWheelView: SWAbstractWheelController, SWRingMaskDelegate, PVDelegate {    
    
    // MARK: - Initializers
    
    init(in container: UIView) {
        
        _container = container
        
        name = "Bases"
        
        //pins & spokes setup
        do {
            let romainelettuce = PinView.create.name("romainelettuce").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            romainelettuce.delegate = self
            _spokes.append(SWSpoke.init(UIView(), romainelettuce, 0, true, 0))
            
            let salad = PinView.create.name("salad").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            salad.delegate = self
            _spokes.append(SWSpoke.init(UIView(), salad, 1, false, 0))
            
            let cabbage = PinView.create.name("cabbage").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            cabbage.delegate = self
            _spokes.append(SWSpoke.init(UIView(), cabbage, 2, false, 0))
            
            let lettuce = PinView.create.name("lettuce").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            lettuce.delegate = self
            _spokes.append(SWSpoke.init(UIView(), lettuce, 3, false, 0))
            
            let spinach = PinView.create.name("spinach").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            spinach.delegate = self
            _spokes.append(SWSpoke.init(UIView(), spinach, 4, false, 0))
            
            let brusselssprouts = PinView.create.name("brusselssprouts").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            brusselssprouts.delegate = self
            _spokes.append(SWSpoke.init(UIView(), brusselssprouts, 5, false, 0))
            
//            zoodles (aka spiralized zucchini)
            let zoodles = PinView.create.name("zoodles").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            zoodles.delegate = self
            _spokes.append(SWSpoke.init(UIView(), zoodles, 6, false, 0))
            
            let shavedfennel = PinView.create.name("shavedfennel").icon(default: UIImage.corn).icon(UIImage.Corn, for: .bases).icon(selected: UIImage.Corn).kind(of: .base)
            shavedfennel.delegate = self
            _spokes.append(SWSpoke.init(UIView(), shavedfennel, 7, false, 0))
            
            _state = initial
            
            _settings = [
                .bases: WSettings(155, CGFloat.pi * 2 / 8, .zero, CGFloat.pi, 1.25),
                .fats: WSettings(141, CGFloat.pi * 2 / 8, .zero, CGFloat.pi, 1),
                .veggies: WSettings(141, CGFloat.pi * 2 / 8, .zero, CGFloat.pi, 1),
                .proteins: WSettings(141, CGFloat.pi * 2 / 8, .zero, CGFloat.pi, 1)
            ]
            
            _face = CGFloat.pi //* 0.75
        }
        
        // drawing
        do {
            _background = UIView()
            _view = SWRingMaskView(frame: _container.bounds)
            _view.delegate = self
            _view.addSubview(_background)
            _container.addSubview(_view)
            
            let maxPinFactor = _settings.mapValues({ return $0.scale }).max(by: { return $1.value > $0.value })!.value
            let offset = (maxPinFactor - 1) * 0.5
            
            for i in 0..<_spokes.count {
                
                let socket = _spokes[i].socket
                let pin = _spokes[i].pin
                
//                pin.frame.origin = CGPoint(x: 52 * 0.125, y: 52 * 0.125)
                pin.frame.origin = CGPoint(x: 52 * offset, y: 52 * offset)
                pin.setPin(size: CGSize(width: 52, height: 52))
                guard let image = pin.images[_state]?[.visible] else {
                    fatalError("no image")
                }
                pin.setImage(image, for: .normal)
                
//                socket.frame.size = CGSize(width: 52 * 1.25, height: 52 * 1.25)
                socket.frame.size = CGSize(width: 52 * maxPinFactor, height: 52 * maxPinFactor)
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
//                socket.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(a), y: radius * sin(a))
                _spokes[i].angle = a
            }
            
            resize(to: _state)
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
//    private var _view: UIView!
    private var _view: SWRingMaskView!

    /**current angle*/
    private var _current: CGFloat {
        get {
            return atan2(_view.transform.b, _view.transform.a)
        }
    }
    
    /**this property is making sure that there is only a single instance of abstracted version of this view*/
    private var _abstracted: SWWheelViewAbstracted?
    
    /**background view, resize each time state is updated*/
    var _background: UIView!
    
    /**show item name when active, otherwise wheel name*/
    private var _label: UILabel?
    
    /**initial height of label before transforms are applied*/
    private var _height: CGFloat?
    
    // MARK: - Private Methods
    
    private func resize(to state: WState) {
        
        guard let settings = _settings[state] else {
            fatalError("no settings for wheel \(name) @ \(state)")
        }
        
        for spoke in _spokes {
//            let radius = settings.radius - spoke.socket.frame.width * 0.5
            let radius = settings.radius - spoke.pin.frame.width * 0.5 * settings.scale
            let a = spoke.angle
            spoke.socket.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(a), y: radius * sin(a))
        }
        
    }
    
    private func printMark(for state: WState) {
        if let label = _label {
            let text = state == active ? focused.asIngridient.name : name
            label.text = text.uppercased()
            label.font = UIFont.markunselected
        }
        
        guard let settings = _settings[state] else {
            fatalError("no settings for wheel \(name) @ \(state)")
        }
        
        if let label = _label, let height = _height, let parent = label.superview {
            print("mark center is \(label.center)")
            let old = parent.convert(label.center, to: _container)
            
            var new = _view.center
            new.x += -settings.radius + 52 * settings.scale + height * 0.5
            print("mark height \(label.frame.height)")
            
            new.x -= old.x
            new.y -= old.y
            
//            label.transform = CGAffineTransform.identity.rotated(by: -CGFloat.pi * 0.5).translatedBy(x: new.x, y: new.y)
            print("mark translatedby \(new)")
            label.transform = CGAffineTransform.identity.translatedBy(x: new.x, y: new.y).rotated(by: -CGFloat.pi * 0.5)
        }
    }
    
    // MARK: - Public Properties
    
    var active: WState {
        get {
            return .bases
        }
    }
    
    var initial: WState {
        get {
            return .bases
        }
    }
    
    // MARK: - Public Methods
    
    func asSWAbstractWheelView() -> SWAbstractWheelView {
        if _abstracted == nil {
            _abstracted = SWWheelViewAbstracted(parent: self)
        }
        return _abstracted!
    }

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
    
    var label: UILabel {
        get {
            guard let label = _label else {
                fatalError("mark is not assigned to controller")
            }
            return label
        }
        set(new) {
            _label = new
            _height = new.frame.height
            printMark(for: _state)
        }
    }
    
    /**we do not need it here... do not touch it*/
    var delegate: RadialControllerDelegate?
    
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
    
    /**wheel name, aestetics purposes only*/
    var name: String
    
    /**rotate wheel to specific anglew which would bring pin to face*/
    func move(to index: Int) {
        let current = _current
        let face = _face!
        let angle = _spokes[index].angle
        self.move(by: face - current - angle)
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
            
            printMark(for: _state)
        }
    }
    
    func flush(with settings: WSettings?) {
        resize(to: _state)
        move(by: 0)
        guard let radius = _settings[_state]?.radius else {
            fatalError("no radius for state \(_state)")
        }
        _background.frame.size = CGSize(width: radius * 2, height: radius * 2)
        _background.center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
        _ = _background.toLayerView
        _view._center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
        _view._thickness = 65
        _view._radius = radius
        
        printMark(for: _state)
//        _view._dots.forEach({ $0.removeFromSuperview() })
//        for x in 0..<(Int(_view.bounds.width) / 10) {
//            for y in 0..<(Int(_view.bounds.height) / 10) {
//                _view.point(inside: CGPoint(x: x * 10, y: y * 10), with: nil)
//            }
//        }
    }

    // MARK: - SWRingMaskDelegate Methods
    
    func onHit(_ sender: SWRingMaskView, with event: UIEvent?) {
        delegate?.onStateChange(to: active, of: self.asSWAbstractWheelView())
    }
    
    // MARK: - PVDelegate Methods
    
    func onClick(_ pin: PinView, with event: UIEvent?) {
        guard let index = _spokes.map({ return $0.pin }).index(of: pin) else {
            fatalError("onPinClick invoked not by PinView")
        }
        delegate?.onPinClick(in: self, of: pin, at: index)
    }
    
    func onLongPress(in pin: PinView) {
        guard let index = _spokes.map({ return $0.pin }).index(of: pin) else {
            fatalError("onLongPress invoked by unlisted pin")
        }
        delegate?.radialController(preesing: pin, in: self, at: index)
    }
}
