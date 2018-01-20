//
//  SWBowlController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 19/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWBowlSceneController {
    
    // MARK: - Private Properties
    
    private var _scene: UIView!
    
    private var _actors: [SWBowlSceneImage]
    
    private var _state: SWPagerStates
    
    // MARK: - Public Properties
    
    var state: SWPagerStates {
        get {
            return _state
        }
        set (new) {
            _state = new
            _actors.forEach({ $0.state = _state })
        }
    }
    
    // MARK: - Initialization
    
    init(_ scene: UIView, in initial: SWPagerStates) {
        _state = initial
        
        _scene = scene
        
        _actors = [SWBowlSceneImage.frontbowl]
        _actors.forEach({
            _scene.addSubview($0.image)
            $0.state = _state
        })
    }
    
}