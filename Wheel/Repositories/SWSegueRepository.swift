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
    
    func getRecipyToSteps() -> SWSegue
    
    func getStepsToRecipy() -> SWSegue
    
    func getFilterToWheels() -> SWSegue
    
    func getFilterToWheelsWithAnimation() -> SWSegue
    
}
