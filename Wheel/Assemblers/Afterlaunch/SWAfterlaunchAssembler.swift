//
//  SWOnboardingAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWAfterlaunchAssembler {
    
    func resolve() -> SWAppStateRepository
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> SWWheelsAssembler
    
    func resolve() -> SWOnboardingAssembler
    
    func resolve() -> SWNavigationAssembler
    
    func resolve() -> SWDietSettingsRepository
    
    func resolve() -> SWUserOptionRepository
    
    func resolve() -> SWOptionRepository
    
}
