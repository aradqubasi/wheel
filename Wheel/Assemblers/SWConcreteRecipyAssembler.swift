//
//  SWConcreteRecipyAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteRecipyAssembler: SWRecipyAssembler {
    
    func resolve() -> SWRecipyRepository {
        return SWInmemoryRecipyRepository()
    }
    
    func resolve() -> SWNameGenerator {
        return SWProtebaseNameGenerator()
    }
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> SWMeasuresmentRepository {
        return SWInmemoryMeasuresmentRepository()
    }
    
    func resolve() -> SWIngredientStatsRepository {
        return SWInmemoryIngredientStatsRepository()
    }
    
    func resolve() -> SWServingsGenerator {
        return SWConcreteServingsGenerator(measuresment: self.resolve(), stats: self.resolve())
    }
    
    func resolve() -> SWRecipyListGenerator {
        return SWConcreteRecipyListGenerator(measuresment: self.resolve())
    }
    
    func resolve() -> SWStepsAssembler {
        return SWConcreteStepsAssembler()
    }
}
