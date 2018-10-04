//
//  SWConcreteFullIngredientRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 04/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteFullIngredientRepository: SWFullIngredientRepository {
    
    private let ingredients: SWIngredientRepository
    
    private let measuresments: SWMeasuresmentRepository
    
    private let stats: SWIngredientStats
    
    private let blockings: SWBlockingRepository
    
    private let options: SWOptionRepository
    
    init(ingredients: SWIngredientRepository, measuresments: SWMeasuresmentRepository, stats: SWIngredientStats, blockings: SWBlockingRepository, options: SWOptionRepository) {
        self.ingredients = ingredients
        self.measuresments = measuresments
        self.stats = stats
        self.blockings = blockings
        self.options = options
    }
    
    func getAll() -> [SWFullIngredient] {
        let full = ingredients
            .getAll()
            .join(with: measuresments.getAll(), on: {
                (inner: SWIngredient, outer: SWMeasuresment) -> Bool in
                return inner.unit == (outer.id ?? -1)
            }, as: {
                (inner: SWIngredient, outer: SWMeasuresment) -> (SWIngredient, SWMeasuresment) in
                return (inner, outer)
            })
        return []
    }

}
