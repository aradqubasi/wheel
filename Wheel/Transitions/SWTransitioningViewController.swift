//
//  SWTransitioningViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWTransitioningViewController: SWViewController {
    
    var backWithSwipeSegue: SWSegue!
    
    var backSegue: SWSegue!
    
    private var swiper: UIGestureRecognizer!
    
    private var transitioning = UIPercentDrivenInteractiveTransition()
    
    func interactionControllerForDismissal() -> UIViewControllerInteractiveTransitioning? {
        return self.transitioning
    }
    
    @IBAction func onSwipe(sender: SWDismissHistoryGestureRecognizer) {
        if sender.state == .began {
            perform(segue: self.backWithSwipeSegue)
        }
        else if sender.state == .changed {
            self.transitioning.update(sender.Progress)
        }
        else if sender.state == .cancelled {
            self.transitioning.cancel()
        }
        else if sender.state == .ended {
            self.transitioning.finish()
        }
    }
    
    @IBAction func onBackClick(sender: UIButton) {
        perform(segue: self.backSegue)
    }
}
