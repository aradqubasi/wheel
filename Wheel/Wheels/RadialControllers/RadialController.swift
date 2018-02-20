//
//  Extensions.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class RadialController: SWAbstractWheelDelegate, PVDelegate, SWAbstractWheelController {

    // MARK: - Public Properties
    
    var delegate: RadialControllerDelegate?
    
    var label: UILabel {
        get {
            guard let label = _label else {
                fatalError("mark is not assigned to controller")
            }
            return label
        }
        set(new) {
            _label = new
            apply(_state)
        }
    }
    
    var state: WState {
        get {
            return _state
        }
        set(new) {
            _state = new
            apply(new)
        }
    }
    
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
    
    var focused: PinView {
        get {
            return _pins[_view.index]
        }
    }
    
    // MARK: - Private Properties
    
    private var _name: String
    
    private var _pins: [PinView]!
    
    private var _state: WState!
    
    private var _view: SWAbstractWheelView!
    
    private var _stateSettings: [WState: WSettings]!
    
    private var _label: UILabel?
    
    // MARK: - Initializer
    
    init(_ wheel: SWAbstractWheelView, _ pins: [PinView], _ settings: [WState: WSettings], _ name: String) {
        
        _name = name
        
        let setPVDelegate = {
            (pin: PinView) -> Void in
            pin.delegate = self
        }
        
        _pins = pins
        _pins.forEach(setPVDelegate)
        _stateSettings = settings
        state = initial
        
        _view = wheel
        _view.delegate = self
        _view.name = _name
        apply(_state)
    }
    
    // MARK: - RVDelegate Methods
    
    func numberOfSpokes(in wheel: SWAbstractWheelView) -> Int {
        return _pins.count
    }
    
    func radialView(_ wheel: SWAbstractWheelView) -> SWWheelSettings {
        guard let settings = _stateSettings[state] else {
            fatalError("no settings @ state \(state) @ \(self)")
        }
        return settings.asSwWheelSettings
    }
    
    func radialView(pinFor wheel: SWAbstractWheelView, at index: Int) -> UIView {
        guard let pin = _pins.count > index ? _pins[index] : nil else {
            fatalError("no pin @ index \(index) @ \(self)")
        }
        return pin
    }
    
    func radialView(for wheel: SWAbstractWheelView, update pin: UIView, in state: SVState, at index: Int) {
        guard let pin = _pins.count > index ? _pins[index] : nil else {
            fatalError("no pin @ index \(index) @ \(self)")
        }
        guard let settings = _stateSettings[_state] else {
            fatalError("no settings @ state \(_state) @ \(self)")
        }
        guard let images = pin.images[_state], let image = images[state]  else {
            fatalError("no image @ index \(index) @ wstate \(_state) @ svstate \(state) @ \(self)")
        }

        pin.setImage(image, for: .normal)
        
        if pin.frame.origin != .zero || pin.frame.size != settings.size {
            print("identity rc \(pin.frame.origin) \(pin.frame.size) \(settings.size)")
            let transform = pin.transform
            pin.transform = CGAffineTransform.identity
            pin.frame.origin = .zero
            pin.setPin(size: settings.size)
            pin.transform = transform
        }
        
        if state == .focused {
            _label?.text = pin.name.uppercased()
        }
    }
    
    func radialView(backgroundFor wheel: SWAbstractWheelView) -> UIView? {
        return UIView()
    }
    
    func radialView(for wheel: SWAbstractWheelView, update background: UIView) {
        guard let settings = _stateSettings[_state] else {
            fatalError("no settings @ state \(_state) @ \(self)")
        }
        background.frame.size = CGSize(side: settings.radius * 2)
        _ = background.toLayerView
    }
    
    // MARK: - PinView Delegate Methods
    
    func onTouchesBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        delegate?.onStateChange(to: active, of: _view)
    }
    
    func onTouchesMoved(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        
    }
    
    func onTouchesEnded(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        
    }
    
    func onTouchCanceled(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        
    }
    
    func onClick(_ pin: PinView, with event: UIEvent?) {
        guard let index = _pins.index(of: pin) else {
            fatalError("onPinClick invoked not by PinView")
        }
        delegate?.onPinClick(in: self, of: pin, at: index)
    }
    
    func onLongPress(in pin: PinView) {
        guard let index = _pins.index(of: pin) else {
            fatalError("onLongPress invoked by unlisted pin")
        }
        delegate?.radialController(preesing: pin, in: self, at: index)
    }
    
    // MARK: - Actions
    
    func moveToRandomPin() {
        if let wheel = _view {
            let allowed = _pins.filter({ return $0.state == .locked })
            
            var index: Int = -1
            if allowed.count == 0 {
                index = Int(arc4random_uniform(UInt32(_pins.count)))
            }
            else {
                index = Int(arc4random_uniform(UInt32(allowed.count)))
                index = _pins.index(of: allowed[index])!
            }
            wheel.move(to: index)
        }
    }
    
    func move(to index: Int) -> Void {
        _view.move(to: index)
    }
    
    // MARK: - Private Methods
    
    private func apply(_ state: WState) {
        
        guard let settings = _stateSettings[_state] else {
            fatalError("no settings @ state \(_state) @ \(self)")
        }
        
        _view?.flush(with: settings)
        
        if let label = _label {
            label.transform = CGAffineTransform(rotationAngle: 0)
            guard let parent = label.superview else {
                fatalError("view is not attached to superview")
            }
        
            var x = parent.bounds.width
            x -= settings.radius
            x -= label.frame.width / 2
            x += settings.size.width
            x += 20

            let y = parent.bounds.height / 2 - label.frame.height / 2
            label.frame.origin = CGPoint(x: x, y: y)
            label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
            label.font = UIFont.markunselected
        }
    }
}

