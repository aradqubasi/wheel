//
//  SWCookButton.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 30/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWCookingButtonDelegate {
    
    func onCook(_ sender: SWCookingButton)
    
}

protocol SWCookingButton {
    
    var container: UIView { get }
    
    var delegate: SWCookingButtonDelegate? { get set }
    
    static func getInitialButton(into view: UIView) -> SWCookingButton
    
}

extension SWCookingButton {
    
    static func ==(_ left: SWCookingButton, _ right: SWCookingButton) -> Bool {
        return left.container == right.container
    }
    
}

class SWEnabledCookingButton: SWCookingButton {
    
    var container: UIView {
        get {
            return _container
        }
    }
    
    var delegate: SWCookingButtonDelegate?
    
    private let _container: UIView
    
    private let _button: UIButton
    
    private let _blueback: UIView
    
    private let _grayback: UIView
    
    init(container: UIView, button: UIButton, blueback: UIView, grayback: UIView) {
        _container = container
        _button = button
        _grayback = grayback
        _blueback = blueback
        _button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
    }
    
    func disable() -> SWDisabledCookingButton {
        let disabled = SWDisabledCookingButton(container: _container, button: _button, blueback: _blueback, grayback: _grayback)
        disabled.delegate = self.delegate
        _container.sendSubview(toBack: _blueback)
//        _button.isEnabled = false
        _button.removeTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        return disabled
    }
    
    @IBAction private func onClick(_ sender: UIButton) {
        delegate?.onCook(self)
    }
    
    
    static func getInitialButton(into view: UIView) -> SWCookingButton {
        
        let rectangle = CGRect(origin: .zero, size: CGSize(side: 48))
        
        let container = UIView(frame: rectangle)
        view.addSubview(container)
        
        let grayback = UIView(frame: container.bounds)
        grayback.backgroundColor = .geyser
        container.addSubview(grayback)
        
        let blueback = UIView(frame: container.bounds)
        blueback.backgroundColor = .azureradiance
        container.addSubview(blueback)
        
        let button = UIButton(frame: container.bounds)
        button.setImage(#imageLiteral(resourceName: "wheelgui/cook_transparent"), for: .normal)
//        button.isEnabled = true
        container.addSubview(button)
        
        container.layer.cornerRadius = 48 * 0.5
        container.clipsToBounds = true
        return SWEnabledCookingButton(container: container, button: button, blueback: blueback, grayback: grayback)
        
    }
}

class SWDisabledCookingButton: SWCookingButton {
    
    var container: UIView {
        get {
            return _container
        }
    }
    
    var delegate: SWCookingButtonDelegate?
    
    private let _container: UIView
    
    private let _button: UIButton
    
    private let _blueback: UIView
    
    private let _grayback: UIView
    
    init(container: UIView, button: UIButton, blueback: UIView, grayback: UIView) {
        _container = container
        _button = button
        _grayback = grayback
        _blueback = blueback
        _button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
    }
    
    func enable() -> SWEnabledCookingButton {
        let enabled = SWEnabledCookingButton(container: _container, button: _button, blueback: _blueback, grayback: _grayback)
        _container.sendSubview(toBack: _grayback)
        enabled.delegate = self.delegate
        _button.removeTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
//        _button.isEnabled = true
        return enabled
    }
    
    @IBAction private func onClick(_ sender: UIButton) {
        delegate?.onCook(self)
    }
    
    static func getInitialButton(into view: UIView) -> SWCookingButton {
        
        let rectangle = CGRect(origin: .zero, size: CGSize(side: 48))
        
        let container = UIView(frame: rectangle)
        view.addSubview(container)
        
        let blueback = UIView(frame: container.bounds)
        blueback.backgroundColor = .azureradiance
        container.addSubview(blueback)
        
        let grayback = UIView(frame: container.bounds)
        grayback.backgroundColor = .geyser
        container.addSubview(grayback)
        
        let button = UIButton(frame: container.bounds)
        button.setImage(#imageLiteral(resourceName: "wheelgui/cook_transparent"), for: .normal)
//        button.isEnabled = false
        container.addSubview(button)
        
        container.layer.cornerRadius = 48 * 0.5
        container.clipsToBounds = true
        return SWDisabledCookingButton(container: container, button: button, blueback: blueback, grayback: grayback)
        
    }
    
}
