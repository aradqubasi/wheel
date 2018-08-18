//
//  SWWalkthroughAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol SWWalkthroughAssembler {
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> UIView
    
    func resolve() -> SWAreaOfInterest
    
}
