//
//  SWConcreteWalkthroughAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWConcreteWalkthroughAssembler: SWWalkthroughAssembler {

    private var background: UIView
    
    private let selectionWheel: SWAreaOfInterest
    
    private let rollButton: SWAreaOfInterest
    
    private let filtersButton: SWAreaOfInterest
    
    private let cookButton: SWAreaOfInterest
    
    init(background: UIView, selectionWheel: SWAreaOfInterest, rollButton: SWAreaOfInterest, filtersButton: SWAreaOfInterest, cookButton: SWAreaOfInterest) {
        self.background = background
        self.selectionWheel = selectionWheel
        self.rollButton = rollButton
        self.filtersButton = filtersButton
        self.cookButton = cookButton
    }
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> UIView {
        return background
    }
    
}

