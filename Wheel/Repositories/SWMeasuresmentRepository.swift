//
//  SWMeasuermentsRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWMeasuresmentRepository {
    
    func getAll() -> [SWMeasuresment]
    
    func get(by id: Int) -> SWMeasuresment
    
    func get100g() -> SWMeasuresment
    
    func getServing() -> SWMeasuresment
    
    func getTableSpoon() -> SWMeasuresment
    
    func getCalories() -> SWMeasuresment
    
    func getGram() -> SWMeasuresment
    
}
