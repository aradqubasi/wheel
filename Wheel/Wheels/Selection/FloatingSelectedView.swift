//
//  FloatingSelectedView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 08/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class FloatingSelectedView: UIView, Floatable {
    
    // MARK: - Properties
    
    var state: FloatingSelectedViewStates {
        get {
            return _state
        }
    }
    
    var food: SWIngredient? {
        get {
            return _food
        }
    }
    
    var scene: UIView?
    
    var menu: UIView?
    
    // MARK: - Private Properties
    
    private var _food: SWIngredient?
    
    private var _state: FloatingSelectedViewStates!
    
    private var _destanation: Floatable?
    
    private var _target: Any?
    
    private var _selector: Selector?
    
    // MARK: - Subviews
    
    private var _item: UIButton!
    
    private var _shroud: UIView!
    
    // MARK: - Floatable Protocol Methods
    
    var asIngridient: SWIngredient {
        get {
            return _food!
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _item = UIButton(frame: self.bounds)
        self.addSubview(_item)
        
        _shroud = UIView(frame: self.bounds)
        _shroud.backgroundColor = UIColor.white
        _shroud.alpha = 1
        self.addSubview(_shroud)
        
        discharge()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func addTarget(_ target: Any?, action selector: Selector, for event: UIControlEvents) {
        _target = target
        _selector = selector
        _item.addTarget(self, action: #selector(onClick), for: event)
    }
    
    // MARK: - Private Methods
    
    @IBAction private func onClick() {
        if let target = _target as? NSObjectProtocol, let selector = _selector {
            if target.responds(to: selector) {
                target.perform(selector, with: self)
            }
        }
    }
    
    // MARK: - Methods
    
    /**instant - release floating selected*/
    func discharge() {
        scene?.addSubview(self)
        
        _state = .free
        _food = nil
    
        self.frame.origin = .zero
        
        _item.setImage(nil, for: .normal)
        _item.isUserInteractionEnabled = false
        _item.alpha = 0
        
        _shroud.alpha = 0
    }
    
    /**instant - copy pin*/
    func take(for pin: Floatable) {
        scene!.addSubview(self)
        
        _state = .taken
        _food = pin.asIngridient
        
        frame.origin = pin.convert(.zero, to: scene!)
        print("taking \(frame.origin)")
        
        _item.setImage(pin.asIngridient.image, for: .normal)
        _item.isUserInteractionEnabled = false
        _item.alpha = 1
        
        _shroud.alpha = 0
    }
    
    /**animatable - move to destanation*/
    func deliver(to point: CGPoint) {
        _state = .delivered
        
        frame.origin = point
        
        _item.isUserInteractionEnabled = false
        _item.alpha = 1
        
        _shroud.alpha = 0
    }
    
    func tomenu() {
        _state = .inmenu
        
        _item.isUserInteractionEnabled = true

        menu!.addSubview(self)
        frame.origin = CGPoint(x: 8, y: 16)
    }
    
    func replace(with ingredient: SWIngredient) {
        _state = .inmenu
        _food = ingredient
        
        _item.setImage(ingredient.image, for: .normal)
        _item.isUserInteractionEnabled = true
        _item.alpha = 1
        
        _shroud.alpha = 0
    }
    
    func place(with ingredient: SWIngredient) {
        _state = .inmenu
        _food = ingredient
        
        _item.setImage(ingredient.image, for: .normal)
        _item.isUserInteractionEnabled = true
        _item.alpha = 1
        
        _shroud.alpha = 0
        
        menu!.addSubview(self)
        frame.origin = CGPoint(x: 8, y: 16)
    }
    
}
