//
//  OptionsController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class OptionsController {
    
    // MARK: - Private Properties
    
    var _scene: UIView?
    
    var _add: UIButton!
    
    var _lock: UIButton!
    
    var _more: UIButton!
    
    var _close: UIButton!
    
    var _background: UIView!
    
    // MARK: - Public Properties
    
    var view: UIView? {
        get {
            return _scene
        }
        set (new) {
            if _scene != nil {
                _background.removeFromSuperview()
                _add.removeFromSuperview()
                _lock.removeFromSuperview()
                _more.removeFromSuperview()
                _close.removeFromSuperview()
            }
            if let scene = new {
                scene.addSubview(_background)
                scene.addSubview(_add)
                scene.addSubview(_lock)
                scene.addSubview(_more)
                scene.addSubview(_close)
                
            }
            _scene = new
        }
    }
    
    // MARK: - Initialization
    
    init() {
        _add = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 56)))
        _add.addTarget(self, action: #selector(onAdd(_:)), for: .touchUpInside)
        _add.setImage(UIImage.add, for: .normal)
        _add.layer.cornerRadius = 28
        _add.clipsToBounds = true
        _add.backgroundColor = .white
        
        _lock = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 56)))
        _lock.addTarget(self, action: #selector(onLock(_:)), for: .touchUpInside)
        _lock.setImage(UIImage.biglock, for: .normal)
        _lock.layer.cornerRadius = 28
        _lock.clipsToBounds = true
        _lock.backgroundColor = .white
        
        _more = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 56)))
        _more.addTarget(self, action: #selector(onMore(_:)), for: .touchUpInside)
        _more.setImage(UIImage.more, for: .normal)
        _more.layer.cornerRadius = 28
        _more.clipsToBounds = true
        _more.backgroundColor = .white
        
        _close = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 56)))
        _close.addTarget(self, action: #selector(onClose(_:)), for: .touchUpInside)
        _close.setImage(UIImage.close, for: .normal)
        _close.layer.cornerRadius = 28
        _close.clipsToBounds = true
        _close.backgroundColor = .white
        
        _background = UIView()
        _background.backgroundColor = UIColor.limedSpruce
    }
    
    // MARK: - Actions
    
    @objc private func onAdd(_ sender: UIButton) {
        print("onAdd")
    }
    
    @objc private func onLock(_ sender: UIButton) {
        print("onLock")
    }
    
    @objc private func onMore(_ sender: UIButton) {
        print("onMore")
    }
  
    @objc private func onClose(_ sender: UIButton) {
        print("onClose")
    }
    
    // MARK: - Animation Methods
    
    /**instant - set views for display*/
    func set(for pin: UIView) {
        if let scene = _scene {
            _background.frame = scene.bounds
            _background.alpha = 0
            let point: CGPoint = pin.convert(.zero, to: scene)
            let buttons = [_add, _lock, _more, _close]
            buttons.forEach({
                $0?.frame.origin = point
                $0?.transform = CGAffineTransform.identity.scaledBy(x: 0.001, y: 0.001)
            })
        }
    }
    
    /**animatable - display*/
    func show() {
        _background.alpha = 0.8
        _add.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1).translatedBy(x: -3, y: -82)
        _lock.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1).translatedBy(x: -48, y: 2)
        _more.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1).translatedBy(x: -3, y: 78)
        _close.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
    }
    
    /**instant - hide away subviews*/
    func discharge() {
        _background.frame.origin.x = -_background.frame.width
        _add.frame.origin.x = -_add.frame.width
        _lock.frame.origin.x = -_lock.frame.width
        _more.frame.origin.x = -_more.frame.width
        _close.frame.origin.x = -_close.frame.width
    }
    
}
