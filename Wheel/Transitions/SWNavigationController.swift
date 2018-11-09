//
//  SWNavigationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/05/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    // MARK: - Public Properties
    
    var assembler: SWNavigationAssembler!
    
    // MARK: - Private Properties
    
    private var segues: SWSegueRepository!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segues = assembler.resolve()
        delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print("shouldPerformSegue \(identifier)")
        return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
    }
    
    //MARK: - UINavigationControllerDelegate Methods
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("willShow \(viewController)")
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("didShow \(viewController)")
    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let current = segues.getCurrent() else {
            fatalError("no current segue specified")
        }
        switch current {
        case segues.getFilterToWheelsWithConfirm:
            return SWCompleteAnimationController()
        case segues.getStepsToRecipyWithConfirm:
            return SWCompleteAnimationController()
        case segues.getWheelsToOverlay:
            return SWShowOverlayAnimationController()
        case segues.getOverlayToWheels:
            return SWHideOverlayAnimationController()
        case segues.getOverlayToWheelsWithSelect:
            return SWPickingOverlayAnimationController()
        case segues.getWalkthroughToWheels:
            return SWHideWalkthroughAnimationController()
        case segues.getWheelsToHamburger:
            return SWShowHamburgerAnimationController()
        case segues.getHamburgerToWheelsWithSwipe:
            return SWHidingHamburgerAnimationController(fromVC as! HamburgerViewController)
        case segues.getHamburgerToWheelsForWalkthrough:
            return SWHideHamburgerAnimationController()
        case segues.getHamburgerToWheelsForHistory:
            return SWHideHamburgerAnimationController()
        case segues.getRecipyToWheels:
            return SWHideRecipyAnimationController()
        case segues.getRecipyToWheelsWithSwipe:
            return SWHidingRecipyAnimationController(fromVC as! RecipyViewController)
        case segues.getRecipyToHistory:
            return SWHideRecipyAnimationController()
        case segues.getRecipyToHistoryWithSwipe:
            return SWHidingRecipyAnimationController(fromVC as! RecipyViewController)
        case segues.getHistoryToWheels:
            return SWHideHistoryAnimationController()
        case segues.getHistoryToWheelsWithSwipe:
            return SWHidingHistoryAnimationController(fromVC as! HistoryViewController)
        case segues.getHamburgerToWheelsForDiet:
            return SWHideHamburgerAnimationController()
        case segues.getDietToWheels:
            return SWHideDietAnimationController()
        case segues.getDietToWheelsWithSwipe:
            return SWHidingDietAnimationController(fromVC as! DietViewController)
        default:
            if fromVC is StepsViewController && toVC is RecipyViewController {
                return SWDismissAnimationContorller(from: fromVC, to: toVC)
            }
//            else if fromVC is RecipyViewController && toVC is WheelsViewController {
//                return SWDismissAnimationContorller(from: fromVC, to: toVC)
//            }
            else if fromVC is FilterViewController && toVC is WheelsViewController {
                return SWDismissAnimationContorller(from: fromVC, to: toVC)
            }
            else if fromVC is WheelsViewController && toVC is WalkthroughViewController {
                return SWNoAnimationController()
            }
            else {
                return nil
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let dismiss = animationController as? SWDismissAnimationContorller {
            return dismiss.interactionController()
        }
        else if let dismiss = animationController as? SWHidingHamburgerAnimationController {
            return dismiss.interactionController()
        }
        else if let dismiss = animationController as? SWHidingHistoryAnimationController {
            return dismiss.interactionController()
        }
        else if let dismiss = animationController as? SWHidingRecipyAnimationController {
            return dismiss.interactionController()
        }
        else if let dismiss = animationController as? SWHidingDietAnimationController {
            return dismiss.interactionController()
        }
        return nil
    }

}
