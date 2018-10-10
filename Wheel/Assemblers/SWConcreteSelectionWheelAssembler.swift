//
//  SWConcreteSelectionWheelAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteSelectionWheelAssembler: SWSelectionWheelAssembler {
    
    private var semaphor: SWAnimationSemaphor
    
    init(semaphor: SWAnimationSemaphor) {
        self.semaphor = semaphor
    }
    
    func resolve() -> SWTipController {
        return SWTipController()
    }
    
    func resolve() -> SWTipGenerator {
        return SWConcreteTipGenerator()
    }
    
    func resolve() -> SWAnimationSemaphor {
        return self.semaphor
    }
    
    func resolve() -> SWModelHelper {
        return SWConcreteModelHelper()
    }
    
}
