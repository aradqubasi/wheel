//
//  SWSegueRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWSegueRepository {
    func getAfterlaunchToOnboarding() -> SWSegue
    
    func getAfterlaunchToWheels() -> SWSegue
    
    func getOnboardingToWheels() -> SWSegue
    
    func getWheelsToRecipy() -> SWSegue
    
    func getWheelsToFilter() -> SWSegue
    
    func getRecipyToWheels() -> SWSegue
    
    func getRecipyToWheelsWithSwipe() -> SWSegue
    
    func getRecipyToSteps() -> SWSegue
    
    func getStepsToRecipy() -> SWSegue
    
    func getStepsToRecipyWithSwipe() -> SWSegue
    
    func getFilterToWheels() -> SWSegue
    
    func getFilterToWheelsWithSwipe() -> SWSegue
    
    func set(current segue: SWSegue) -> Void
    
    func getCurrent() -> SWSegue?
    
    func getFilterToWheelsWithConfirm() -> SWSegue
    
    func getStepsToRecipyWithConfirm() -> SWSegue
    
    func getWheelsToOverlay() -> SWSegue
    
    func getOverlayToWheels() -> SWSegue
    
    func getOverlayToWheelsWithSelect() -> SWSegue
    
    func getWheelsToSubwheel() -> SWSegue
    
    func getWheelsToWalkthrough() -> SWSegue
    
    func getWalkthroughToWheels() -> SWSegue
    
}
