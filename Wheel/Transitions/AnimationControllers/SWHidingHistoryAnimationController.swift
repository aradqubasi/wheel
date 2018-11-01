//
//  SWHidingHistoryAnimationController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 31/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWHidingHistoryAnimationController: SWHideHistoryAnimationController {
    
    let controller: HistoryViewController
    
    init(_ controller: HistoryViewController) {
        self.controller = controller
        super.init()
    }
    
    func interactionController() -> UIViewControllerInteractiveTransitioning? {
        return self.controller.interactionControllerForDismissal()
    }
    
}
