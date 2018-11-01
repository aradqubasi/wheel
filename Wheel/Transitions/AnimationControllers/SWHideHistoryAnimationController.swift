//
//  SWHideHistoryAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 31/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWHideHistoryAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.225
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshotFromVC = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }
        
        print("SWHideHistoryAnimationController.animateTransition")
        
        toVC.view.frame.origin = CGPoint(x: -toVC.view.frame.width * 0.2, y: 0)
        
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
                    snapshotFromVC.frame.origin = CGPoint(x: containerView.frame.width, y: 0)
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
                print("transition \(transitionContext.transitionWasCancelled ? "cancelled" : "completed")")
            })
    }
}

