//
//  StaticSelectedView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class StaticSelectedView: UIView, Floatable {
    
    // MARK: - Properties
    
    var state: StaticSelectedViewStates {
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
    
    private var _target: Any?
    
    private var _selector: Selector?
    
    private var _food: Ingridient?
    
    private var _state: StaticSelectedViewStates!
    
    // MARK: - Subviews
    
//    private var _size: CGSize!
    
    private var _item: UIButton!
    
    private var _shroud: UIView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _item = UIButton(frame: self.bounds)
        self.addSubview(_item)
        
        _shroud = UIView(frame: self.bounds)
        _shroud.backgroundColor = UIColor.white
        self.addSubview(_shroud)
        
        close()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Floatable Implementation
    
    var asIngridient: Ingridient {
        get {
            guard let ingridient = food else {
                fatalError("StaticSelectedView does not have attached ingridient")
            }
            return ingridient
        }
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
    
    // MARK: - Animation Methods
    
    /**animatable - hide picture and move to head*/
    func close() {
        _state = .closed
        _food = nil
        
        _item.isUserInteractionEnabled = false
        
        _shroud.alpha = 1
    }

    /**animatable - open blank spot at the point @ holder coordinate system*/
    func open(for food: Ingridient) {
        _state = .opened
        
        _food = food
        _item.setImage(nil, for: .normal)
        _item.isUserInteractionEnabled = false
        
        _shroud.alpha = 1
    }
//    func open(to point: CGPoint) {
//        _state = .opened
//        _food = nil
//
//        frame.origin = point
//
//        _item.setImage(nil, for: .normal)
//        _item.isUserInteractionEnabled = false
//
//        _shroud.alpha = 1
//    }

    /**instant - fill spot with image*/
    func fill() {
        _state = .full
        
        _item.setImage(_food!.image, for: .normal)
        _item.isUserInteractionEnabled = true
        
        _shroud.alpha = 0
    }
//    func fill(with food: Ingridient) {
//        _state = .full
//        _food = food
//
//        _item.setImage(food.image, for: .normal)
//        _item.isUserInteractionEnabled = true
//
//        _shroud.alpha = 0
//    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//
//        let hitView = super.hitTest(point, with: event)
//
//        if hitView == self {
//            return nil
//        }
//        else if hitView == _item {
//            return hitView
//        }
//        else if hitView == _shroud {
//            return hitView
//        }
//        else {
//            return hitView
//        }
//
//    }
    
}
