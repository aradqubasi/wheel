//
//  OnboardingViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var pager: UIView!

    // MARK: - Private Properties
    
    private var pagerController: SWPagerController!
    
//    private var _slidersController: SWSlidersController!
    
    private var _state: SWPagerStates!
    
    private var _slider: UIPanGestureRecognizer!
    
    private var _bowlController: SWBowlSceneController!
    
    private var _skip: UIButton!
    
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
            //-176 109 600 of 736
        }
        
        //setup gesture capture
        do {
            _slider = UIPanGestureRecognizer(target: self, action: #selector(onSlide(_:)))
            view.addGestureRecognizer(_slider)
        }
        
        //setup controllers
        do {
            pagerController = SWPagerController(pager)
//            _slidersController = SWSlidersController(view, in: _state)
            _bowlController = SWBowlSceneController(view, in: _state)
        }
        
        //setup skip button
        do {
            let offset = SWConfiguration.Skip.offset
            let center = CGPoint(x: view.bounds.width * 0.5, y: view.bounds.height * 0.5)
            _skip = UIButton(frame: CGRect(origin: .zero, size: SWConfiguration.Skip.size))
            _skip.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
            _skip.setAttributedTitle(SWConfiguration.Skip.text, for: .normal)
            _skip.addTarget(self, action: #selector(onSkip(_:)), for: .touchUpInside)
            view.addSubview(_skip)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction private func onNext(_ sender: UIButton) {
//        _slidersController.prepare(for: _state.next())
//        let transition = { () -> Void in self._slidersController.transition() }
//        UIView.animate(withDuration: 0.225, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: transition, completion: nil)
    }
    
    @IBAction private func onPrev(_ sender: UIButton) {
//        _slidersController.prepare(for: _state.prev())
//        let transition = { () -> Void in self._slidersController.transition() }
//        UIView.animate(withDuration: 0.225, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: transition, completion: nil)
    }
    
    @IBAction private func onSkip(_ sender: UIButton) {
        performSegue(withIdentifier: SWConfiguration.Segues.onboardingToWheels, sender: self)
    }
    
    private var _last: Date!
    
    @IBAction private func onSlide(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            _last = Date()
        case .changed:
            let delta = Date().timeIntervalSince(_last)
            _last = Date()
            let path = sender.translation(in: view).x
//            if _slidersController.test(path) {
//                let path = sender.translation(in: view).x
//                transition(to: path < 0 ? _state.next() : _state.prev())
//                _slider.isEnabled = false
//                _slider.isEnabled = true
//            }
//            else {
//                let move = { () -> Void in self._slidersController.move(to: path) }
//                UIView.animate(withDuration: delta, animations: move)
//            }
        case .ended:
            let path = sender.translation(in: view).x
            transition(to: path < 0 ? _state.next() : _state.prev())
        default:
            print("\(sender.state)")
        }
    }
    
    // MARK: - Private Methods
    
    private func transition(to state: SWPagerStates) {
//        _slidersController.prepare(for: state)
        let transition = { () -> Void in
//            self._slidersController.transition()
            self._bowlController.play(to: state, at: .inbetween)
        }
        let sync = { (_: Bool) -> Void in
            self._state = state
            self.pagerController.state = state
        }
        UIView.animate(withDuration: 0.225, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: transition, completion: sync)
        
        _bowlController.play(to: state, at: .before)
        let toInbetween = { () -> Void in
             self._bowlController.play(to: state, at: .inbetween)
        }
        let toInbetweenTime: TimeInterval = 0.35
//        let toInbetweenTime: TimeInterval = 5
//        UIView.animate(withDuration: toInbetweenTime, delay: 0, options: [.curveEaseInOut], animations: toInbetween, completion: nil)
        UIView.animate(withDuration: toInbetweenTime, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.preferredFramesPerSecond60], animations: toInbetween, completion: nil)
        let toAfter = { () -> Void in
            self._bowlController.play(to: state, at: .after)
        }
        let toAfterTime: TimeInterval = 0.35
//        let toAfterTime: TimeInterval = 5
//        UIView.animate(withDuration: toAfterTime, delay: toInbetweenTime, options: [.curveEaseInOut], animations: toAfter, completion: nil)
        UIView.animate(withDuration: toAfterTime, delay: toInbetweenTime, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.preferredFramesPerSecond60], animations: toAfter, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
