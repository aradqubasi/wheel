//
//  SelectedHolderView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SelectedHolderView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is SelectedView {
            return true
        }

        return super.touchesShouldCancel(in: view)
    }

}
