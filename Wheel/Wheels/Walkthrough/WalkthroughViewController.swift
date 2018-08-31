//
//  WalkthroughViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class WalkthroughViewController: SWViewController {
    
    // MARK: - Public Properties
    
    var assembler: SWWalkthroughAssembler!
    
    // MARK: - Private Properties
    
    private var tipController: SWTipController!
    
    private var areas: SWAreasOfInterest!
    
    // MARK: - Gesture Recognizers
    
    private var forward: UISwipeGestureRecognizer!
    
    private var backward: UISwipeGestureRecognizer!
    
    // MARK: - Subviews
    
    private var skip: UIButton!
    
    private var background: UIView!
    
    // MARK: - Pagination
    
    private var pager: UIView!
    
    private var dots: [UIView] = []
    
    private var pagerCenterOrigin: CGPoint = .zero
    
    private var pagerCenterPerState: [CGPoint] = []
    
    private var floating: UIView!
    
    // MARK: - State
    
    private class SWWalkthroughState {
        let index: Int
        let highlightView: UIView
        let tipView: UILabel
        let areaOfInterest: SWAreaOfInterest
        let tipText: String
        let tipLayout: CGFloat
        var pagerCenterPoint: CGPoint!
        weak var controller: WalkthroughViewController?
        var next: SWWalkthroughState?
        var prev: SWWalkthroughState?
        

        init(parent: WalkthroughViewController, index: Int, text: String, area: SWAreaOfInterest, layout: CGFloat) {
            self.index = index
            highlightView = UIView()
            tipView = UILabel()
            areaOfInterest = area
            tipText = text
            tipLayout = layout
            controller = parent
        }
        
        func align() {
            guard let controller = controller else {
                fatalError("WalkthroughViewController is unavaialble")
            }
            
            let originalBackground: UIView = controller.background
            let scene: UIView = controller.view
//            let pagerView: UIView = controller.pager
            let pagerCenterOrigin = controller.pagerCenterOrigin
            
            //highlight
            do {
                let side = max(areaOfInterest.size.width, areaOfInterest.size.height) + 60
                highlightView.frame = CGRect(origin: .zero, size: CGSize(side: side))
                scene.addSubview(highlightView)
                highlightView.center = areaOfInterest.center
                highlightView.layer.cornerRadius = side * 0.5
                highlightView.clipsToBounds = true
                let copyground = originalBackground.snapshotView(afterScreenUpdates: false)!
                highlightView.addSubview(copyground)
                copyground.frame.origin = scene.convert(.zero, to: highlightView)
//                let revert = highlightView.convert(copyground.frame.origin, to: scene)
                highlightView.alpha = 0
            }
            //tip
            do {
                scene.addSubview(tipView)
                tipView.asWalkthrough(text: tipText, width: 240)
                tipView.center = controller.view.getBoundsCenter()
                pagerCenterPoint = pagerCenterOrigin
                tipView.alpha = 0
                tipView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
            }
        }
        
        private func getFrameOrigins(of subviews: [UIView], in scene: UIView) -> [CGPoint] {
//            return subviews.map({ $0.superview!.convert($0.frame.origin, to: scene) })
            return subviews.map({ $0.convert(.zero, to: scene) })
        }
        
        private func setFrameOrigins(_ origins: [CGPoint], of subviews: [UIView], from scene: UIView, to container: UIView) {
            for i in 0..<subviews.count {
                let subview = subviews[i]
                let origin = origins[i]
                
                subview.frame.origin = scene.convert(origin, to: container)
            }
        }
        
        func show() {
            guard let controller = controller else {
                fatalError("WalkthroughViewController is unavaialble")
            }
            guard let scene = controller.view else {
                fatalError("WalkthroughViewController's view is unavaialble")
            }
            
            controller.showing = true
            
            highlightView.alpha = 1
            let center = highlightView.center
            let side = highlightView.frame.size.width
            var origins: [CGPoint] = []
            do {
                origins = getFrameOrigins(of: highlightView.subviews, in: scene)
                highlightView.frame.size = CGSize(side: side * 0.1)
                highlightView.layer.cornerRadius = side * 0.5 * 0.1
                highlightView.center = center
//                highlightView.subviews.first!.frame.origin = scene.convert(.zero, to: highlightView)
                setFrameOrigins(origins, of: highlightView.subviews, from: scene, to: highlightView)
            }
            
            UIView.animate(withDuration: 0.224, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                self.tipView.alpha = 1
                self.tipView.transform = CGAffineTransform.identity
            }, completion: nil)
            
            UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
                self.highlightView.frame.size = CGSize(side: side)
                self.highlightView.layer.cornerRadius = side * 0.5
                self.highlightView.center = center
//                self.highlightView.subviews.first!.frame.origin = scene.convert(.zero, to: self.highlightView)
                self.setFrameOrigins(origins, of: self.highlightView.subviews, from: scene, to: self.highlightView)
            }, completion: {
                (ok:Bool) in
                controller.showing = false
            })
        }
        
        func fade() {
            guard let controller = controller else {
                fatalError("WalkthroughViewController is unavaialble")
            }
            guard let scene = controller.view else {
                fatalError("WalkthroughViewController's view is unavaialble")
            }
            
            controller.fading = true
            
            highlightView.alpha = 1
            let center = highlightView.center
            let side = highlightView.frame.size.width
            let subViewOrigin = highlightView.subviews.first!.frame.origin
            
            UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
                do {
                    self.highlightView.frame.size = CGSize(side: side * 0.1)
                    self.highlightView.layer.cornerRadius = side * 0.5 * 0.1
                    self.highlightView.center = center
                    self.highlightView.alpha = 0
                    self.highlightView.subviews.first!.frame.origin = scene.convert(.zero, to: self.highlightView)
                }
                do {
                    self.tipView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: CGFloat.pi * 0.15)
                    self.tipView.alpha = 0
                }
            }, completion: {
                (ok:Bool) in
                do {
                    self.highlightView.frame.size = CGSize(side: side)
                    self.highlightView.layer.cornerRadius = side * 0.5
                    self.highlightView.center = center
                    self.highlightView.subviews.first!.frame.origin = subViewOrigin
                }
                do {
                    self.tipView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
                }
                controller.fading = false
            })
        }
        
        func transition(forward: Bool) -> SWWalkthroughState {
            guard let controller = self.controller else {
                fatalError("WalkthroughViewController is unavaialble")
            }
            guard let destanation = forward ? next : prev else {
                return self
            }
            if controller.isAnimating {
                return self
            }
            if forward {
                fade()
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {
                    (timer) in
                    destanation.show()
                    controller.animatePager(anchor: destanation.pagerCenterPoint, from: self.index, to: destanation.index)
                })
            }
            else {
                fade()
                controller.animatePager(anchor: destanation.pagerCenterPoint, from: self.index, to: destanation.index)
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {
                    (timer) in
                    destanation.show()
                })
            }
            return destanation
        }
    }
    
    private class SWSelectionWheelState: SWWalkthroughState {

        override func show() {
            super.show()
            UIView.animate(withDuration: 0.224, animations: {
                let controller = self.controller!
                controller.skip.center = CGPoint(x: controller.pager.center.x, y: controller.pager.center.y + 48)
            })
        }
        
        override func fade() {
            super.fade()
            UIView.animate(withDuration: 0.224, animations: {
                let controller = self.controller!
                controller.skip.center = CGPoint(x: controller.pager.center.x, y: controller.view.bounds.height - 48)
            })
        }
        
    }
    
    private class SWWheelviewState: SWWalkthroughState {
        
        override func align() {
            super.align()
            
            let pagerCenterOrigin = controller!.pagerCenterOrigin
            pagerCenterPoint = CGPoint(x: pagerCenterOrigin.x, y: highlightView.frame.origin.y + highlightView.frame.size.height + 24)
            
            highlightView.removeFromSuperview()
            controller?.view.addSubview(highlightView)
            
            let transform = tipView.transform
            tipView.transform = CGAffineTransform.identity
            let blackfont = UILabel()
            blackfont.asWalkthrough(text: tipText, width: tipView.frame.width)
            blackfont.attributedText = tipView.attributedText!.blackify()
            highlightView.addSubview(blackfont)
            blackfont.frame.origin = controller!.view.convert(tipView.frame.origin, to: highlightView)
            tipView.transform = transform
        }
        
    }
    
    private var states: [SWWalkthroughState] = []
    
    private var highlightViewPerState: [UIView] = []
    
    private var tipViewPerState: [UILabel] = []
    
    private var areaOfInterestPerState: [SWAreaOfInterest] = []
    
    private var tipTextPerState: [String] = []
    
    private var tipLayoutPerState: [CGFloat] = []
    
    private var showNext: [(WalkthroughViewController) -> Void] = []
    
    private var fadeCurrent: [(WalkthroughViewController) -> Void] = []
    
    private var state: Int = 0
    
    private var current: SWWalkthroughState!
    
    // MARK: - Transition
    
    private var showing: Bool = false
    
    private var fading: Bool = false
    
    private var paging: Bool = false
    
    private var isAnimating: Bool {
        get {
            return showing || fading || paging
        }
    }
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        background = assembler.resolve()
        view.addSubview(background)
        
        let shroud = UIView(frame: view.bounds)
        shroud.backgroundColor = UIColor.limedSpruceTransparent
        view.addSubview(shroud)
        
        navigationController?.setNavigationBarHidden(true, animated: false)

        self.tipController = SWTipController()
        
        self.areas = assembler.resolve()
        
        self.segues = assembler.resolve()
        
        // pan gesture recognizer
        do {
            forward = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeForward(sender:)))
            forward.direction = .left
            view.addGestureRecognizer(forward)
            
            backward = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeBack(sender:)))
            backward.direction = .right
            view.addGestureRecognizer(backward)
        }
        
        // pagination
        do {
            pagerCenterOrigin = CGPoint(x: view.bounds.width * 0.5, y: view.bounds.height * 0.66)
            let dotCount = 10
            pager = UIView()
            for i in 0..<dotCount {
                let dot = UIView(frame: CGRect(origin: CGPoint(x: i * 24, y: 0), size: CGSize(width: 8, height: 8)))
                dot.backgroundColor = .white
                dot.layer.cornerRadius = 4
                dot.alpha = 0.25
                pager.addSubview(dot)
                dots.append(dot)
            }
            pager.frame = CGRect(origin: .zero, size: CGSize(width: dotCount * 24 - 8, height: 8))
            view.addSubview(pager)
            pager.center = pagerCenterOrigin
            
            floating = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 8, height: 8)))
            floating.backgroundColor = .white
            floating.layer.cornerRadius = 4
            floating.alpha = 0.25
            pager.addSubview(floating)
        }
        
        //introduction
        do {
            let state = SWWalkthroughState(parent: self, index: 0, text: .tipForIntroduction, area: SWAreaOfInterest(center: CGPoint(x: -100, y: -100), size: .zero), layout: .bottom)
//            let state = SWIntroductionState(parent: self, index: 0, text: .tipForIntroduction, layout: .bottom)
            state.align()
            states.append(state)
            current = state
        }
        
        //random salad
        do {
            let state = SWWalkthroughState(parent: self, index: 1, text: String.tipForRollbutton, area: areas.rollButton, layout: CGFloat.leftward)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }

        //selection wheel
        do {
            let state = SWSelectionWheelState(parent: self, index: 2, text: String.tipForSelectionWheel, area: areas.selectionWheel, layout: CGFloat.top)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }

        //cook button
        do {
            let state = SWWalkthroughState(parent: self, index: 3, text: String.tipForCookbutton, area: areas.cookButton, layout: CGFloat.top)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        //wheel
        do {
            let state = SWWheelviewState(parent: self, index: 4, text: String.tipForWheel, area: areas.wheel, layout: CGFloat.top)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }

        //wheel pin
        do {
            let state = SWWalkthroughState(parent: self, index: 5, text: String.tipForWheelpin, area: areas.wheelIngredient, layout: CGFloat.bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        //selection pin
        do {
            let state = SWWalkthroughState(parent: self, index: 6, text: String.tipForSelectedpin, area: areas.selectionIngredient, layout: CGFloat.bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        // enhancer
        do {
            let state = SWWalkthroughState(parent: self, index: 7, text: String.tipForEnhancerbutton, area: areas.enhancer, layout: CGFloat.bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        //filter button
        do {
            let state = SWWalkthroughState(parent: self, index: 8, text: String.tipForFilterbutton, area: areas.filtersButton, layout: CGFloat.bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        //outro
        do {
            let state = SWWalkthroughState(parent: self, index: 9, text: .tipForOutro, area: SWAreaOfInterest(center: CGPoint(x: -100, y: -100), size: .zero), layout: .bottom)
            state.align()
            let prev = states.last!
            prev.next = state
            states.append(state)
        }
        
        // skip
        do {
            skip = UIButton.skip
            skip.addTarget(self, action: #selector(onSkip(sender:)), for: .touchUpInside)
            skip.center = CGPoint(x: view.getBoundsCenter().x, y: view.bounds.height - 48)
            view.addSubview(skip)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        states.first!.show()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Animation Methods
    
    private func animatePager(anchor: CGPoint, from prev: Int, to next: Int) {
        paging = true
        UIView.animateKeyframes(withDuration: 0.225, delay: 0, options: [], animations: {
            let forward = next > prev
            let middleway = CGPoint(x: (anchor.x + self.pager.center.x) * 0.5, y: (anchor.y + self.pager.center.y) * 0.5)
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.pager.center = middleway
                self.floating.frame.origin = CGPoint(x: self.floating.frame.origin.x - (forward ? 0 : 8), y: self.floating.frame.origin.y)
                self.floating.frame.size = CGSize(width: 16, height: 8)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.pager.center = anchor
                self.floating.frame.origin = self.dots[next].frame.origin
                self.floating.frame.size = CGSize(side: 8)
            })
        }, completion: {
            (ok: Bool) in
            self.paging = false
        })
    }
    
    @IBAction private func onSwipeForward(sender: UISwipeGestureRecognizer) {
        print("swipe forward")
        current = current.transition(forward: true)
    }
    
    @IBAction private func onSwipeBack(sender: UISwipeGestureRecognizer) {
        print("swipe back")
        current = current.transition(forward: false)
    }
    
    @IBAction private func onSkip(sender: UIButton) {
        print("skip")
        perform(segue: segues.getWalkthroughToWheels())
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
