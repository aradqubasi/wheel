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
    
    var interactionController: UIViewControllerInteractiveTransitioning?
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if fromVC is StepsViewController && toVC is RecipyViewController {
            print("from StepsViewController to RecipyViewController")
            return SWDismissAnimationContorller(from: fromVC, to: toVC)
        }
        else {
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if navigationController.topViewController is StepsViewController {
            print("presentedViewController is StepsViewController")
        }
        else if navigationController.topViewController is RecipyViewController {
            print("presentedViewController is RecipyViewController")
        }
        else {
            print("presentedViewController is something")
        }
        
        if navigationController.topViewController is RecipyViewController && animationController is SWDismissAnimationContorller {
            return (animationController as! SWDismissAnimationContorller).interactionController()
        }
        return nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
