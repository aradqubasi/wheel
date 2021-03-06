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
    
    func getStepsToRecipyWithConfirm() -> SWSegue {
        return SWSegue(identifier: "StepsToRecipyWithConfirm")
    }
    
    func getWheelsToOverlay() -> SWSegue {
        return SWSegue(identifier: "WheelsToOverlay")
    }
    
    func getOverlayToWheels() -> SWSegue {
        return SWSegue(identifier: "OverlayToWheels")
    }
    
    func getOverlayToWheelsWithSelect() -> SWSegue {
        return SWSegue(identifier: "OverlayToWheelsWithSelect")
    }
    
    func getWheelsToSubwheel() -> SWSegue {
        return SWSegue(identifier: "WheelsToSubwheel")
    }
    
    func getWheelsToWalkthrough() -> SWSegue {
        return SWSegue(identifier: "WheelsToWalkthrough")
    }
    
    func getWalkthroughToWheels() -> SWSegue {
        return SWSegue(identifier: "WalkthroughToWheels")
    }
    
    func getWheelsToHamburger() -> SWSegue {
        return SWSegue(identifier: "WheelsToHamburger")
    }
    
    func getHamburgerToWheelsWithSwipe() -> SWSegue {
        return SWSegue(identifier: "HamburgerToWheelsWithSwipe")
    }
    
    func getHamburgerToWheelsForWalkthrough() -> SWSegue {
        return SWSegue(identifier: "HamburgerToWheelsForWalkthrough")
    }
    
    func getWheelsToHistory() -> SWSegue {
        return SWSegue(identifier: "WheelsToHistory")
    }
    
    func getHistoryToWheels() -> SWSegue {
        return SWSegue(identifier: "HistoryToWheels")
    }
    
    func getHamburgerToWheelsForHistory() -> SWSegue {
        return SWSegue(identifier: "HamburgerToWheelsForHistory")
    }
    
    func getHistoryToWheelsWithSwipe() -> SWSegue {
        return SWSegue(identifier: "HistoryToWheelsWithSwipe")
    }
    
    func getHistoryToRecipy() -> SWSegue {
        return SWSegue(identifier: "HistoryToRecipy")
    }
    
    func getRecipyToHistory() -> SWSegue {
        return SWSegue(identifier: "RecipyToHistory")
    }
    
    func getRecipyToHistoryWithSwipe() -> SWSegue {
        return SWSegue(identifier: "RecipyToHistoryWithSwipe")
    }
    
    func getHamburgerToWheelsForDiet() -> SWSegue {
        return SWSegue(identifier: "HamburgerToWheelsForDiet")
    }
    
    func getWheelsToDiet() -> SWSegue {
        return SWSegue(identifier: "WheelsToDiet")
    }
    
    func getDietToWheels() -> SWSegue {
        return SWSegue(identifier: "DietToWheels")
    }
    
    func getDietToWheelsWithSwipe() -> SWSegue {
        return SWSegue(identifier: "DietToWheelsWithSwipe")
    }
    
    func getHamburgerToWheels() -> SWSegue {
        return SWSegue(identifier: "HamburgerToWheels")
    }
    
    func getWheelsToRecipyByBookmark() -> SWSegue {
        return SWSegue(identifier: "WheelsToRecipyByBookmark")
    }
}
