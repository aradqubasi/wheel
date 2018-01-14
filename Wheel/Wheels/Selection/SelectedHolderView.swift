//
//  SelectedHolderView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SelectedHolderView: UIScrollView {

    // MARK: - Overridees
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIButton {
            print("is UIButton ")
            return true
        }

        return super.touchesShouldCancel(in: view)
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        
//    }

}
