//
//  SWTransformOverlayController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWTranslatedOverlayController : SWOverlayController {
  
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
    
    var view: UIView?
    
    // MARK: - Private Properties
    
    private var _scene: UIView!
    
    private var _pins: [NamedPinView]!
    
    private var _focused: NamedPinView?
    
    private var _opened: Bool!
    
    private var _aligner: SWWheelsAligner!
    
    private var _background: UIView!
    
    private var _wheel: UIView!
    
    private var _close: UIButton!
    
    // MARK: - Initialization
    
    init(ingredients: [SWIngredient], aligner: SWWheelsAligner, scene: UIView) {
        _scene = scene
        
        _aligner = aligner
        
        _background = UIView(frame: scene.bounds)
        _background.backgroundColor = UIColor.limedSpruce
        _scene.addSubview(_background)
        
        do {
            let radius = ((_scene?.bounds.width) ?? 0) * 0.5 - aligner.getOverlayMargin()
            _wheel = UIView(frame: CGRect(origin: .zero, size: CGSize(width: radius * 2, height: radius * 2)))
            _scene.addSubview(_wheel)
        }
        
        _pins = []
        flushIngredients(with: ingredients)
        
        _close = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 64)))
        _close.setImage(UIImage.close, for: .normal)
        _close.addTarget(self, action: #selector(onCloseClick(_:)), for: .touchUpInside)
        _scene.addSubview(_close)
        
        _opened = false
        
        discharge()
        
    }
    
    // MARK: - Private Methods
    
    // MARK: - Actions
    
    func focusing(_ pin: NamedPinView) {
        _focused = pin
        _pins.forEach({ (next) in next.state = next === pin ? .highlight : .regular })
    }
    
    func unfocus() {
        _focused = nil
        _pins.forEach({ (next) in next.state = .regular })
    }
    
    @IBAction private func onCloseClick(_ sender: UIButton) {
        delegate?.onClose(of: self)
    }
    
    @IBAction private func onIngridientClick(_ sender: NamedPinView) {
        //focusing(sender)
        delegate?.onSelect(of: sender, in: self)
    }
    
    // MARK: - Public Methods
    
    func focus(on pin: SWIngredient) {
        unfocus()
        guard let pin = _pins?.first(where: { $0._ingredient?.name == pin.name }) else {
            fatalError("can n ot focus on non-existant ingredient")
        }
        focusing(pin)
    }
    
    func random() {
        let visible = _pins.filter({ $0.alpha != 0 })
        if (visible.count != 0){
            let index = Int(arc4random_uniform(UInt32(visible.count)))
            let new = visible[index]
            delegate?.onFocus(of: new.asIngridient, in: self)
            //focusing(new)
        }
        else {
            unfocus()
        }
    }
    
    func flushIngredients(with updated: [SWIngredient]) {
        
        _pins.forEach({ $0.alpha = 0 })
        
        var visible: [NamedPinView] = []
        //add mising
        updated.forEach({ (new: SWIngredient) -> Void in
            var listed = self._pins.first(where: {
                (existing: NamedPinView) -> Bool in
                return existing.asIngridient.id == new.id
            })
            if listed == nil {
                let additional = NamedPinView(for: new)
                _pins.append(additional)
                _wheel.addSubview(additional)
                listed = additional
            }
            visible.append(listed!)
            listed!.alpha = 1
        })
        
        if let focused = _focused {
            _focused = visible.contains(focused) ? focused : nil
        }
        
        switch updated.count {
        case 0:
            break
        case 1:
            let pin = visible[0]
            let central = _wheel.getBoundsCenter()
            pin.addTarget(self, action: #selector(onIngridientClick(_:)), for: .touchUpInside)
            pin.center = central
            pin.transform = CGAffineTransform.identity.translatedBy(x: 0, y: 0)
            break
        case 3:
            _aligner.alignCircle(views: visible, center: _wheel.getBoundsCenter(), radius: _wheel.bounds.width * 0.5 - visible[0].frame.width * 0.5, rotation: CGFloat.pi * 0.5)
            visible.forEach({ $0.addTarget(self, action: #selector(onIngridientClick(_:)), for: .touchUpInside) })
            break
        case 5:
            _aligner.alignCircle(views: visible, center: _wheel.getBoundsCenter(), radius: _wheel.bounds.width * 0.5 - visible[0].frame.width * 0.5, rotation: -CGFloat.pi * 0.1)
            visible.forEach({ $0.addTarget(self, action: #selector(onIngridientClick(_:)), for: .touchUpInside) })
            break
        //2,4,6..<Inf+
        default:
            _aligner.alignCircle(views: visible, center: _wheel.getBoundsCenter(), radius: _wheel.bounds.width * 0.5 - visible[0].frame.width * 0.5, rotation: 0)
            visible.forEach({ $0.addTarget(self, action: #selector(onIngridientClick(_:)), for: .touchUpInside) })
        }
    }
    
    // MARK: - Animation Methods
    
    /**instant - move subs into position, alignment based on open overlay button */
    func set(for button: UIButton) {
        if let scene = _scene {
            _background.frame.origin = scene.bounds.origin
            _background.alpha = 0
            
            let visible = _pins.filter({ $0.alpha != 0 }).count
            if (visible < 3) {
                aligner.alignToCenter(subwheel: _wheel)
            }
            else {
                aligner.align(subwheel: _wheel, with: button)
            }
            
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
