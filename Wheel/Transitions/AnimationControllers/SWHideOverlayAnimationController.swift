//
//  SWHideOverlayAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 30/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWHideOverlayAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let overlay = transitionContext.viewController(forKey: .from) as? OverlayViewController,
            let wheels = transitionContext.viewController(forKey: .to) as? WheelsViewController
            else {
                return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(wheels.view)
        containerView.addSubview(overlay.view)
//        overlay.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    overlay.close()
                }
        },
            completion: { _ in
//                fromVC.view.isHidden = false
//                snapshotFromVC.removeFromSuperview()
                
                if transitionContext.transitionWasCancelled {
//                    toVC.view.removeFromSuperview()
                    wheels.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                wheels.navigationController?.isNavigationBarHidden = transitionContext.transitionWasCancelled
        })
    }
}

