//
//  SWNoAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 29/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWNoAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionContext.containerView.addSubview(transitionContext.view(forKey: .to)!)
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
    
}
