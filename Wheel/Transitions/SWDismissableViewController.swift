//
//  SWDismissableViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol SWDismissableViewController {
    
    func interactionControllerForDismissal() -> UIViewControllerInteractiveTransitioning?
    
}
