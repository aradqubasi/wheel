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
    
    let _dots: [SWPagerStates : UIView] = [:]
    
    let _view: UIView!
    
    var config: SWConfiguration.Pager {
        get {
            return SWConfiguration.pager
        }
    }
    
    // MARK: - Public Properties
    
    var view: UIView {
        get {
            return _view
        }
    }
    
    // MARK: - Initialization
    
    init(_ view: UIView) {
        
        _view = view
        
        for position in config.states {
            let dot = UIView()
            dot.layer.cornerRadius = config.radius
            
            //previous dots
            dot.frame.origin.x +=  config.radius * CGFloat(position.value) * CGFloat(2)
            //previous spacings
            dot.frame.origin.x += CGFloat(min(0, position.value - 1)) * config.spacing
            
            dot.frame.size = CGSize(side: config.radius * 2)
            
            dot.backgroundColor = config.inactive
            
            _view.addSubview(dot)
        }
        
    }
    
}
