//
//  SWSelectionWheelAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWSelectionWheelAssembler {
    
    func resolve() -> SWTipController
    
    func resolve() -> SWTipGenerator
    
    func resolve() -> SWAnimationSemaphor
    
    func resolve() -> SWModelHelper
    
}
