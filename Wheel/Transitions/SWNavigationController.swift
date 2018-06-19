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
//        print("navigation")
//        print("\(operation == .pop ? "pop" : operation == .push ? "push" : "something")")
//        if fromVC is SWDismissableViewController && operation == .pop {
//            return SWDismissAnimationContorller(from: fromVC, to: toVC)
//        }
//        else {
//            return nil
//        }
        
        if segues.getCurrent()?.identifier ?? "" == segues.getFilterToWheelsWithConfirm().identifier {
            return SWCompleteAnimationController(from: fromVC, to: toVC)
        }
        else if fromVC is StepsViewController && toVC is RecipyViewController {
            return SWDismissAnimationContorller(from: fromVC, to: toVC)
        }
        else if fromVC is RecipyViewController && toVC is WheelsViewController {
            return SWDismissAnimationContorller(from: fromVC, to: toVC)
        }
        else if fromVC is FilterViewController && toVC is WheelsViewController {
            return SWDismissAnimationContorller(from: fromVC, to: toVC)
        }
        else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let dismiss = animationController as? SWDismissAnimationContorller {
            return dismiss.interactionController()
        }
        return nil
    }

}
