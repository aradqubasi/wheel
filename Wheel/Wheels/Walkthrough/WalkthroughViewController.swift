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
    
    private var proceed: UIButton!
    
    private var background: UIView!
    
    var shroud: UIView!
    
    // MARK: - Pagination
    
    private var pager: UIView!
    
    private var dots: [UIView] = []
    
    private var pagerCenterOrigin: CGPoint = .zero
    
    private var pagerCenterPerState: [CGPoint] = []
    
    private var floating: UIView!
    
    // MARK: - State
    
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
        
        shroud = UIView(frame: view.bounds)
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
            pagerCenterOrigin = CGPoint(x: view.bounds.width * 0.5, y: view.bounds.height * 0.75)
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
        
        // skip
        do {
            skip = UIButton.skip
            skip.addTarget(self, action: #selector(onSkip(sender:)), for: .touchUpInside)
            skip.center = CGPoint(x: view.getBoundsCenter().x, y: view.bounds.height - 48)
            view.addSubview(skip)
        }
        
        // proceed
        do {
            proceed = UIButton.proceed
            proceed.addTarget(self, action: #selector(onProceed(sender:)), for: .touchUpInside)
            proceed.center = CGPoint(x: view.getBoundsCenter().x, y: view.bounds.height - 48)
            proceed.alpha = 0
            view.addSubview(proceed)
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
            let state = SWWalkthroughState(parent: self, index: 1, text: .tipForRollbutton, area: areas.rollButton, layout: CGFloat.leftward)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }

        //selection wheel
        do {
            let state = SWSelectionWheelState(parent: self, index: 2, text: .tipForSelectionWheel, area: areas.selectionWheel, layout: CGFloat.top)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }

        //cook button
        do {
            let state = SWWalkthroughState(parent: self, index: 3, text: .tipForCookbutton, area: areas.cookButton, layout: CGFloat.top)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        //wheel
        do {
            let state = SWWheelviewState(parent: self, index: 4, text: .tipForWheel, area: areas.wheel, layout: CGFloat.top)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }

        //wheel pin
        do {
            let state = SWWalkthroughState(parent: self, index: 5, text: .tipForWheelpin, area: areas.wheelIngredient, layout: CGFloat.bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        //selection pin
        do {
            let state = SWWalkthroughState(parent: self, index: 6, text: .tipForSelectedpin, area: areas.selectionIngredient, layout: CGFloat.bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        // enhancer
        do {
            let state = SWWalkthroughState(parent: self, index: 7, text: .tipForEnhancerbutton, area: areas.enhancer, layout: CGFloat.bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        //filter button
        do {
            let state = SWWalkthroughState(parent: self, index: 8, text: .tipForFilterbutton, area: areas.filtersButton, layout: CGFloat.bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
        //outro
        do {
            let state = SWOutroWheelState(parent: self, index: 9, text: .tipForOutro, area: SWAreaOfInterest(center: CGPoint(x: -100, y: -100), size: .zero), layout: .bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
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
    
    func hide() {
        view.subviews.forEach({
            if $0 !== self.background {
                $0.alpha = 0
            }
        })
    }
    
    // MARK: - Actions
    
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
    
    @IBAction private func onProceed(sender: UIButton) {
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

// MARK - State

extension WalkthroughViewController {
    private class SWWalkthroughState {
        let index: Int
        let highlightView: UIView
        let tipView: UILabel
        let invertTipView: UILabel
        let areaOfInterest: SWAreaOfInterest
        let tipText: NSAttributedString
        let tipLayout: CGFloat
        var pagerCenterPoint: CGPoint!
        weak var controller: WalkthroughViewController?
        var next: SWWalkthroughState?
        var prev: SWWalkthroughState?
        
        
        init(parent: WalkthroughViewController, index: Int, text: NSAttributedString, area: SWAreaOfInterest, layout: CGFloat) {
            self.index = index
            highlightView = UIView()
            tipView = UILabel()
            invertTipView = UILabel()
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
            
            //tip
            do {
                scene.addSubview(tipView)
                tipView.asWalkthrough(text: tipText, width: 240)
                tipView.center = controller.view.getBoundsCenter()
                pagerCenterPoint = pagerCenterOrigin
                tipView.alpha = 0
                tipView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
            }
            
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
                highlightView.alpha = 0
            }
            
            //invert tip
            do {
                let blackfont = UILabel()
                blackfont.asWalkthrough(text: tipText, width: 240)
                blackfont.attributedText = tipText.blackify()
                highlightView.addSubview(blackfont)
                blackfont.center = controller.view.convert(controller.view.getBoundsCenter(), to: highlightView)
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
        
        override func align() {
            super.align()
            
            let pagerCenterOrigin = controller!.pagerCenterOrigin
            pagerCenterPoint = CGPoint(x: pagerCenterOrigin.x, y: -48 + -48 + highlightView.frame.origin.y)
            
            let transform = tipView.transform
            tipView.transform = CGAffineTransform.identity
            do {
                tipView.center.y = -tipView.frame.height * 0.5 + -48 + pagerCenterPoint.y
            }
            tipView.transform = transform

        }
        
        override func show() {
            super.show()
            UIView.animate(withDuration: 0.224, animations: {
                let controller = self.controller!
                controller.skip.center = CGPoint(x: self.pagerCenterPoint.x, y:  self.pagerCenterPoint.y + 48)
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
        }
        
    }
    
    private class SWOutroWheelState: SWWalkthroughState {
        
        override func align() {
            super.align()
            controller!.proceed.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
        }
        
        override func show() {
            super.show()
            
            UIView.animate(withDuration: 0.224, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                self.controller!.proceed.transform = CGAffineTransform.identity
                self.controller!.proceed.alpha = 1
                
                self.controller!.skip.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: CGFloat.pi * 0.15)
                self.controller!.skip.alpha = 0
            }, completion: nil)
        }
        
        override func fade() {
            super.fade()
            UIView.animate(withDuration: 0.224, animations: {
                self.controller!.proceed.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
                self.controller!.proceed.alpha = 0
                
                self.controller!.skip.transform = CGAffineTransform.identity
                self.controller!.skip.alpha = 1
            })
        }
        
    }
}
