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
        return SWPersistantRecipyRepository()
    }
    
//    func resolve() -> SWNameGenerator {
//        return SWProtebaseNameGenerator()
//    }
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> SWMeasuresmentRepository {
        return SWInmemoryMeasuresmentRepository()
    }

//    func resolve() -> SWIngredientStatsRepository {
//        return SWInmemoryIngredientStatsRepository()
//    }
    
    func resolve() -> SWServingsGenerator {
        return SWConcreteServingsGenerator(
            measuresment: SWInmemoryMeasuresmentRepository(),
            stats: SWInmemoryIngredientStatsRepository())
    }
    
    func resolve() -> SWRecipyListGenerator {
        return SWConcreteRecipyListGenerator(measuresment: SWInmemoryMeasuresmentRepository())
    }
    
    func resolve() -> SWStepsAssembler {
        return SWConcreteStepsAssembler()
    }
    
    func resolve() -> SWIngredientRepository {
        return SWInmemoryIngredientRepository()
    }
}
