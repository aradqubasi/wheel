//
//  SWWheelViewAbstracted.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWWheelViewAbstracted: SWAbstractWheelView {
    
    // MARK: - Private Properties
    
    private var _wheel: SWWheelView!
    
    // MARK: - Initialization
    
    init(parent wheel: SWWheelView) {
        _wheel = wheel
    }
    
    // MARK: - SWAbstractWheelView Fields & Properties
    
    var center: CGPoint {
        get {
            return _wheel.center
        }
    }
    
    var index: Int {
        get {
            return _wheel.index
        }
    }
    
    var count: Int {
        get {
            return _wheel.count
        }
    }
    
    var delegate: SWAbstractWheelDelegate?
    
    var name: String {
        get {
            return _wheel.name
        }
        set(new) {
            _wheel.name = new
        }
    }
    
    func move(to index: Int) {
        _wheel.move(to: index)
    }
    
    func move(by angle: CGFloat) {
        _wheel.move(by: angle)
    }
    
    func flush(with settings: WSettings?) {
        _wheel.flush(with: settings)
    }
    
}
