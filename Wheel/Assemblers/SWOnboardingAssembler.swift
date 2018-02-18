//
//  SWOnboardingAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWOnboardingAssembler {
    
    func resolve() -> SWWheelsAssembler
    
    func resolve() -> SWSegueRepository
    
}
