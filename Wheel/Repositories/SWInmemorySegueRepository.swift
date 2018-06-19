//
//  SWImnmemorySegueRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemorySegueRepository: SWSegueRepository {

    private static var current: SWSegue?
    
    func getOnboardingToWheels() -> SWSegue {
        return SWSegue(identifier: "OnboardingToWheels")
    }

    func getAfterlaunchToOnboarding() -> SWSegue {
        return SWSegue(identifier: "AfterlaunchToOnboarding")
    }
    
    func getAfterlaunchToWheels() -> SWSegue {
        return SWSegue(identifier: "AfterlaunchToWheels")
    }
    
    func getWheelsToRecipy() -> SWSegue {
        return SWSegue(identifier: "WheelsToRecipy")
    }
    
    func getWheelsToFilter() -> SWSegue {
        return SWSegue(identifier: "WheelsToFilter")
    }
    
    func getRecipyToWheels() -> SWSegue {
        return SWSegue(identifier: "RecipyToWheels")
    }
    
    func getRecipyToWheelsWithSwipe() -> SWSegue {
        return SWSegue(identifier: "RecipyToWheelsWithSwipe")
    }
    
    func getRecipyToSteps() -> SWSegue {
        return SWSegue(identifier: "RecipyToSteps")
    }
    
    func getStepsToRecipy() -> SWSegue {
        return SWSegue(identifier: "StepsToRecipy")
    }
    
    func getStepsToRecipyWithSwipe() -> SWSegue {
        return SWSegue(identifier: "StepsToRecipyWithSwipe")
    }
    
    func getFilterToWheels() -> SWSegue {
        return SWSegue(identifier: "FilterToWheels")
    }
    
    
    func getFilterToWheelsWithSwipe() -> SWSegue {
        return SWSegue(identifier: "FilterToWheelsWithSwipe")
    }
    
    func set(current segue: SWSegue) {
        SWInmemorySegueRepository.current = segue
    }
    
    func getCurrent() -> SWSegue? {
        return SWInmemorySegueRepository.current
    }
    
    func getFilterToWheelsWithConfirm() -> SWSegue {
        return SWSegue(identifier: "FilterToWheelsWithConfirm")
    }
}
