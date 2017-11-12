//
//  Extensions.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class RadialController: RVDelegate, PVDelegate {
    
    // MARK: - Public Properties
    
    var delegate: RadialControllerDelegate?
    
    var view: RadialView {
        get {
            return _view
        }
        set(new) {
            _view?.delegate = nil
            _view = new
            _view.delegate = self
            if active != state {
                _view.RVState = .inactive
            }
            else {
                _view.RVState = .active
            }
        }
    }
    
    var state: WState {
        get {
            return _state
        }
        set(new) {
            _state = new
            if let wheel = _view {
                if active != state {
                    wheel.RVState = .inactive
                }
                else {
                    wheel.RVState = .active
                }
            }
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
    
    // MARK: - Private Properties
    
    private var _pins: [PinView]!
    
    private var _state: WState!
    
    private var _view: RadialView!
    
    private var _stateSettings: [WState: WSettings]!
    
    // MARK: - Initializer
    
    init(_ pins: [PinView], _ settings: [WState: WSettings]) {
        print(initial)
        
        state = initial
        
        let setPVDelegate = {
            (pin: PinView) -> Void in
            pin.delegate = self
//            pin.addTarget(self, action: #selector(self.onPinClick(_:)), for: .touchUpInside)
        }
        
        _pins = pins
        _pins.forEach(setPVDelegate)
        _stateSettings = settings
        
    }
    
    // MARK: - RVDelegate Methods
    
    func numberOfSpokes(in wheel: RadialView) -> Int {
        return _pins.count
    }
    
    func radialView(_ wheel: RadialView) -> RVSettings {
        guard let settings = _stateSettings[state] else {
            fatalError("no settings @ state \(state) @ \(self)")
        }
//        print(settings.asRvSettings.wheelRadius)
        return settings.asRvSettings
    }
    
    func radialView(pinFor wheel: RadialView, at index: Int) -> UIView {
        guard let pin = _pins.count > index ? _pins[index] : nil else {
            fatalError("no pin @ index \(index) @ \(self)")
        }
        return pin
    }
    
    func radialView(for wheel: RadialView, update pin: UIView, in state: SVState, at index: Int) {
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
        
        pin.frame.origin = .zero
        pin.frame.size.width = settings.size.width
        pin.frame.size.height = settings.size.height
//        pin.layer.cornerRadius = settings.radius
        pin.clipsToBounds = true
    }
    
    // MARK: - PinView Delegate Methods
    
    func onTouchesBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        delegate?.onStateChange(to: active, of: view)
    }
    
    func onTouchesMoved(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        
    }
    
    func onTouchesEnded(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        
    }
    
    func onTouchCanceled(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        
    }
    
    // MARK: - Placeholder
    
    func moveToRandomPin() {
        if let wheel = _view {
            let index = Int(arc4random_uniform(UInt32(_pins.count)))
            wheel.move(to: index)
        }
    }
    
}

