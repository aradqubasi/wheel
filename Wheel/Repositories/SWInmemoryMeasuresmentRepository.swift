//
//  SWInmemoryMeasursmentRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemoryMeasuresmentRepository: SWMeasuresmentRepository {
    
    private static let _measuresments: [SWMeasuresment] = [
        SWMeasuresment(id: 1, name: "gram", short: "g"),
        SWMeasuresment(id: 2, name: "serving", short: "serving"),
        SWMeasuresment(id: 3, name: "table spoon", short: "tbsp"),
        SWMeasuresment(id: 4, name: "100 grams", short: "100g"),
        SWMeasuresment(id: 5, name: "kilocalories", short: "kcals"),
        SWMeasuresment(id: 6, name: "leaf", short: "leaf"),
        SWMeasuresment(id: 7, name: "cup", short: "cup"),
        SWMeasuresment(id: 8, name: "piece", short: "piece"),
        SWMeasuresment(id: 9, name: "ounce", short: "oz"),
        SWMeasuresment(id: 10, name: "medium", short: ""),
        SWMeasuresment(id: 11, name: "slice", short: "slice"),
        SWMeasuresment(id: 12, name: "cube", short: "cube")
    ]
    
    func getAll() -> [SWMeasuresment] {
        return SWInmemoryMeasuresmentRepository._measuresments
    }
    
    func get(by id: Int) -> SWMeasuresment {
        return SWInmemoryMeasuresmentRepository._measuresments.first(where: { $0.id == id })!
    }
    
    func get100g() -> SWMeasuresment {
        return SWInmemoryMeasuresmentRepository._measuresments.first(where: { $0.name == "100 grams" })!
    }
    
    func getServing() -> SWMeasuresment {
        return SWInmemoryMeasuresmentRepository._measuresments.first(where: { $0.name == "serving" })!
    }
    
    func getTableSpoon() -> SWMeasuresment {
        return SWInmemoryMeasuresmentRepository._measuresments.first(where: { $0.name == "table spoon" })!
    }
    
    func getCalories() -> SWMeasuresment {
        return SWInmemoryMeasuresmentRepository._measuresments.first(where: { $0.name == "kilocalories" })!
    }
    
    func getGram() -> SWMeasuresment {
        return SWInmemoryMeasuresmentRepository._measuresments.first(where: { $0.name == "gram" })!
    }
}
