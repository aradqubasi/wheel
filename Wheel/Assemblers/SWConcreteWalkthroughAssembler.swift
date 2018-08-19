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
    
    private let areas: SWAreasOfInterest
    
    init(background: UIView, areas: SWAreasOfInterest) {
        self.background = background
        self.areas = areas
    }
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> UIView {
        return background
    }
    
    func resolve() -> SWAreasOfInterest {
        return areas
    }
    
}

