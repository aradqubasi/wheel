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
    
    private var introduction: UILabel!
    
    private var rollbutton: UIView!
    
    private var tipForRollbutton: UILabel!
    
    private var selectionWheel: UIView!
    
    private var tipForSelectionWheel: UILabel!
    
    private var cookbutton: UIView!
    
    private var tipCookbutton: UILabel!
    
    private var filterbutton: UIView!
    
    private var tipForFilterbutton: UILabel!
    
    private var enhancerbutton: UIView!
    
    private var tipForEnhancerbutton: UILabel!
    
    private var pinview: UIView!
    
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
                highlightView.alpha = 0
            }
            //tip
            do {
                scene.addSubview(tipView)
                tipView.asWalkthrough(text: tipText, width: 240)
                tipView.center = controller.view.getBoundsCenter()
//                tipView.center = CGPoint(x: controller.view.getBoundsCenter().x, y: controller.view.bounds.height * 0.333)
                pagerCenterPoint = pagerCenterOrigin
                
//                if tipLayout == .bottom {
//                    tipView.asWalkthrough(text: tipText, width: -8 + scene.bounds.width + -8)
//                    tipView.frame.origin = CGPoint(x: 8, y: highlightView.frame.origin.y + highlightView.frame.size.height + 8)
//                    pagerCenterPoint = CGPoint(x: tipView.center.x, y: max(tipView.frame.origin.y + tipView.frame.height + 8 + pagerView.frame.height * 0.5, pagerCenterOrigin.y))
//                }
//                else if tipLayout == .leftward {
//                    tipView.asWalkthrough(text: tipText, width: -8 + scene.bounds.width + -8 + -(scene.bounds.width - areaOfInterest.center.x + areaOfInterest.size.width * 0.5))
//                    tipView.center = CGPoint(x: 8 + tipView.frame.width * 0.5, y: highlightView.center.y)
//                    pagerCenterPoint = CGPoint(x: scene.center.x, y: max(max(tipView.frame.origin.y + tipView.frame.height, highlightView.frame.origin.y + highlightView.frame.height) + 8 + pagerView.frame.height * 0.5, pagerCenterOrigin.y))
//                }
//                else if tipLayout == .top {
//                    pagerCenterPoint = CGPoint(x: scene.center.x, y: min(-8 + highlightView.frame.origin.y, pagerCenterOrigin.y))
//                    tipView.asWalkthrough(text: tipText, width: -8 + scene.bounds.width + -8)
//                    tipView.frame.origin = CGPoint(x: 8, y: -tipView.frame.height + -24 + pagerView.frame.height * 0.5 + pagerCenterPoint.y)
//                }
//                else {
//                    fatalError("Unimplemented tip layout \(tipLayout)")
//                }
                tipView.alpha = 0
                tipView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
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
            do {
                highlightView.frame.size = CGSize(side: side * 0.1)
                highlightView.layer.cornerRadius = side * 0.5 * 0.1
                highlightView.center = center
                highlightView.subviews.first!.frame.origin = scene.convert(.zero, to: highlightView)
            }
            
            UIView.animate(withDuration: 0.224, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                self.tipView.alpha = 1
                self.tipView.transform = CGAffineTransform.identity
            }, completion: nil)
            
            UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
                self.highlightView.frame.size = CGSize(side: side)
                self.highlightView.layer.cornerRadius = side * 0.5
                self.highlightView.center = center
                self.highlightView.subviews.first!.frame.origin = scene.convert(.zero, to: self.highlightView)
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
    
    private class SWIntroductionState: SWWalkthroughState {
        
        let skip: UIButton!
        
        init(parent: WalkthroughViewController, index: Int, text: String, layout: CGFloat) {
            skip = UIButton.skip
            let area = SWAreaOfInterest(center: CGPoint(x: -100, y: -100), size: .zero)
            super.init(parent: parent, index: index, text: text, area: area, layout: layout)
        }
        
        override func align() {
            super.align()
            skip.center = CGPoint(x: controller!.view.getBoundsCenter().x, y: controller!.view.bounds.height - 48)
            skip.addTarget(controller!, action: #selector(controller!.onSkip(sender:)), for: .touchUpInside)
            skip.alpha = 0
            skip.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
            controller!.view.addSubview(skip)
        }
        
        override func show() {
            super.show()
            UIView.animate(withDuration: 0.224, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
                self.skip.alpha = 1
                self.skip.transform = CGAffineTransform.identity
            }, completion: nil)
        }
        
        override func fade() {
            super.fade()
            UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
                self.skip.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: CGFloat.pi * 0.15)
                self.skip.alpha = 0
            }, completion: {
                (ok:Bool) in
                self.skip.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
            })
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
            let dotCount = 7
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
//            let state = SWWalkthroughState(parent: self, index: 0, text: "Placeholder text for introduction", area: .zero, layout: .bottom)
            let state = SWIntroductionState(parent: self, index: 0, text: .tipForIntroduction, layout: .bottom)
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
            let state = SWWalkthroughState(parent: self, index: 2, text: String.tipForSelectionWheel, area: areas.selectionWheel, layout: CGFloat.top)
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


        //filter button
        do {
            let state = SWWalkthroughState(parent: self, index: 4, text: String.tipForFilterbutton, area: areas.filtersButton, layout: CGFloat.bottom)
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
        
        // enhancer
        do {
            let state = SWWalkthroughState(parent: self, index: 6, text: String.tipForEnhancerbutton, area: areas.enhancer, layout: CGFloat.bottom)
            state.align()
            let prev = states.last!
            state.prev = prev
            prev.next = state
            states.append(state)
        }
        
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
