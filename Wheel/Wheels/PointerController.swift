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
    
    private var _positioner: SWWheelPositionCalculator!
    
    private var _origin: CGPoint!
    
    // MARK: - Initializer
    
    init(view: UIImageView, in state: WState, at positioner: SWWheelPositionCalculator, origin: CGPoint) {
        self.view = view
        _state = state
        _offsets = [
            WState.bases: 58,
            WState.fats: 121,
            WState.veggies: 190,
            WState.proteins: 264
        ]
        _positioner = positioner
        _origin = origin
        apply(state: _state)
    }
    
    // MARK: - Private Methods
    
    private func apply(state: WState) {
        guard let new = _positioner.getPointerPositions(from: _origin, toward: .zero)[state] else {
            fatalError("no point position for \(state)")
        }
        
        view.center = new
    }
}
