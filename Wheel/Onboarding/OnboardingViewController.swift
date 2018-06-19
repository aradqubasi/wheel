//
//  OnboardingViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class OnboardingViewController: SWViewController {
    
    // MARK: - Public Properties
    
    var assembler: SWOnboardingAssembler!
    
    // MARK: - Outlets
    
    @IBOutlet weak var pager: UIView!

    // MARK: - Private Properties
    
    private var pagerController: SWPagerController!
    
    private var _state: SWPagerStates!

    private var _bowlController: SWBowlSceneController!
    
    private var _skip: UIButton!
        
    private var _transitioning: Bool!
    
    private var _timelines: SWBowlTimelineRepository!
    
    // MARK: - Initalization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _timelines = assembler.resolve()
        
        let initial: SWPagerStates = .obey
        _state = initial
        
        _transitioning = false

        //setup gradient on background
        do {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.tanhide.cgColor, UIColor.radicalred.cgColor]
            gradient.frame = view.bounds
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
            gradient.locations = [-0.23, 0.15, 0.82]
            view.layer.insertSublayer(gradient, at: 0)
        }
        
        //setup gesture capture
        do {
            let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeLeft(_:)))
            leftSwipeRecognizer.direction = .left
            leftSwipeRecognizer.numberOfTouchesRequired = 1
            view.addGestureRecognizer(leftSwipeRecognizer)
            
            let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeRight(_:)))
            rightSwipeRecognizer.direction = .right
            rightSwipeRecognizer.numberOfTouchesRequired = 1
            view.addGestureRecognizer(rightSwipeRecognizer)
        }
        
        //setup controllers
        do {
            pagerController = SWPagerController(pager)
            _bowlController = SWBowlSceneController(view, in: _state)
        }
        
        //setup buttons
        do {
            let skip = SWBowlSceneView.skip
            (skip.image as! UIButton).addTarget(self, action: #selector(onSkip(_:)), for: .touchUpInside)
            _bowlController.actors.append(skip)
            
            let proceed = SWBowlSceneView.proceed
            (proceed.image as! UIButton).addTarget(self, action: #selector(onProceed(_:)), for: .touchUpInside)
            _bowlController.actors.append(proceed)
        }
        
        segues = assembler.resolve()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction private func onSkip(_ sender: UIButton) {
        perform(segue: segues.getOnboardingToWheels())
    }
    
    @IBAction private func onProceed(_ sender: UIButton) {
        perform(segue: segues.getOnboardingToWheels())
    }
    
    @IBAction private func onSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        switch sender.state {
        case .ended:
            if (_state != SWPagerStates.proceed && !_transitioning) {
                _transitioning = true
                next()
            }
        default:
            print("\(sender.state)")
        }
    }
    
    @IBAction private func onSwipeRight(_ sender: UISwipeGestureRecognizer) {
        switch sender.state {
        case .ended:
            if (_state != SWPagerStates.inital && !_transitioning) {
                _transitioning = true
                prev()
            }
        default:
            print("\(sender.state)")
        }
    }
    
    // MARK: - Private Methods

    /**animatable - move backward*/
    private func prev() {
        _bowlController.play(to: _state, at: .after)
        let toBefore = { () -> Void in
            self._bowlController.play(to: self._state.prev(), at: .after)
        }
        let finalize = { (finished: Bool) -> Void in
            self._state = finished ? self._state.prev() : self._state
            self.pagerController.state = self._state
            self._transitioning = false
        }
        let toBeforeTime: TimeInterval = _timelines.get(by: _state.next()).toBack
        UIView.animate(withDuration: toBeforeTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.preferredFramesPerSecond60], animations: toBefore, completion: finalize)
    }
    
    private func next() {
        _bowlController.play(to: _state.next(), at: .before)
        let toInbetween = { () -> Void in
            self._bowlController.play(to: self._state.next(), at: .inbetween)
            self.pagerController.state = self._state.next()
        }
        let toInbetweenTime: TimeInterval = _timelines.get(by: _state.next()).toInbetween
        UIView.animate(withDuration: toInbetweenTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.preferredFramesPerSecond60], animations: toInbetween, completion: nil)
        let toAfter = { () -> Void in
            self._bowlController.play(to: self._state.next(), at: .after)
        }
        let finalize = { (finished: Bool) -> Void in
            self._state = finished ? self._state.next() : self._state
//            self.pagerController.state = self._state
            self._transitioning = false
        }
        let toAfterTime: TimeInterval = _timelines.get(by: _state.next()).toAfter
        UIView.animate(withDuration: toAfterTime, delay: toInbetweenTime, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.preferredFramesPerSecond60], animations: toAfter, completion: finalize)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigator = segue.destination as? SWNavigationController, let wheels = navigator.topViewController as? WheelsViewController {
            let wheelsAssembler: SWWheelsAssembler = assembler.resolve()
            wheels.assembler = wheelsAssembler
            let navigationAssembler: SWNavigationAssembler = assembler.resolve()
            navigator.assembler = navigationAssembler
        }
        else {
            fatalError("Segues does not directed to Wheels View Controller")
        }
    }
 

}
