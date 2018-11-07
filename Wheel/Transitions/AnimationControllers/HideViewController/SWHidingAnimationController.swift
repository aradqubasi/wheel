//
//  SWHidingAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWHidingAnimationController: SWHideAnimationController {
    
    let controller: SWTransitioningViewController
    
    init(_ controller: SWTransitioningViewController) {
        self.controller = controller
        super.init()
    }
    
    func interactionController() -> UIViewControllerInteractiveTransitioning? {
        return self.controller.interactionControllerForDismissal()
    }
    
}
