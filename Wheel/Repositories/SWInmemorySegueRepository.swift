//
//  SWImnmemorySegueRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemorySegueRepository: SWSegueRepository {
    
    func getOnboardingToWheels() -> SWSegue {
        return SWSegue(identifier: "OnboardingToWheels")
    }

    func getAfterlaunchToOnboarding() -> SWSegue {
        return SWSegue(identifier: "AfterlaunchToOnboarding")
    }
    
    func getAfterlaunchToWheels() -> SWSegue {
        return SWSegue(identifier: "AfterlaunchToWheels")
    }
    
    
}
