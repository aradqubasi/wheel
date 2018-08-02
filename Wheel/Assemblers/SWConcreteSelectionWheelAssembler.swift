//
//  SWConcreteSelectionWheelAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteSelectionWheelAssembler: SWSelectionWheelAssembler {
    
    func resolve() -> SWTipController {
        return SWTipController()
    }
    
    func resolve() -> SWTipGenerator {
        return SWConcreteTipGenerator()
    }
    
}
