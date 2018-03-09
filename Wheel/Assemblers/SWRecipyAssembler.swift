//
//  SWRecipyAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWRecipyAssembler {
    
    func resolve() -> SWRecipyRepository
    
    func resolve() -> SWComponentRepository
    
    func resolve() -> SWNameGenerator
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> SWMeasuresmentRepository
    
    func resolve() -> SWIngredientStatsRepository
    
    func resolve() -> SWServingsGenerator
    
    func resolve() -> SWRecipyListGenerator
    
}
