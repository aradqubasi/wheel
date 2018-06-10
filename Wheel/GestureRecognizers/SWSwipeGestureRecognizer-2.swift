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
    
    private let pathToRecognize: CGFloat = 100
    
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
    
    var Progress: CGFloat {
        get {
            return IsInProgress ? (abs(current.x - initial.x > 0 ? current.x - initial.x : 0) / pathToRecognize) : 0
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
//        current = initial
//        Delegate?.onBegin(self)
//        state = .began
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        self.current = location(ofTouch: 0, in: view!)
        if IsTooSmallToCheck {
            print("IsTooSmallToCheck")
//            state = .changed
        }
        else if !IsInProgress && !IsRightDownDirection {
            print("!IsInProgress && !IsRightDownDirection")
            state = .cancelled
            Delegate?.onCancel(self)
        }
        else if !IsInProgress && IsRightDownDirection {
            print("!IsInProgress && IsRightDownDirection")
            IsInProgress = true
            state = .changed
            Delegate?.onBegin(self)
        }
        else {
            print("!IsTooSmallToCheck && IsInProgress")
            if Progress < 0 {
                state = .cancelled
                print("SWSwipe cancel")
                Delegate?.onCancel(self)
            }
            else if Progress < 1 {
                state = .changed
                Delegate?.onMove(self)
            }
            else if Progress >= 1 {
                print("SWSwipe finish")
                state = .changed
                Delegate?.onFinish(self, true)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        //super.touchesEnded(touches, with: event)
        if IsInProgress && state == .possible {
            print("SWSwipe from \(initial) to \(current)")
            state = .recognized
            print("SWSwipe finish")
            Delegate?.onFinish(self, Progress >= 1)
        }
        else {
            state = .cancelled
            print("SWSwipe cancel")
            Delegate?.onCancel(self)
        }
    }
}

