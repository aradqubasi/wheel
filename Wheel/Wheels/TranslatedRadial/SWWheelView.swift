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
    
    convenience init(_ ingredients: [SWIngredient], with spacing: CGFloat, as active: WState, in container: UIView, facing angle: CGFloat) {

        // calculate geometry
        let basePinWidth: CGFloat = 42
        let inset: CGFloat = 5
        var settings: [WState : WSettings] = [:]
        do {
            let inset = inset
            let activeScale: CGFloat = 1
            let usualScale: CGFloat = 1
            let pin: CGFloat = basePinWidth
            let mark: CGFloat = 14
            let pointer: CGFloat = 12
            let foundation: CGFloat = 78
            guard let number: Int = WState.all.index(of: active) else {
                fatalError("state does not exists at WState.all collection")
            }
            
            let usualThickness: CGFloat = mark + pin * usualScale + inset
            let activeThickness: CGFloat = pointer + mark + pin * activeScale + inset
            var before = true
            for state in WState.all {
                let isActive = state == active
                before = isActive ? false : before
                let radius: CGFloat = foundation + CGFloat(number) * usualThickness + (before || isActive ? activeThickness : usualThickness)
                settings[state] = WSettings(radius, isActive ? activeScale : usualScale)
            }
        }
        
        // calculate capacity
        var capacity: Int
        do {
            guard let maxSizes = settings[active] else {
                fatalError("active state was not defined")
            }
            let pinArcLength = basePinWidth
            let pinAngularSize = pinArcLength / maxSizes.radius
            let spacingArcLength = spacing
            let spacingAngularSize = spacingArcLength / maxSizes.radius
            // 2pi = capacity * (spacing + pin) + spacing
            capacity = Int((2 * CGFloat.pi - spacingAngularSize) / (pinAngularSize + spacingAngularSize))
        }
        
        var spokes: [SWSpoke] = []
        do {
            var i = 0
            for j in 0..<capacity {
                
                let ingredient = ingredients[i]
                let pin = PinView.create.name(ingredient.name).icon(default: ingredient.outline).icon(ingredient.image, for: active).icon(selected: ingredient.image).kind(of: ingredient.kind)
                spokes.append(SWSpoke.init(UIView(), pin, j, j == 0, 0))
                
                i = i == ingredients.count - 1 ? 0 : i + 1
            }
        }
        
        self.init(in: container, with: spokes, use: settings, facing: angle, as: active.rawValue, basePinWidth, inset, active: active)
    }
    
    init(in container: UIView, with spokes: [SWSpoke], use settings: [WState : WSettings], facing angle: CGFloat, as name: String, _ basePinWidth: CGFloat, _ inset: CGFloat, active: WState) {
        
        _active = active
        
        _container = container
        
        self.name = name
        
        _pin = basePinWidth
        
        _inset = inset
        
        //pins & spokes setup
        do {
            _settings = settings
            
            _face = angle
            
            _spokes = spokes
            _spokes.forEach({ $0.pin.delegate = self })
            
            _state = initial
            
            
        }
        
        // drawing
        do {
            _background = UIView()
            _view = SWRingMaskView(frame: _container.bounds)
            _view.delegate = self
            _view.addSubview(_background)
            _container.addSubview(_view)
            
            _lock = UIButton.lock
            _container.addSubview(_lock)
            _lock.center = _container.getBoundsCenter()
            _lock.addTarget(self, action: #selector(onUnlock(_:)), for: .touchUpInside)
            
            let maxPinFactor = _settings.mapValues({ return $0.scale }).max(by: { return $1.value > $0.value })!.value
            let offset = (maxPinFactor - 1) * 0.5
            
            for i in 0..<_spokes.count {
                
                let socket = _spokes[i].socket
                let pin = _spokes[i].pin
                
                pin.frame.origin = CGPoint(x: _pin * offset, y: _pin * offset)
                pin.setPin(size: CGSize(width: _pin, height: _pin))
                guard let image = pin.images[_state]?[.visible] else {
                    fatalError("no image")
                }
                pin.setImage(image, for: .normal)
                
                socket.frame.size = CGSize(width: _pin * maxPinFactor, height: _pin * maxPinFactor)
                socket.center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
                socket.addSubview(pin)
                
                _view.addSubview(socket)
                
                var a = _distance * CGFloat(i)
                a = a > CGFloat.pi ? a - 2 * CGFloat.pi : a
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
        }
        
        flush()
        move(to: spokes.count / 2)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Properties
    
    private var _active: WState!
    
    private var _isLocked: Bool = false
    
    private var fixedOrientation = false
    
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
    
    /**angular distance between pins*/
    private var _distance: CGFloat {
        get {
            return CGFloat.pi * CGFloat(2) / CGFloat(_spokes.count)
        }
    }
    
    /**base size of pin, later modified by scale*/
    private var _pin: CGFloat!
    
    /**pins inset from the edge of the wheel*/
    private var _inset: CGFloat!
    
    /**lock icon*/
    private var _lock: UIButton!
    
    // MARK: - Actions
    
    @IBAction private func onUnlock(_ sender: UIButton) {
        if let locked = _spokes.first(where: { $0.pin.state == .locked }) {
            delegate?.onUnlockClick(self, of: locked.pin, at: locked.index)
        }
    }
    
    // MARK: - Private Methods
    
    private func resize(to state: WState) {
        
        guard let settings = _settings[state] else {
            fatalError("no settings for wheel \(name) @ \(state)")
        }
        
        let radius = settings.radius - _pin * 0.5 * settings.scale - _inset
        for spoke in _spokes {
            let a = spoke.angle
            spoke.socket.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(a), y: radius * sin(a))
            spoke.pin.transform = CGAffineTransform.identity.rotated(by: fixedOrientation ? 0 : a - CGFloat.pi)
        }
        
        _lock.transform = CGAffineTransform.identity.scaledBy(x: _isLocked ? 1 : 0, y: _isLocked ? 1 : 0).translatedBy(x: settings.radius * cos(_face), y: settings.radius * sin(_face) - _pin * 0.5 * settings.scale)
        
    }
    
    private func printMark(for state: WState) {
        if let label = _label {
            let text = state == _active ? focused.asIngridient.name : name
            label.text = text.uppercased()
            label.font = UIFont.markunselected
        }
        
        guard let settings = _settings[state] else {
            fatalError("no settings for wheel \(name) @ \(state)")
        }
        
        if let label = _label, let height = _height, let parent = label.superview {
            let old = parent.convert(label.center, to: _container)
            
            var new = _view.center
            new.x += -settings.radius + _pin * settings.scale + height * 0.5 + _inset
            new.x -= old.x
            new.y -= old.y
            label.transform = CGAffineTransform.identity.translatedBy(x: new.x, y: new.y).rotated(by: -CGFloat.pi * 0.5)
        }
    }
    
    // MARK: - Public Properties
    
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
    
    func refill(with pool: [SWIngredient]) {
        let capacity = _spokes.count
        do {
            var i = 0
            for j in 0..<capacity {
                
                let ingredient = pool[i]
                let pin = _spokes[j].pin
//                let state = pin.state
                _ = pin.name(ingredient.name).icon(default: ingredient.outline).icon(ingredient.image, for: _active).icon(selected: ingredient.image).kind(of: ingredient.kind)
//                pin.
                i = i == pool.count - 1 ? 0 : i + 1
            }
        }
    }

    // MARK: - SWAbstractWheelController
    
    var active: WState {
        get {
            return _active
        }
    }
    
    var radius: CGFloat {
        get {
            guard let radius = _settings[_state]?.radius else {
                fatalError("Could not find settings for state \(_state)")
            }
            return radius
        }
    }
    
    var isLocked: Bool {
        
        get {
            return _isLocked
        }

    }
    
    var focused: PinView {
        get {
            guard let focused = _spokes.first(where: { return $0.focused }) else {
                fatalError("no active spoke")
            }
            return focused.pin
        }
    }
    
    func moveToRandomPin() {
        if _spokes.count != 0 {
            if let locked = _spokes.first(where: { $0.pin.state == .locked }) {
                move(to: locked.index)
            }
            else {
                let random = Int(arc4random_uniform(UInt32(_spokes.count)))
                move(to: random)
            }
        }
    }
    
    var state: WState {
        get {
            return _state
        }
        set(new) {
            _state = new
            flush()
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
    var delegate: SWAbstractWheelControllerDelegate?
    
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
//        print("\(name) spin by \(new) or pi * \(new / CGFloat.pi)")
        _view.transform = CGAffineTransform.identity.rotated(by: new)
        guard let factor = _settings[state]?.scale else {
            fatalError("no settings for state \(state)")
        }
        for spoke in _spokes {
            spoke.pin.transform = CGAffineTransform.identity.scaledBy(x: factor, y: factor).rotated(by: fixedOrientation ? -new : spoke.angle - CGFloat.pi)
        }
        
        //check focus
        do {
            let delta = _distance * 0.5
            let current = _current
            guard let focused = _extended.first(where: { return $0.key + current <= _face + delta && $0.key + current > _face - delta })?.value else {
                fatalError("no focused pins")
            }
            
            for spoke in _spokes {
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
    
    func flush() {
        resize(to: _state)
        move(by: 0)
        guard let settings = _settings[_state] else {
            fatalError("no settings for state \(_state)")
        }
        let radius = settings.radius
        _background.frame.size = CGSize(width: radius * 2, height: radius * 2)
        _background.center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
        _ = _background.toLayerView
        _view._center = CGPoint(x: _view.bounds.width * 0.5, y: _view.bounds.height * 0.5)
        _view._thickness = settings.scale * _pin + _inset
        _view._radius = radius
        
        printMark(for: _state)
    }

    
    // MARK: - SWRingMaskDelegate Methods
    
    func onHit(_ sender: SWRingMaskView, with event: UIEvent?, on receiver: UIView?) {
        print("onHit")
        
        delegate?.onStateChange(self, to: _active)
    }
    
    // MARK: - PVDelegate Methods
    
    func onTouchesBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        if _state != _active {
            delegate?.onStateChange(self, to: _active)
        }
    }
    
    func onClick(_ pin: PinView, with event: UIEvent?) {
        print("onPin")
        guard let index = _spokes.map({ return $0.pin }).index(of: pin) else {
            fatalError("onPinClick invoked not by PinView")
        }
        delegate?.onStateChange(self, to: _active)
        delegate?.onPinClick(self, of: pin, at: index)
    }
    
    func onLongPress(in pin: PinView) {
        guard let index = _spokes.map({ return $0.pin }).index(of: pin) else {
            fatalError("onLongPress invoked by unlisted pin")
        }
//        delegate?.radialController(preesing: pin,?in: self, at: index)
        delegate?.onPinPress(self, of: pin, at: index)
    }
    
    func lock(on pin: PinView) -> Void {
        guard let locked = _spokes.first(where: { $0.pin == pin }) else {
            fatalError("locking: pin \(pin.name) is not found @ wheel \(name)")
        }
        _isLocked = true
        locked.pin.state = .locked
        move(to: locked.index)
        flush()
    }
    
    func unlock() -> Void {
        _isLocked = false
        _spokes.forEach({ $0.pin.state = .free })
        flush()
    }
}
