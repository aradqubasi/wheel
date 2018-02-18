//
//  SWConcreteOnboardingAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteOnboardingAssembler: SWOnboardingAssembler {
    
    func resolve() -> SWWheelsAssembler {
        return SWConcreteWheelsAssembler()
    }
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
}
