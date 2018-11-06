//
//  SWDismissRecipyGestureRecognizer.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWDismissRecipyGestureRecognizer: UIGestureRecognizer {
    
    private let path: CGFloat = UIScreen.main.bounds.size.width
    
    private let pathToBegin: CGFloat = 10
    
    private var initial: CGPoint = .zero
    
    private var current: CGPoint = .zero
    
    private var progressToRecognize: CGFloat = 0.5
    
    var Progress: CGFloat {
        get {
            return (current.x - initial.x) / path
        }
    }
    
    private var IsTooSmallToCheck: Bool {
        get {
            return abs(initial.x - current.x) < 10 && abs(initial.y - current.y) < 10
        }
    }
    
    private var IsRightDownDirection: Bool {
        let dy = (current.y - initial.y)
        let dx = (current.x - initial.x)
        return !(dy / dx > tan(CGFloat.pi * 0.33)) && dy > 0 && dx > 0
    }
    
    // MARK: - Overriden Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        initial = location(ofTouch: 0, in: view!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.current = location(ofTouch: 0, in: view!)
        if (state == .possible && !IsTooSmallToCheck) {
            if IsRightDownDirection {
                state = .began
            }
            else {
                state = .failed
            }
        }
        else if state == .began || state == .changed {
            if !IsRightDownDirection {
                state = .cancelled
            }
            else if Progress < 0 {
                state = .cancelled
            }
            else if Progress < progressToRecognize {
                state = .changed
            }
            else {
                state = .ended
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        if state != .cancelled && Progress >= progressToRecognize {
            state = .ended
        }
        else {
            state = .cancelled
        }
    }
    
}
