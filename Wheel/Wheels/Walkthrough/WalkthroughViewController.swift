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
            let pagerView: UIView = controller.pager
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
                if tipLayout == .bottom {
                    tipView.asWalkthrough(text: tipText, width: -8 + scene.bounds.width + -8)
                    tipView.frame.origin = CGPoint(x: 8, y: highlightView.frame.origin.y + highlightView.frame.size.height + 8)
                    pagerCenterPoint = CGPoint(x: tipView.center.x, y: max(tipView.frame.origin.y + tipView.frame.height + 8 + pagerView.frame.height * 0.5, pagerCenterOrigin.y))
                }
                else if tipLayout == .leftward {
                    tipView.asWalkthrough(text: tipText, width: -8 + scene.bounds.width + -8 + -(scene.bounds.width - areaOfInterest.center.x + areaOfInterest.size.width * 0.5))
                    tipView.center = CGPoint(x: 8 + tipView.frame.width * 0.5, y: highlightView.center.y)
                    pagerCenterPoint = CGPoint(x: scene.center.x, y: max(max(tipView.frame.origin.y + tipView.frame.height, highlightView.frame.origin.y + highlightView.frame.height) + 8 + pagerView.frame.height * 0.5, pagerCenterOrigin.y))
                }
                else if tipLayout == .top {
                    pagerCenterPoint = CGPoint(x: scene.center.x, y: min(-8 + highlightView.frame.origin.y, pagerCenterOrigin.y))
                    tipView.asWalkthrough(text: tipText, width: -8 + scene.bounds.width + -8)
                    tipView.frame.origin = CGPoint(x: 8, y: -tipView.frame.height + -24 + pagerView.frame.height * 0.5 + pagerCenterPoint.y)
                }
                else {
                    fatalError("Unimplemented tip layout \(tipLayout)")
                }
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
            let state = SWWalkthroughState(parent: self, index: 0, text: "Placeholder text for introduction", area: .zero, layout: .bottom)
            state.align()
            pagerCenterPerState.append(state.pagerCenterPoint)
            showNext.append({ (controller) -> Void in })
            fadeCurrent.append({ (controller) -> Void in })
        }
        
        //random salad
        do {
            let state = SWWalkthroughState(parent: self, index: 1, text: String.tipForRollbutton, area: areas.rollButton, layout: CGFloat.leftward)
            state.align()
            pagerCenterPerState.append(state.pagerCenterPoint)
            showNext.append({
                (controller) -> Void in
                state.show()
            })
            fadeCurrent.append({
                (controller) -> Void in
                state.fade()
            })
        }

        //selection wheel
        do {
            let state = SWWalkthroughState(parent: self, index: 2, text: String.tipForSelectionWheel, area: areas.selectionWheel, layout: CGFloat.top)
            state.align()
            pagerCenterPerState.append(state.pagerCenterPoint)
            showNext.append({
                (controller) -> Void in
                state.show()
            })
            fadeCurrent.append({
                (controller) -> Void in
                state.fade()
            })
        }

        //cook button
        do {
            let state = SWWalkthroughState(parent: self, index: 3, text: String.tipForCookbutton, area: areas.cookButton, layout: CGFloat.top)
            state.align()
            pagerCenterPerState.append(state.pagerCenterPoint)
            showNext.append({
                (controller) -> Void in
                state.show()
            })
            fadeCurrent.append({
                (controller) -> Void in
                state.fade()
            })
        }


        //filter button
        do {
            let state = SWWalkthroughState(parent: self, index: 4, text: String.tipForFilterbutton, area: areas.filtersButton, layout: CGFloat.bottom)
            state.align()
            pagerCenterPerState.append(state.pagerCenterPoint)
            showNext.append({
                (controller) -> Void in
                state.show()
            })
            fadeCurrent.append({
                (controller) -> Void in
                state.fade()
            })
        }
        
        //wheel pin
        do {
            let state = SWWalkthroughState(parent: self, index: 5, text: String.tipForWheelpin, area: areas.wheelIngredient, layout: CGFloat.bottom)
            state.align()
            pagerCenterPerState.append(state.pagerCenterPoint)
            showNext.append({
                (controller) -> Void in
                state.show()
            })
            fadeCurrent.append({
                (controller) -> Void in
                state.fade()
            })
        }
        
        // enhancer
        do {
            let state = SWWalkthroughState(parent: self, index: 6, text: String.tipForEnhancerbutton, area: areas.enhancer, layout: CGFloat.bottom)
            state.align()
            pagerCenterPerState.append(state.pagerCenterPoint)
            showNext.append({
                (controller) -> Void in
                state.show()
            })
            fadeCurrent.append({
                (controller) -> Void in
                state.fade()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Animation Methods

//    private func align(highlightView: UIView, highlightArea: SWAreaOfInterest, background: UIView, tipView: UILabel, tipText: String, tipLayout: CGFloat, pagerView: UIView) -> Void {
    private func align(state: Int, background: UIView, pagerView: UIView) -> Void {
        let highlightView = highlightViewPerState[state]
        let highlightArea = areaOfInterestPerState[state]
        let tipView = tipViewPerState[state]
        let tipText = tipTextPerState[state]
        let tipLayout = tipLayoutPerState[state]
        
        //highlight
        do {
            let side = max(highlightArea.size.width, highlightArea.size.height) + 60
            highlightView.frame = CGRect(origin: .zero, size: CGSize(side: side))
            view.addSubview(highlightView)
            highlightView.center = highlightArea.center
            highlightView.layer.cornerRadius = side * 0.5
            highlightView.clipsToBounds = true
            let copyground = background.snapshotView(afterScreenUpdates: false)!
            highlightView.addSubview(copyground)
            copyground.frame.origin = view.convert(.zero, to: highlightView)
            highlightView.alpha = 0
        }
        //tip
        do {
            view.addSubview(tipView)
            var newPagerCenter: CGPoint!
            if tipLayout == .bottom {
                tipView.asWalkthrough(text: tipText, width: -8 + view.bounds.width + -8)
                tipView.frame.origin = CGPoint(x: 8, y: highlightView.frame.origin.y + highlightView.frame.size.height + 8)
                newPagerCenter = CGPoint(x: tipView.center.x, y: max(tipView.frame.origin.y + tipView.frame.height + 8 + pagerView.frame.height * 0.5, pagerCenterOrigin.y))
            }
            else if tipLayout == .leftward {
                tipView.asWalkthrough(text: tipText, width: -8 + view.bounds.width + -8 + -(view.bounds.width - highlightArea.center.x + highlightArea.size.width * 0.5))
                tipView.center = CGPoint(x: 8 + tipView.frame.width * 0.5, y: highlightView.center.y)
                newPagerCenter = CGPoint(x: view.center.x, y: max(max(tipView.frame.origin.y + tipView.frame.height, highlightView.frame.origin.y + highlightView.frame.height) + 8 + pagerView.frame.height * 0.5, pagerCenterOrigin.y))
            }
            else {
                fatalError("Uknown tip layout")
            }
            tipView.alpha = 0
            tipView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
            pagerCenterPerState.append(newPagerCenter)
        }
    }
    
    private func animateShow(highlightView: UIView, tipView: UIView) {
        showing = true
        
        highlightView.alpha = 1
        let center = highlightView.center
        let side = highlightView.frame.size.width
        do {
            highlightView.frame.size = CGSize(side: side * 0.1)
            highlightView.layer.cornerRadius = side * 0.5 * 0.1
            highlightView.center = center
            highlightView.subviews.first!.frame.origin = view.convert(.zero, to: highlightView)
        }
        
        UIView.animate(withDuration: 0.224, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            tipView.alpha = 1
            tipView.transform = CGAffineTransform.identity
        }, completion: nil)
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
            highlightView.frame.size = CGSize(side: side)
            highlightView.layer.cornerRadius = side * 0.5
            highlightView.center = center
            highlightView.subviews.first!.frame.origin = self.view.convert(.zero, to: highlightView)
        }, completion: {
            (ok:Bool) in
            self.showing = false
        })
    }
    
    private func animateFade(highlightView: UIView, tipView: UIView) {
        fading = true
        
        highlightView.alpha = 1
        let center = highlightView.center
        let side = highlightView.frame.size.width
        let subViewOrigin = highlightView.subviews.first!.frame.origin
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
            do {
                highlightView.frame.size = CGSize(side: side * 0.1)
                highlightView.layer.cornerRadius = side * 0.5 * 0.1
                highlightView.center = center
                highlightView.alpha = 0
                highlightView.subviews.first!.frame.origin = self.view.convert(.zero, to: highlightView)
            }
            do {
                tipView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: CGFloat.pi * 0.15)
                tipView.alpha = 0
            }
        }, completion: {
            (ok:Bool) in
            do {
                highlightView.frame.size = CGSize(side: side)
                highlightView.layer.cornerRadius = side * 0.5
                highlightView.center = center
                highlightView.subviews.first!.frame.origin = subViewOrigin
            }
            do {
                tipView.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1).rotated(by: -CGFloat.pi * 0.15)
            }
            self.fading = false
        })
        
        
    }
    
    private func initWalkthrough(as circle: UIView, at area: SWAreaOfInterest, in scene: UIView, with background: UIView, margin: CGFloat) {
        let side = max(area.size.width, area.size.height) + margin
        circle.frame = CGRect(origin: .zero, size: CGSize(side: side))
        scene.addSubview(circle)
        circle.center = area.center
        circle.layer.cornerRadius = side * 0.5
        circle.clipsToBounds = true
        let copyground = background.snapshotView(afterScreenUpdates: false)!
        circle.addSubview(copyground)
        copyground.frame.origin = scene.convert(.zero, to: circle)
        circle.alpha = 0
    }
    
    private func animatePager() {
        paging = true
        let anchor = pagerCenterPerState[state]
        UIView.animateKeyframes(withDuration: 0.225, delay: 0, options: [], animations: {
            let forward = self.floating.frame.origin.x < self.dots[self.state].frame.origin.x
            let middleway = CGPoint(x: (anchor.x + self.pager.center.x) * 0.5, y: (anchor.y + self.pager.center.y) * 0.5)
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                self.pager.center = middleway
                self.floating.frame.origin = CGPoint(x: self.floating.frame.origin.x - (forward ? 0 : 8), y: self.floating.frame.origin.y)
                self.floating.frame.size = CGSize(width: 16, height: 8)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.pager.center = anchor
                self.floating.frame.origin = self.dots[self.state].frame.origin
                self.floating.frame.size = CGSize(side: 8)
            })
        }, completion: {
            (ok: Bool) in
            self.paging = false
        })
    }
    
    private func animateTip() {
        
    }

    private func animateWalkthrough(_ circle: UIView, in scene: UIView, with tip: SWTipController, text: String, at orientation: SWTipOrientation) {
        showing = true
        
        var anchor: CGPoint = .zero
        switch orientation {
        case .midbottom, .rightbottom:
            anchor = CGPoint(x: circle.center.x, y: circle.frame.origin.y)
        case .midright:
            anchor = CGPoint(x: circle.frame.origin.x, y: circle.center.y)
        case .midtop, .righttop:
            anchor = CGPoint(x: circle.center.x, y: circle.frame.origin.y + circle.frame.height)
//        default:
//            fatalError("No anchor for \(orientation)")
        }

        tip.orientation = orientation
        tip.show(tip: text, at: anchor, in: view)
        tip.shrink()
        
        circle.alpha = 1
        let center = circle.center
        let side = circle.frame.size.width
        let subViewOrigin = circle.subviews.first!.frame.origin
        
        do {
            circle.frame.size = CGSize(side: side * 0.1)
            circle.layer.cornerRadius = side * 0.5 * 0.1
            circle.center = center
            circle.subviews.first!.frame.origin = scene.convert(.zero, to: circle)
        }
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
            do {
                circle.frame.size = CGSize(side: side)
                circle.layer.cornerRadius = side * 0.5
                circle.center = center
                circle.subviews.first!.frame.origin = subViewOrigin
            }
            do {
                tip.grow()
            }
        }, completion: {
            (success:Bool) in
        })
        
        showing = false
    }
    
    private func fadeWalkthrough(_ circle: UIView, in scene: UIView, with tip: SWTipController) {
        fading = true
        
        circle.alpha = 1
        let center = circle.center
        let side = circle.frame.size.width
        let subViewOrigin = circle.subviews.first!.frame.origin
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseOut], animations: {
            do {
                circle.frame.size = CGSize(side: side * 0.1)
                circle.layer.cornerRadius = side * 0.5 * 0.1
                circle.center = center
                circle.alpha = 0
                circle.subviews.first!.frame.origin = scene.convert(.zero, to: circle)
            }
            do {
                tip.fade()
            }
        }, completion: {
            (success:Bool) in
            circle.frame.size = CGSize(side: side)
            circle.layer.cornerRadius = side * 0.5
            circle.center = center
            circle.subviews.first!.frame.origin = subViewOrigin
        })
        
        fading = false
    }

    @IBAction private func onSwipeForward(sender: UISwipeGestureRecognizer) {
        print("swipe forward")
        if !isAnimating && state != showNext.count - 1 {
//            fadeCurrent[state](self)
//            state += 1
//            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {
//                (timer) -> Void in
//                self.showNext[self.state](self)
//                self.animatePager()
//            })
            fadeCurrent[state](self)
            state += 1
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {
                (timer) -> Void in
                self.showNext[self.state](self)
                self.animatePager()
            })
        }
    }
    
    @IBAction private func onSwipeBack(sender: UISwipeGestureRecognizer) {
        print("swipe back")
        if !isAnimating && state != 0 {
            fadeCurrent[state](self)
            state -= 1
            self.animatePager()
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {
                (timer) -> Void in
                self.showNext[self.state](self)
//                self.animatePager()
            })
        }
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
