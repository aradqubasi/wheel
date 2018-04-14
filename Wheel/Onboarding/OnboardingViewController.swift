//
//  OnboardingViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var assembler: SWOnboardingAssembler!
    
    // MARK: - Outlets
    
    @IBOutlet weak var pager: UIView!

    // MARK: - Private Properties
    
    private var pagerController: SWPagerController!
    
    private var _state: SWPagerStates!

    private var _bowlController: SWBowlSceneController!
    
    private var _skip: UIButton!
    
    private var _segues: SWSegueRepository!
    
    // MARK: - Initalization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initial: SWPagerStates = .obey
        _state = initial

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
        
        _segues = assembler.resolve()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction private func onSkip(_ sender: UIButton) {
        performSegue(withIdentifier: _segues.getOnboardingToWheels().identifier, sender: self)
    }
    
    @IBAction private func onProceed(_ sender: UIButton) {
        performSegue(withIdentifier: _segues.getOnboardingToWheels().identifier, sender: self)
    }
    
    @IBAction private func onSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        switch sender.state {
        case .ended:
            if (_state != SWPagerStates.proceed) {
                next()
            }
        default:
            print("\(sender.state)")
        }
    }
    
    @IBAction private func onSwipeRight(_ sender: UISwipeGestureRecognizer) {
        switch sender.state {
        case .ended:
            if (_state != SWPagerStates.inital) {
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
        }
        let toBeforeTime: TimeInterval = 0.35
        UIView.animate(withDuration: toBeforeTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.preferredFramesPerSecond60], animations: toBefore, completion: finalize)
    }
    
    private func next() {
        _bowlController.play(to: _state.next(), at: .before)
        let toInbetween = { () -> Void in
            self._bowlController.play(to: self._state.next(), at: .inbetween)
            self.pagerController.state = self._state
        }
        let toInbetweenTime: TimeInterval = 0.5
        UIView.animate(withDuration: toInbetweenTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.preferredFramesPerSecond60], animations: toInbetween, completion: nil)
        let toAfter = { () -> Void in
            self._bowlController.play(to: self._state.next(), at: .after)
        }
        let finalize = { (finished: Bool) -> Void in
            self._state = finished ? self._state.next() : self._state
//            self.pagerController.state = self._state
        }
        let toAfterTime: TimeInterval = 0.5
        UIView.animate(withDuration: toAfterTime, delay: toInbetweenTime, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.preferredFramesPerSecond60], animations: toAfter, completion: finalize)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigator = segue.destination as? UINavigationController, let wheels = navigator.topViewController as? WheelsViewController {
            let wheelsAssembler: SWWheelsAssembler = assembler.resolve()
            wheels.assembler = wheelsAssembler
        }
        else {
            fatalError("Segues does not directed to Wheels View Controller")
        }
    }
 

}
