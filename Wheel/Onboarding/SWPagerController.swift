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
    
    // MARK: - Public Properties
    
    var view: UIView {
        get {
            return _view
        }
    }
    
    // MARK: - Initialization
    
    init(_ view: UIView) {
        
        _view = view
        
        let radius = SWConfiguration.Pager.diameter * 0.5
        for position in SWConfiguration.Pager.states {
            let dot = UIView()
            dot.layer.cornerRadius = radius
            
            //previous dots
            dot.frame.origin.x +=  radius * CGFloat(position.value) * CGFloat(2)
            //previous spacings
            dot.frame.origin.x += CGFloat(min(0, position.value - 1)) * SWConfiguration.Pager.spacing
            
            dot.frame.size = CGSize(side: radius * 2)
            
            dot.backgroundColor = SWConfiguration.Pager.inactive
            
            _view.addSubview(dot)
        }
        
    }
    
}
