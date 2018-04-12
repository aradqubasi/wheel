//
//  SWStepsAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWStepsAssembler {
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> SWFeedbackService
    
}
