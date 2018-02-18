//
//  SWConcreteOnboardingAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteAfterlaunchAssembler: SWAfterlaunchAssembler {
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> SWAppStateRepository {
        return SWInmemoryAppStateRepository()
    }
    
    func resolve() -> SWWheelsAssembler {
        return SWConcreteWheelsAssembler()
    }
    
    func resolve() -> SWOnboardingAssembler {
        return SWConcreteOnboardingAssembler()
    }
    
}
