//
//  PagerController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWPagerController {
    
    // MARK: - Private Properties
    
    var _dots: [SWPagerStates : UIView] = [:]
    
    let _view: UIView!
    
    var _state: SWPagerStates!
    
    // MARK: - Public Properties
    
    var view: UIView {
        get {
            return _view
        }
    }
    
    var state: SWPagerStates {
        get {
            return _state
        }
        set (new) {
            _state = new
            if (new != .proceed) {
                _dots.forEach({$0.value.alpha = 1})
                _dots.forEach({$0.value.backgroundColor = $0.key == new ? SWConfiguration.Pager.active : SWConfiguration.Pager.inactive})
            }
            else {
                _dots.forEach({$0.value.alpha = 0})
            }
        }
    }
    
    // MARK: - Initialization
    
    init(_ view: UIView) {
        
        _view = view
        
        _view.backgroundColor = UIColor.clear
        
        let radius = SWConfiguration.Pager.diameter * 0.5
        
        for position in SWConfiguration.Pager.states {
            let dot = UIView()
            
            dot.layer.cornerRadius = radius
            dot.frame.origin.x +=  radius * CGFloat(position.value) * CGFloat(2)
            dot.frame.origin.x += CGFloat(position.value) * SWConfiguration.Pager.spacing
            dot.frame.size = CGSize(side: radius * 2)
            
            _view.addSubview(dot)
            
            _dots[position.key] = dot
        }
        
        state = SWConfiguration.Pager.inital
    }
    
}
