//
//  SWFeedbackService.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWFeedbackService {
    
    func requestStepsFunctionality() -> Void
    
    func requestStepsFunctionality(contact email: String) -> Void
    
}
