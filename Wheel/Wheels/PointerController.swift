//
//  PointerController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class PointerController {
    
    // MARK: - Public properties
    
    var view: UIImageView!
    
    var state: WState {
        get {
            return _state
        }
        set(new) {
            _state = new
            apply(state: new)
        }
    }
    
    var initial: WState {
        get {
            return .bases
        }
    }
    
    // MARK: - Private Properties
    
    private var _state: WState!
    
    private var _offsets: [WState: CGFloat]!
    
    // MARK: - Initializer
    
    init(view: UIImageView, in state: WState) {
        self.view = view
        _state = state
        _offsets = [
            WState.bases: 58,
            WState.fats: 121,
            WState.veggies: 190,
            WState.proteins: 264
        ]
        apply(state: _state)
    }
    
    // MARK: - Private Methods
    
    private func apply(state: WState) {
        guard var y = view.superview?.bounds.height else {
            fatalError("pointer view is not attached to superview")
        }
        y /= 2
        y -= view.frame.height / 2
        guard var x = view.superview?.bounds.width else {
            fatalError("pointer view is not attached to superview")
        }
        guard let offset = _offsets[state] else {
            fatalError("state \(state) is not implemented")
        }
        x -= offset
        x -= view.frame.height / 2
        view.frame.origin = CGPoint(x: x, y: y)
    }
}
