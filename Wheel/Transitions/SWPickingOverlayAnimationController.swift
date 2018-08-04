//
//  SWPickingOverlayAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWPickingOverlayAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    
//    controller.focus(on: pin.asIngridient)
//
//    let close = { () in
//        controller.close()
//    }
//
//    let discharge = { (_:Bool) in
//        controller.discharge()
//    }
//
//    if let focused = controller.focused {
//        if selectionController.selected.first(where: { $0.asIngridient.kind == pin.asIngridient.kind }) != nil {
//            selectionController.upreplace(with: focused.asIngridient)
//        }
//        else {
//            add([focused])
//        }
//    }
//
//    UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: discharge)
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.225
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let overlay = transitionContext.viewController(forKey: .from) as? OverlayViewController,
            let wheel = transitionContext.viewController(forKey: .to) as? WheelsViewController
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        
        containerView.addSubview(wheel.view)
        containerView.addSubview(overlay.view)
        overlay.view.backgroundColor = .clear
        overlay.background?.removeFromSuperview()

        let duration = transitionDuration(using: transitionContext)

        let close = { () in
            overlay.close()
        }
        
        let complete = { (_:Bool) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//            wheel.navigationController?.isNavigationBarHidden = transitionContext.transitionWasCancelled
        }
        
//        if let focused = overlay.focused {
//            if wheel.selectionController.selected.first(where: { $0.asIngridient.kind == overlay.focused!.asIngridient.kind }) != nil {
//                wheel.selectionController.upreplace(with: focused.asIngridient)
//            }
//            else {
//                wheel.add([focused])
//            }
//        }
        
        if let focused = overlay.focused {
            if wheel.selectionController.getSelected().first(where: { $0.kind == overlay.focused!.asIngridient.kind }) != nil {
                wheel.selectionController.push(focused.asIngridient)
            }
            else {
                wheel.selectionController.push([focused])
            }
        }
        
        wheel.navigationController?.setNavigationBarHidden(false, animated: true)
        UIView.animate(withDuration: duration, delay: 0, options: [], animations: close, completion: complete)

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
//
//        UIView.animateKeyframes(
//            withDuration: duration,
//            delay: 0,
//            options: .calculationModeCubic,
//            animations: {
//                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
//                    toVC.open()
//                }
//        },
//            completion: { _ in
//                fromVC.view.isHidden = false
//                snapshotFromVC.removeFromSuperview()
//                if transitionContext.transitionWasCancelled {
//                    toVC.view.removeFromSuperview()
//                }
//                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        })
    }
}
