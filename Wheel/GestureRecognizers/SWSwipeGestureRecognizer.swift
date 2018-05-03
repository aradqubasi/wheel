//
//  SWSwipeGestureRecognizer.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 03/05/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

class SWSwipeGestureRecognizer: UIGestureRecognizer {
    
    private var initial: CGPoint = .zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        initial = location(ofTouch: 0, in: view!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        let current = location(ofTouch: 0, in: view!)
        let direction = CGPoint(x: current.x - initial.x, y: current.y - initial.y)
        if direction.x < 0 {
            state = .cancelled
            print("cancelled")
        }
        else if direction.y < 0 {
            state = .cancelled
            print("cancelled")
        }
        else if direction.y / direction.x > tan(CGFloat.pi * 0.25) {
            state = .cancelled
            print("cancelled")
        }
        else {
            print("ok")
        }
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
//        <#code#>
//    }
    
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
//        <#code#>
//    }
}
