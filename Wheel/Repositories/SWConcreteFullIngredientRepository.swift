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
    
    private let stats: SWIngredientStatsRepository
    
    private let blockings: SWBlockingRepository
    
    private let options: SWOptionRepository
    
    init(ingredients: SWIngredientRepository, measuresments: SWMeasuresmentRepository, stats: SWIngredientStatsRepository, blockings: SWBlockingRepository, options: SWOptionRepository) {
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
                return inner.unit == outer.id
            }, as: {
                (inner: SWIngredient, outer: SWMeasuresment) -> (SWIngredient, SWMeasuresment) in
                return (inner, outer)
            })
            .join(with: stats.getAll(), on: {
                (inner: (SWIngredient, SWMeasuresment), outer: SWIngredientStats) -> Bool in
                return inner.0.id == outer.ingredientId
            }, as: {
                (inner: (SWIngredient, SWMeasuresment), outer: SWIngredientStats) -> (SWIngredient, SWMeasuresment, SWIngredientStats) in
                return (inner.0, inner.1, outer)
            })
            .map({
                (tuple: (SWIngredient, SWMeasuresment, SWIngredientStats)) -> SWFullIngredient in
                let isBlocked = self.blockings.getAll(by: tuple.0).contains(where: {
                    block in
                    self.options.getAll().contains(where: {
                        option in
                        return option.checked
                            && block.optionId == option.id
                            && block.ingredientId == tuple.0.id
                    })
                })
                return SWFullIngredient(ingredient: tuple.0, measure: tuple.1, stats: tuple.2, isBlocked: isBlocked)
            })
        return full
    }

}
