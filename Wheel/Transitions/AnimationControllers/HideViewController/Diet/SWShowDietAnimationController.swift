//
//  SWShowDietAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 29/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWShowDietAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private var controller: DietViewController!
    
    init(_ controller: DietViewController) {
        self.controller = controller
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.225
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) as? DietViewController,
            let snapshotFromVC = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(snapshotFromVC)
        containerView.addSubview(toVC.view)
        fromVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
    
        toVC.set()
        
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
