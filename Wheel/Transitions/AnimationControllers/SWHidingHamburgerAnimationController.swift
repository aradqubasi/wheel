//
//  SWHidingHamburgerAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWHidingHamburgerAnimationController: SWHideHamburgerAnimationController {
    
    let controller: HamburgerViewController
    
    init(_ controller: HamburgerViewController) {
        self.controller = controller
        super.init()
    }
    
    func interactionController() -> UIViewControllerInteractiveTransitioning? {
        return self.controller.interactionControllerForDismissal()
    }
    
}
