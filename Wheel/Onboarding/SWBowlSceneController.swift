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
    
    private var _actors: [SWBowlSceneView]
    
    private var _state: SWPagerStates
    
    // MARK: - Public Properties
    
    var state: SWPagerStates {
        get {
            return _state
        }
    }
    
    // MARK: - Initialization
    
    init(_ scene: UIView, in initial: SWPagerStates) {
        _state = initial
        
        _scene = scene
        
        _actors = [
            SWBowlSceneView.obeyTitle,
            SWBowlSceneView.leafsTitle,
            SWBowlSceneView.leafsSubtitle,
            SWBowlSceneView.proteinsTitle,
            SWBowlSceneView.proteinsSubtitle,
            SWBowlSceneView.veggiesTitle,
            SWBowlSceneView.veggiesSubtitle,
            SWBowlSceneView.onboardingHeader,
            SWBowlSceneView.backbowl,
            SWBowlSceneView.avocado1,
            SWBowlSceneView.spoon,
            SWBowlSceneView.olive1,
            SWBowlSceneView.olive2,
            SWBowlSceneView.olive3,
            SWBowlSceneView.pepper1,
            SWBowlSceneView.pepperony,
            SWBowlSceneView.cashew2,
            SWBowlSceneView.backleaf1,
            SWBowlSceneView.backleaf2,
            SWBowlSceneView.backleaf3,
            SWBowlSceneView.backleaf4,
            SWBowlSceneView.frontleaf1,
            SWBowlSceneView.frontleaf2,
            SWBowlSceneView.frontleaf3,
            SWBowlSceneView.frontleaf4,
//            SWBowlSceneView.frontleaf5,
            SWBowlSceneView.brocolli1,
            SWBowlSceneView.brocolli2,
            SWBowlSceneView.cucumber,
            SWBowlSceneView.egg1,
            SWBowlSceneView.egg2,
//            SWBowlSceneView.protoleaf,
            SWBowlSceneView.mushroom1,
            SWBowlSceneView.mushroom2,
            SWBowlSceneView.cashew1,
            SWBowlSceneView.frontbowl
        ]
        _actors.forEach({ _scene.addSubview($0.image) })
        play(to: _state, at: .before)
    }
    
    // MARK: - Public Methods
    
    func play(to state: SWPagerStates, at step: SWBowlActSteps) {
        _actors.forEach({ $0.play(to: state, at: step) })
    }
    
}
