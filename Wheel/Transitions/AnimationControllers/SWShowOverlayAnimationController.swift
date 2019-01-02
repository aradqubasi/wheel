//
//  SWShowOverlayController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWShowOverlayAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.225
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? WheelsViewController,
            let toVC = transitionContext.viewController(forKey: .to) as? OverlayViewController,
            let snapshotFromVC = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(snapshotFromVC)
        containerView.addSubview(toVC.view)
        fromVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        var real: UIButton!
        guard let viewkind = toVC.kind else {
            fatalError("toVC.kind is null")
        }
        switch viewkind {
        case .unexpected:
            real = fromVC.toUnexpected
        case .fruits:
            real = fromVC.toFruits
        case .dressing:
            real = fromVC.toDressing
        default:
            return
        }
        let fake = UIButton(frame: containerView.convert(real.frame, from: real.superview!))
        fake.alpha = 0
        containerView.addSubview(fake)
        toVC.discharge()
        toVC.set(for: fake)
 
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    toVC.open()
                }
            },
            completion: { _ in
                fromVC.view.isHidden = false
                snapshotFromVC.removeFromSuperview()
                if transitionContext.transitionWasCancelled {
                    toVC.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
