//
//  SWFeedbackOverHttpService.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWFeedbackOverHttpService: SWFeedbackService {
    
    func requestStepsFunctionality() -> Void {
        print("steps requested")
    }
    
    func requestStepsFunctionality(contact email: String) -> Void {
        print("steps requested, contact @ \(email)")
    }
    
}
