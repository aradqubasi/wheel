//
//  SWCompleteAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 19/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWCompleteAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let dismissed: UIViewController!
    
    let appearing: UIViewController!
    
    init(from: UIViewController, to: UIViewController) {
        dismissed = from
        appearing = to
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshotFromVC = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }
        
//        toVC.view.frame.origin = CGPoint(x: 0, y: toVC.view.frame.height * 0.2)
        
        let shroud = UIView(frame: fromVC.view.bounds)
        shroud.backgroundColor = UIColor.limedSpruce
        shroud.alpha = 0.6
        
        let containerView = transitionContext.containerView
        containerView.insertSubview(toVC.view, at: 0)
        containerView.addSubview(shroud)
        containerView.addSubview(snapshotFromVC)
        fromVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    shroud.alpha = 0
                    snapshotFromVC.frame.origin = CGPoint(x: 0, y: -containerView.frame.height)
                    toVC.view.frame.origin = .zero
                }
        },
            completion: { _ in
                fromVC.view.isHidden = false
                snapshotFromVC.removeFromSuperview()
                shroud.removeFromSuperview()
                if transitionContext.transitionWasCancelled {
                    toVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func interactionController() -> UIViewControllerInteractiveTransitioning? {
        return (dismissed as? SWDismissableViewController)?.interactionControllerForDismissal()
    }
}
