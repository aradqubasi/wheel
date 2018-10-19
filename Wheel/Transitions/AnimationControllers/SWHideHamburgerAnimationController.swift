//
//  SWHideHamburgerAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWHideHamburgerAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let controller: HamburgerViewController
    
    init(_ controller: HamburgerViewController) {
        self.controller = controller
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.225
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let hamburger = transitionContext.viewController(forKey: .from) as? HamburgerViewController, let wheels = transitionContext.viewController(forKey: .to) as? WheelsViewController
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(wheels.view)
        wheels.view.isHidden = true
        containerView.addSubview(hamburger.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        hamburger.popup()
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    hamburger.hide()
                }
            },
            completion: { _ in
                if transitionContext.transitionWasCancelled {
                    wheels.view.removeFromSuperview()
                }
                else {
                    hamburger.view.removeFromSuperview()
                    wheels.view.isHidden = false
                    wheels.navigationController?.setNavigationBarHidden(false, animated: false)
                }
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func interactionController() -> UIViewControllerInteractiveTransitioning? {
        return self.controller.transitioning
    }
}
