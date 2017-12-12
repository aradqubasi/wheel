//
//  BackgroundView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class OverlayController: RVDelegate {
    
    // MARK: - Public Properties
    
    var focused: NamedPinView {
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
                
                _wheel = RadialView(center: CGPoint(x: scene.bounds.width / 2, y:  scene.bounds.height / 2), orientation: .left)
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
    
    private var _focused: NamedPinView!

    // MARK: - Subviews
    
    private var _background: UIView!
    
    private var _wheel: RadialView!
    
    private var _close: UIButton!
    
    // MARK: - RadialViewDelegate Methods
    
    func numberOfSpokes(in wheel: RadialView) -> Int {
        return 6
    }
    
    func radialView(_ wheel: RadialView) -> RVSettings {
        let radius = ((_scene?.bounds.width) ?? 0) / (2 * CGFloat(2).squareRoot())
        let distance = CGFloat.pi / 3
        let settings = RVSettings(radius, distance)
        return settings
    }
    
    func radialView(pinFor wheel: RadialView, at index: Int) -> UIView {
        let pin = _pins[index]
//        pin.setImage(pin.original, for: .normal)
//        pin.imageEdgeInsets.left = 5
//        pin.imageEdgeInsets.right = 5
//        pin.imageEdgeInsets.top = 5
//        pin.imageEdgeInsets.bottom = 5
        
//        pin.frame.origin = .zero
//        pin.frame.size.width = 66
//        pin.frame.size.height = 66
//        pin.clipsToBounds = true
//        pin.backgroundColor = UIColor.white
//        pin.layer.cornerRadius = 33
        
        return pin
    }
    
    func radialView(for wheel: RadialView, update pin: UIView, in state: SVState, at index: Int) -> Void {
        
    }
    
    func radialView(backgroundFor wheel: RadialView) -> UIView? {
        return nil
    }
    
    func radialView(for wheel: RadialView, update background: UIView) -> Void {
        
    }
    
    // MARK: - Initializer
    
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

    }

    
    // MARK: - Private Methods
    
    @objc private func onCloseClick(_ sender: UIButton) {
//        print("OverlayController.onCloseClick")
        delegate?.onClose(of: self)
    }
    
    @objc private func onIngridientClick(_ sender: NamedPinView) {
//        print("\(sender.name) is selected")
        _focused = sender
        delegate?.onSelect(in: self)
    }

    // MARK: - Public Methods
    
    /**instant - move subs into position*/
    func set() {
        if let scene = _scene {
            _background.frame.origin.x += scene.bounds.width
            _background.alpha = 0
            
            _wheel.frame.origin.x += scene.bounds.width
            _wheel.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            _close.frame.origin.x += scene.bounds.width
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
        
        if let scene = _scene {
            _background.frame.origin.x -= scene.bounds.width
            _wheel.frame.origin.x -= scene.bounds.width
            _close.frame.origin.x -= scene.bounds.width
        }
        
    }
}
