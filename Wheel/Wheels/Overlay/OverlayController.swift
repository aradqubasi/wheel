//
//  BackgroundView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class OverlayController: SWAbstractWheelDelegate, SWOverlayController /*RVDelegate*/ {

    // MARK: - Public Properties
    
    var aligner: SWWheelsAligner {
        get {
            return _aligner
        }
        set(new) {
            _aligner = new
        }
    }
    
    var opened: Bool {
        get {
            return _opened
        }
    }
    
    var focused: NamedPinView? {
        get {
            return _focused
        }
    }
    
    var delegate: OverlayControllerDelegate?
    
    var view: UIView? {
        get {
            return _scene
        }
        
        set(new) {
            if let scene = new {
                _scene = scene
                
                _background.frame = scene.bounds
                scene.addSubview(_background)

                _wheel = RadialView(center: CGPoint(x: (scene.bounds.width - 80) * 0.5, y:  (scene.bounds.width - 80) * 0.5), orientation: .left)
                _wheel.delegate = self
                _wheel.move(by: 0)
                scene.addSubview(_wheel)
                
                _close.frame.origin = CGPoint(x: 0, y: scene.bounds.height / 2 - scene.bounds.width / 2)
                scene.addSubview(_close)
                
                discharge()
            }
            else {
                _scene = nil
                _background.removeFromSuperview()
                _wheel.removeFromSuperview()
                _close.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Private Property
    
    private var _scene: UIView?
    
    private var _pins: [NamedPinView]!
    
    private var _focused: NamedPinView?
    
    private var _opened: Bool!
    
    private var _aligner: SWWheelsAligner!

    // MARK: - Subviews
    
    private var _background: UIView!
    
    private var _wheel: RadialView!
    
    private var _close: UIButton!
    
    // MARK: - RadialViewDelegate Methods
    
    func numberOfSpokes(in wheel: SWAbstractWheelView) -> Int {
        return 6
    }
    
//    func radialView(_ wheel: SWAbstractWheelView) -> RVSettings {
//        let radius = ((_scene?.bounds.width) ?? 0) * 0.5 - 40
//        let distance = CGFloat.pi / 3
//        let settings = RVSettings(radius, distance)
//        return settings
//    }
    
    func radialView(_ wheel: SWAbstractWheelView) -> SWWheelSettings {
        let radius = ((_scene?.bounds.width) ?? 0) * 0.5 - aligner.getOverlayMargin()
        let distance = CGFloat.pi / 3
        let settings = SWWheelSettings(radius, distance, CGFloat.pi * 1.5, 1)
        return settings
    }
    
    func radialView(pinFor wheel: SWAbstractWheelView, at index: Int) -> UIView {
        let pin = _pins[index]
        
        return pin
    }
    
    func radialView(for wheel: SWAbstractWheelView, update pin: UIView, in state: SVState, at index: Int) -> Void {
        
    }
    
    func radialView(backgroundFor wheel: SWAbstractWheelView) -> UIView? {
        return nil
    }
    
    func radialView(for wheel: SWAbstractWheelView, update background: UIView) -> Void {
        
    }
    
    // MARK: - Initializer
    
    convenience init(_ ingredients: [SWIngredient]) {
        let named = ingredients.map({ NamedPinView(for: $0) })
        self.init(named)
    }
    
    /**non-empty set of pins is required*/
    init(_ pins: [NamedPinView]) {
        
        _background = UIView()
        _background.backgroundColor = UIColor.limedSpruce
     
        if pins.count == 0 {
            fatalError("set of pins for overlay controller is empty")
        }
        _pins = pins
        _pins.forEach({ $0.addTarget(self, action: #selector(onIngridientClick(_:)), for: .touchUpInside)})
        _focused = _pins.first!
        
        _close = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 64)))
        _close.setImage(UIImage.close, for: .normal)
        _close.addTarget(self, action: #selector(onCloseClick(_:)), for: .touchUpInside)

        _opened = false
    }

    
    // MARK: - Private Methods
    
    func focusing(_ pin: NamedPinView) {
        _focused = pin
        _pins.forEach({ (next) in next.state = next === pin ? .highlight : .regular })
    }
    
    @IBAction private func onCloseClick(_ sender: UIButton) {
//        print("OverlayController.onCloseClick")
        delegate?.onClose(of: self)
    }
    
    @IBAction private func onIngridientClick(_ sender: NamedPinView) {
//        print("\(sender.name) is selected")
        focusing(sender)
        delegate?.onSelect(in: self)
    }

    // MARK: - Public Methods
    
    func random() {
        let index = Int(arc4random_uniform(UInt32(_pins.count)))
        let new = _pins[index]
        focusing(new)
//        return new
    }
    
    func unfocus() {
        
    }
    
    func flushIngredients(with updated: [SWIngredient]) {
        
    }
    
    // MARK: - Animation Methods
    
    /**instant - move subs into position, alignment based on open overlay button */
    func set(for button: UIButton) {
        if let scene = _scene {
            _background.frame.origin = scene.bounds.origin
            _background.alpha = 0
            
            aligner.align(subwheel: _wheel, with: button)
            
            _close.frame = button.convert(button.bounds, to: scene)
            
            _wheel.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            
            _opened = true
        }
    }
    
    /**animatable - open subs*/
    func open() {
        if let _ = _scene {
            _background.alpha = 0.8
            
            _wheel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    /**animatable - close subs*/
    func close() {
        if let _ = _scene {
            _background.alpha = 0
            
            _wheel.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }
    }
    
    /**instant - remove subs from screen*/
    func discharge() {
        _wheel.transform = CGAffineTransform(scaleX: 1, y: 1)
        _background.frame.origin.x = -_background.frame.width
        _wheel.frame.origin.x = -_wheel.frame.width
        _close.frame.origin.x = -_close.frame.width
        _opened = false
    }
}
