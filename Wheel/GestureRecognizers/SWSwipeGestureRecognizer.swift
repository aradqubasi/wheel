//
//  SWSwipeGestureRecognizer.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 03/05/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//
//
//import Foundation
//import UIKit
//import UIKit.UIGestureRecognizerSubclass
//
//class SWSwipeGestureRecognizer: UIGestureRecognizer {
//    
//    private let pathToRecognize: CGFloat = 100
//    
//    private var initial: CGPoint = .zero
//    
//    private var isIdle: Bool = true
//    
//    var Initial: CGPoint {
//        get {
//            return initial
//        }
//    }
//    
//    private var current: CGPoint = .zero
//    
//    var Current: CGPoint {
//        get {
//            return current
//        }
//    }
//    
//    var Progress: CGFloat {
//        get {
//            return abs(current.x - initial.x > 0 ? current.x - initial.x : 0) / pathToRecognize
//        }
//    }
//    
//    var IsIdle: Bool {
//        get {
//            return isIdle
//        }
//    }
//    
//    var Delegate: SWSwipeDelegate?
//    
//    // MARK: - Overriden Methods
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesBegan(touches, with: event)
//        isIdle = false
//        initial = location(ofTouch: 0, in: view!)
//        current = initial
//        Delegate?.onBegin(self)
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
//        //super.touchesMoved(touches, with: event)
//        let current = location(ofTouch: 0, in: view!)
//        if self.initial == self.current {
//            let direction = CGPoint(x: current.x - initial.x, y: current.y - initial.y)
//            if direction.x < 0 {
//                state = .failed
//                Delegate?.onCancel(self)
//                print("SWSwipe cancelled from \(initial) to \(current)")
//            }
//            else if direction.y < 0 {
//                state = .failed
//                Delegate?.onCancel(self)
//                print("SWSwipe cancelled from \(initial) to \(current)")
//            }
//            else if direction.y / direction.x > tan(CGFloat.pi * 0.33) {
//                state = .failed
//                Delegate?.onCancel(self)
//                print("SWSwipe cancelled from \(initial) to \(current) at angle \(atan(direction.y / direction.x) / CGFloat.pi) * pi")
//            }
//            else {
//                print("SWSwipe ok from \(initial) to \(current)")
//                self.current = current
//                if Progress < 0 {
//                    state = .failed
//                    print("SWSwipe cancel")
//                    Delegate?.onCancel(self)
//                }
//                else if Progress < 1 {
//                    Delegate?.onMove(self)
//                }
//                else if Progress >= 1 {
//                    print("SWSwipe finish")
//                    Delegate?.onFinish(self, true)
//                }
//            }
//        }
//        else {
//            self.current = current
//            if Progress < 0 {
//                state = .failed
//                print("SWSwipe cancel")
//                Delegate?.onCancel(self)
//            }
//            else if Progress < 1 {
//                Delegate?.onMove(self)
//            }
//            else if Progress >= 1 {
//                print("SWSwipe finish")
//                Delegate?.onFinish(self, true)
//            }
//        }
//        
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
//        //super.touchesEnded(touches, with: event)
//        if current != initial && state == .possible {
//            print("SWSwipe from \(initial) to \(current)")
//            state = .recognized
//            print("SWSwipe finish")
//            Delegate?.onFinish(self, Progress >= 1)
//        }
//        else {
//            state = .failed
//            print("SWSwipe cancel")
//            Delegate?.onCancel(self)
//            isIdle = true
//        }
//    }
//    
//    // MARK: - Public Methods
//    
//    func forceCompletion() {
//        
//        state = .recognized
//    }
//    
//    func forceCancel() {
//        state = .failed
//    }
//    
//}

