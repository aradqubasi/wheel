//
//  SWShowHamburgerController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 16/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWShowHamburgerController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.225
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? WheelsViewController,
            let toVC = transitionContext.viewController(forKey: .to) as? HamburgerViewController,
            let snapshotFromVC = fromVC.view.snapshotView(afterScreenUpdates: false)
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(snapshotFromVC)
        containerView.addSubview(toVC.view)
        fromVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        
//        var real: UIButton!
//        switch toVC.kind {
//        case .unexpected:
//            real = fromVC.toUnexpected!
//        case .fruits:
//            real = fromVC.toFruits
//        case .dressing:
//            real = fromVC.toDressing
//        default:
//            return
//        }
//        let fake = UIButton(frame: containerView.convert(real.frame, from: real.superview!))
//        fake.alpha = 0
//        containerView.addSubview(fake)
//        toVC.discharge()
//        toVC.set(for: fake)
        toVC.setForPopup()
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                    toVC.popup()
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
