//
//  SWConcreteStepsAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteStepsAssembler: SWStepsAssembler {
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> SWFeedbackService {
        return SWFeedbackOverHttpService()
    }
    
}
