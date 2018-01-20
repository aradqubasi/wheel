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
    
    @IBOutlet weak var skip: UIButton!
    
    @IBOutlet weak var pager: UIView!
    
//    var obey: UIView!
//    var leafs: UIView!
//    var proteins: UIView!
//    var veggies: UIView!
//    var fats: UIView!
//    var enhancers: UIView!
    
    // MARK: - Public Properties
    
//    var state: SWPagerStates {
//        get {
//            return _state
//        }
//        set (new) {
//            _state = new
//            pagerController.state = new
//            _bowlController.state = new
//        }
//    }

    // MARK: - Private Properties
    
    private var pagerController: SWPagerController!
    
    private var _slidersController: SWSlidersController!
    
    private var _state: SWPagerStates!
    
    private var _slider: UIPanGestureRecognizer!
    
    private var _bowlController: SWBowlSceneController!
    
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
            _slidersController = SWSlidersController(view, in: _state)
            _bowlController = SWBowlSceneController(view, in: _state)
        }
        
        //setup test buttons
        do {
//            let prev = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 16), size: CGSize(width: 32, height: 32)))
//            prev.setTitle("<", for: .normal)
//            prev.addTarget(self, action: #selector(onPrev(_:)), for: .touchUpInside)
//            view.addSubview(prev)
//
//            let next = UIButton(frame: CGRect(origin: CGPoint(x: view.bounds.width - 32, y: 16), size: CGSize(width: 32, height: 32)))
//            next.setTitle(">", for: .normal)
//            next.addTarget(self, action: #selector(onNext(_:)), for: .touchUpInside)
//            view.addSubview(next)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction private func onNext(_ sender: UIButton) {
        _slidersController.prepare(for: _state.next())
        let transition = { () -> Void in self._slidersController.transition() }
        UIView.animate(withDuration: 0.225, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: transition, completion: nil)
    }
    
    @IBAction private func onPrev(_ sender: UIButton) {
        _slidersController.prepare(for: _state.prev())
        let transition = { () -> Void in self._slidersController.transition() }
        UIView.animate(withDuration: 0.225, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: transition, completion: nil)
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
            if _slidersController.test(path) {
                let path = sender.translation(in: view).x
                transition(to: path < 0 ? _state.next() : _state.prev())
//                _slidersController.prepare(path < 0)
//                let transition = { () -> Void in self._slidersController.transition() }
//                let sync = { (_: Bool) -> Void in self.pagerController.state = self._slidersController.state }
//                UIView.animate(withDuration: 0.225, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: transition, completion: sync)
                _slider.isEnabled = false
                _slider.isEnabled = true
            }
            else {
                let move = { () -> Void in self._slidersController.move(to: path) }
                UIView.animate(withDuration: delta, animations: move)
            }
        case .ended:
            let path = sender.translation(in: view).x
            transition(to: path < 0 ? _state.next() : _state.prev())
//            _slidersController.prepare(path < 0)
//            let transition = { () -> Void in self._slidersController.transition() }
//            let sync = { (_: Bool) -> Void in self.pagerController.state = self._slidersController.state }
//            UIView.animate(withDuration: 0.225, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: transition, completion: sync)
        default:
            print("\(sender.state)")
        }
    }
    
    // MARK: - Private Methods
    
    private func transition(to state: SWPagerStates) {
        _slidersController.prepare(for: state)
        let transition = { () -> Void in
            self._slidersController.transition()
            self._bowlController.state = state
        }
        let sync = { (_: Bool) -> Void in
            self._state = state
            self.pagerController.state = state
        }
        UIView.animate(withDuration: 0.225, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: transition, completion: sync)
//        let bowlChange = { () -> Void in self._bowlController.state = state }
//        UIView.animate(withDuration: 0.225, delay: 0.225, options: [], animations: bowlChange, completion: nil)
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
