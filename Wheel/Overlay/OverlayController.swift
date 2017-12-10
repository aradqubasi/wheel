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
                
//                _wheel.frame.origin = CGPoint(x: 0, y:  scene.bounds.height / 2 - scene.bounds.width / 2)
//                _wheel.frame.size = CGSize(side: scene.bounds.width)
//                _wheel.layer.cornerRadius = scene.bounds.width / 2
//                scene.addSubview(_wheel)
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
    
    private var _pins: [PinView]!

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
        pin.setImage(pin.original, for: .normal)
        pin.imageEdgeInsets.left = 5
        pin.imageEdgeInsets.right = 5
        pin.imageEdgeInsets.top = 5
        pin.imageEdgeInsets.bottom = 5
        
        pin.frame.origin = .zero
        pin.frame.size.width = 66
        pin.frame.size.height = 66
        pin.clipsToBounds = true
        pin.backgroundColor = UIColor.white
        pin.layer.cornerRadius = 33
        
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
    
    init() {
        
        _background = UIView()
        _background.backgroundColor = UIColor.limedSpruce

        let cookedgrains = PinView.create.name("cookedgrains").icon(selected: UIImage.cookedgrains).kind(of: .unexpected)
        let cottagecheese = PinView.create.name("cottagecheese").icon(selected: UIImage.cottagecheese).kind(of: .unexpected)
        let hotpepper = PinView.create.name("hotpepper").icon(selected: UIImage.hotpepper).kind(of: .unexpected)
        let olives = PinView.create.name("olives").icon(selected: UIImage.olives).kind(of: .unexpected)
        let onion = PinView.create.name("onion").icon(selected: UIImage.onion).kind(of: .unexpected)
        let pickledveggies = PinView.create.name("pickledveggies").icon(selected: UIImage.pickledveggies).kind(of: .unexpected)
        _pins = [cookedgrains, cottagecheese, hotpepper, olives, onion, pickledveggies]
        
//        _wheel = UIView()
//        _wheel.backgroundColor = UIColor.white
        
        _close = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 64)))
        _close.setImage(UIImage.close, for: .normal)
        _close.addTarget(self, action: #selector(onCloseClick(_:)), for: .touchUpInside)

    }

    
    // MARK: - Private Methods
    
    @objc private func onCloseClick(_ sender: UIButton) {
//        print("OverlayController.onCloseClick")
        delegate?.onClose(of: self)
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
