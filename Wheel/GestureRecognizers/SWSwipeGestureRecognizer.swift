//
//  SWSwipeGestureRecognizer-2.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//


import Foundation
import UIKit
import UIKit.UIGestureRecognizerSubclass

class SWSwipeGestureRecognizer: UIGestureRecognizer {
    
    private let path: CGFloat = UIScreen.main.bounds.size.width
    
    private let pathToBegin: CGFloat = 10
    
    private var IsInProgress: Bool = false
    
    private var initial: CGPoint = .zero
    
    var Initial: CGPoint {
        get {
            return initial
        }
    }
    
    private var current: CGPoint = .zero
    
    var Current: CGPoint {
        get {
            return current
        }
    }
    
    var ProgressToRecognize: CGFloat {
        get {
            return 0.5
        }
    }
    
    var Progress: CGFloat {
        get {
            return IsInProgress ? (abs(current.x - initial.x > 0 ? current.x - initial.x : 0) / path) : 0
        }
    }
    
    private var IsTooSmallToCheck: Bool {
        get {
            return abs(initial.x - current.x) < 10 && abs(initial.y - current.y) < 10
        }
    }
    
    private var IsRightDownDirection: Bool {
        get {
            let dy = (current.y - initial.y)
            let dx = (current.x - initial.x)
            return !(dy / dx > tan(CGFloat.pi * 0.33)) && dy > 0 && dx > 0
        }
    }
    
    var Delegate: SWSwipeDelegate?
    
    // MARK: - Overriden Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        initial = location(ofTouch: 0, in: view!)
        IsInProgress = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.current = location(ofTouch: 0, in: view!)
        if IsTooSmallToCheck {
        }
        else if !IsInProgress && !IsRightDownDirection {
            state = .cancelled
            Delegate?.onCancel(self)
        }
        else if !IsInProgress && IsRightDownDirection {
            IsInProgress = true
            state = .changed
            Delegate?.onBegin(self)
        }
        else {
            if Progress < 0 {
                state = .cancelled
                Delegate?.onCancel(self)
            }
            else {
                state = .changed
                Delegate?.onMove(self)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        if state != .cancelled && Progress >= ProgressToRecognize {
            state = .recognized
            Delegate?.onFinish(self, Progress >= ProgressToRecognize)
        }
        else {
            state = .cancelled
            Delegate?.onCancel(self)
        }
    }
}

