//
//  SWSlidersController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWSlidersController {
    
    // MARK: - Private Properties
    
    private var _view: UIView!
    
    private var _state: SWPagerStates!
    
    private var _slides: [SWPagerStates: UIView]!
    
    private var _next: SWPagerStates!
    
    private var _forward: Bool!
    
    // MARK: - Public  Properties
    
    var state: SWPagerStates {
        get {
            return _state
        }
    }
    
    // MARK: - Initialization
    
    init(_ view: UIView) {
        _view = view
        
        _slides = [:]
        _slides[.obey] = SWObeySlideView(frame: view.bounds)
        _slides[.leafs] = SWLeafsSlideView(frame: view.bounds)
        _slides[.proteins] = SWProteinsSlideView(frame: view.bounds)
        _slides[.veggies] = SWVeggiesSlideView(frame: view.bounds)
        _slides[.fats] = SWFatsSlideView(frame: view.bounds)
        _slides[.ehancers] = SWEnhancersSlideView(frame: view.bounds)
        
        _state = SWConfiguration.SWSlidersController.initial
        
        _slides.forEach({
            $0.value.frame.origin = CGPoint(x: _view.bounds.width, y: 0)
            _view.addSubview($0.value)
        })
        guard let current = _slides[_state] else {
            fatalError("no slide for \(_state)")
        }
        current.frame.origin = .zero
    }
    
    // MARK: - Public properties
    
    /**instant - set frames for animation*/
    func prepare(_ forward: Bool) {
        let transitions = SWConfiguration.SWSlidersController.transitions
        guard let next: SWPagerStates = forward ? transitions.first(where: { return $0.key == state })?.value : transitions.first(where: { return $0.value == state })?.key else {
            fatalError("no transition from \(state) moving forward \(forward)")
        }
        guard let slide = _slides[next] else {
            fatalError("slide for next state \(state) is not available")
        }
        slide.frame.origin = CGPoint(x: forward ? _view.bounds.width : -_view.bounds.width, y: 0)
        _next = next
        _forward = forward
    }
    
    /**check whether coming move would went through theshold*/
    func test(_ path: CGFloat) -> Bool {
        let threshhold = SWConfiguration.SWSlidersController.threshold * _view.bounds.width
        return abs(path) >= threshhold
    }
    
    /**animatable - move slide by specified amount, until transigtion treshhold is reached*/
    func move(to path: CGFloat) {
        guard let current = _slides[state] else {
            fatalError("no slide for \(state)")
        }
        current.frame.origin.x = path
    }
    
    /**animatable - transition into next state*/
    func transition() {
        guard let new = _slides[_next] else {
            fatalError("no slide for \(_next)")
        }
        guard let old = _slides[state] else {
            fatalError("no slide for \(state)")
        }
        new.frame.origin = .zero
        old.frame.origin = CGPoint(x: _forward ? -_view.bounds.width : _view.bounds.width, y: 0)
        _state = _next
    }
    
}
