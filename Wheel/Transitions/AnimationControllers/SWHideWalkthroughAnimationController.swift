//
//  SWHideWalkthroughAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/09/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWHideWalkthroughAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let walkthrough = transitionContext.viewController(forKey: .from) as? WalkthroughViewController,
            let wheels = transitionContext.viewController(forKey: .to) as? WheelsViewController
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(wheels.view)
        containerView.addSubview(walkthrough.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    walkthrough.hide()
                }
        },
            completion: { _ in
                if transitionContext.transitionWasCancelled {
                    wheels.view.removeFromSuperview()
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                wheels.navigationController?.isNavigationBarHidden = transitionContext.transitionWasCancelled
        })
    }
}
