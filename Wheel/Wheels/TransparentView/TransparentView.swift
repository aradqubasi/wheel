//
//  TransparentView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class TransparentView: UIView {

    var delegate: SWTransparentViewDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        delegate?.onClickThrough(at: self)
//    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, with: event)
        
        if hitView == self {
            delegate?.onClickThrough(at: self)
            return nil
        } else {
            if hitView != nil {
                delegate?.onClickThrough(at: self)
            }
            return hitView
        }
        
    }
}
