//
//  SelectedController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 26/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SelectedController {
    
    // MARK: - Public Properties
    
    var view: UIView {
        get {
            guard let menu = _view else {
                fatalError("no selected view available")
            }
            return menu
        }
        set(new) {
            _view = new
            
            let reattach = { (next: UIView) -> Void in
                if next.superview != nil {
                    next.removeFromSuperview()
                }
                new.addSubview(next)
            }
            
            let subviews: [UIView] = [base, protein, veggy1, veggy2, veggy3, fat1, fat2, flavor1, flavor2, cook]

            subviews.forEach(reattach)
            
            show()
        }
    }
    
    // MARK: - Private Properties
    
    private var _view: UIView?
    
    private var _base: Ingridient?
    
    private var _protein: Ingridient?
    
    private var _veggy1: Ingridient?
    
    private var _veggy2: Ingridient?
    
    private var _veggy3: Ingridient?
    
    private var _fat1: Ingridient?
    
    private var _fat2: Ingridient?
    
    private var _flavor1: Ingridient?
    
    private var _flavor2: Ingridient?
    
    private var models: [Ingridient?] {
        get {
            return [ _base, _protein, _veggy1, _veggy2, _veggy3, _fat1, _fat2, _flavor1, _flavor2 ]
        }
    }
    
    // MARK: - Subviews
    
    private var cook: UIButton!
    
    private var base: UIImageView!
    
    private var protein: UIImageView!
    
    private var veggy1: UIImageView!
    
    private var veggy2: UIImageView!
    
    private var veggy3: UIImageView!

    private var fat1: UIImageView!
    
    private var fat2: UIImageView!
    
    private var flavor1: UIImageView!
    
    private var flavor2: UIImageView!
    
    private var views: [UIImageView] {
        get {
            return [ base, protein, veggy1, veggy2, veggy3, fat1, fat2, flavor1, flavor2 ]
        }
    }
    
    // MARK: - Initializers
    
    init() {
        base = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        protein = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        veggy1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        veggy2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        veggy3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        fat1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        fat2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        flavor1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        flavor2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        cook = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        cook.setImage(UIImage.nextpressed, for: .normal)
    }
    
    // MARK: - Public Methods
    
    func add(_ ingridients: [Ingridient]) {
        
        _base = nil
        _protein = nil
        _veggy1 = nil
        _veggy2 = nil
        _veggy3 = nil
        _fat1 = nil
        _fat2 = nil
        _flavor1 = nil
        _flavor2 = nil
        
        for ingridient in ingridients {
            switch (ingridient.kind) {
            case .base:
                if _base == nil {
                    _base = ingridient
                }
            case .fat:
                if _fat1 == nil {
                    _fat1 = ingridient
                }
                else if _fat2 == nil {
                    _fat2 = ingridient
                }
            case .veggy:
                if _veggy1 == nil {
                    _veggy1 = ingridient
                }
                else if _veggy2 == nil {
                    _veggy2 = ingridient
                }
                else if _veggy3 == nil {
                    _veggy3 = ingridient
                }
            case .protein:
                if _protein == nil {
                    _protein = ingridient
                }
            case .dressing:
                if _flavor1 == nil {
                    _flavor1 = ingridient
                }
                else if _flavor2 == nil {
                    _flavor2 = ingridient
                }
            case .unexpected:
                if _flavor1 == nil {
                    _flavor1 = ingridient
                }
                else if _flavor2 == nil {
                    _flavor2 = ingridient
                }
            case .fruits:
                if _flavor1 == nil {
                    _flavor1 = ingridient
                }
                else if _flavor2 == nil {
                    _flavor2 = ingridient
                }
            }
        }
        
        show()
        
    }
    
    // MARK: - Private Methods
    
    private func show() {
        var offset: CGFloat = 8
        let y: CGFloat = 16
        
        if let _base = self._base {
            base.image = _base.image
            base.frame.origin = CGPoint(x: offset, y: y)
//            base.frame.size = CGSize(width: 64, height: 64)
            offset += 64
        }
        
        if let _protein = self._protein {
            protein.image = _protein.image
            protein.frame.origin = CGPoint(x: offset, y: y)
//            protein.frame.size = CGSize(width: 64, height: 64)
            offset += 64
        }
        
        if let _veggy1 = self._veggy1 {
            veggy1.image = _veggy1.image
            veggy1.frame.origin = CGPoint(x: offset, y: y)
//            veggy1.frame.size = CGSize(width: 64, height: 64)
            offset += 64
        }
        
        if let _veggy2 = self._veggy2 {
            veggy2.image = _veggy2.image
            veggy2.frame.origin = CGPoint(x: offset, y: y)
//            veggy2.frame.size = CGSize(width: 64, height: 64)
            offset += 64
        }
        
        if let _veggy3 = self._veggy3 {
            veggy3.image = _veggy3.image
            veggy3.frame.origin = CGPoint(x: offset, y: y)
//            veggy3.frame.size = CGSize(width: 64, height: 64)
            offset += 64
        }
        
        if let _fat1 = self._fat1 {
            fat1.image = _fat1.image
            fat1.frame.origin = CGPoint(x: offset, y: y)
//            fat1.frame.size = CGSize(width: 64, height: 64)
            offset += 64
        }
        
        if let _fat2 = self._fat2 {
            fat2.image = _fat2.image
            fat2.frame.origin = CGPoint(x: offset, y: y)
//            fat2.frame.size = CGSize(width: 64, height: 64)
            offset += 64
        }
        
        if let _flavor1 = self._flavor1 {
            flavor1.image = _flavor1.image
            flavor1.frame.origin = CGPoint(x: offset, y: y)
//            flavor1.frame.size = CGSize(width: 64, height: 64)
            offset += 64
        }
        
        if let _flavor2 = self._flavor2 {
            flavor2.image = _flavor2.image
            flavor2.frame.origin = CGPoint(x: offset, y: y)
//            flavor2.frame.size = CGSize(width: 64, height: 64)
            offset += 64
        }
        
        cook.frame.origin = CGPoint(x: view.frame.width - 8 - 64, y: y)
    }
    
}
