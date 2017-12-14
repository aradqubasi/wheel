//
//  FloatingSelectedView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 08/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class FloatingSelectedView: UIView {
    
    // MARK: - Properties
    
    var state: FloatingSelectedViewStates {
        get {
            return _state
        }
    }
    
    var food: Ingridient? {
        get {
            return _food
        }
    }
    
    // MARK: - Private Properties
    
    private var _food: Ingridient?
    
    private var _state: FloatingSelectedViewStates!
    
    // MARK: - Subviews
    
    private var _item: UIButton!
    
    private var _shroud: UIView!
    
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
    
    // MARK: - Methods
    
    /**instant - release floating selected*/
    func discharge() {
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
        _state = .taken
        _food = pin.asIngridient
        
        frame.origin = pin.convert(.zero, to: self.superview!)
        
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
    
}
