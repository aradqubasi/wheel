//
//  SWSwipeInteractiveTransition.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/05/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWSwipeInteractiveTransition: UIPercentDrivenInteractiveTransition, SWSwipeDelegate {
    
    // MARK: - Private Properties
    
    var begin: () -> Void
    
    // MARK: - Initialization
    
    init(_ action: @escaping () -> Void) {
        begin = action
        super.init()
    }
    
    // MARK: - SWSwipeDelegate Methods
    
    func onBegin(_ sender: SWSwipeGestureRecognizer) {
        begin()
    }
    
    func onMove(_ sender: SWSwipeGestureRecognizer) {
        update(sender.Progress)
    }
    
    func onFinish(_ sender: SWSwipeGestureRecognizer, _ success: Bool) {
        if success {
            finish()
        }
        else {
            cancel()
        }
    }
    
    func onCancel(_ sender: SWSwipeGestureRecognizer) {
        cancel()
    }
        
}
