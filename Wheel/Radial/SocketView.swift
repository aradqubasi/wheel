//
//  SocketView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SocketView: UIView {

    // MARK: - Overrided Methods
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, with: event)
        
        if hitView == self {
            return nil
        } else {
            return hitView
        }
    }
    
}
