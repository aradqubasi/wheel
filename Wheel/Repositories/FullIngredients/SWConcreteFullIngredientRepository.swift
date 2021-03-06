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
    
    private let checked: SWUserOptionRepository
    
    private let biases: SWIngredientBiasRepository
    
    private let state: SWAppStateRepository
    
    init(ingredients: SWIngredientRepository, measuresments: SWMeasuresmentRepository, stats: SWIngredientStatsRepository, blockings: SWBlockingRepository, options: SWOptionRepository, checked: SWUserOptionRepository, biases: SWIngredientBiasRepository, state: SWAppStateRepository) {
        self.ingredients = ingredients
        self.measuresments = measuresments
        self.stats = stats
        self.blockings = blockings
        self.options = options
        self.checked = checked
        self.biases = biases
        self.state = state
    }
    
    func getAll() -> [SWFullIngredient] {
        return get(by: { _ in return true })
    }

    func get(by predicate: (_:SWIngredientKinds) -> Bool) -> [SWFullIngredient] {
        let full = ingredients
            .getAll()
            .filter({ return predicate($0.kind) })
            .join(with: measuresments.getAll(), on: {
                (inner: SWIngredient, outer: SWMeasuresment) -> Bool in
                return inner.unit == outer.id
            }, as: {
                (inner: SWIngredient, outer: SWMeasuresment) -> (SWIngredient, SWMeasuresment) in
                return (inner, outer)
            })
            .join(with: stats.getAll(), on: {
                (inner: (SWIngredient, SWMeasuresment), outer: SWIngredientStats) -> Bool in
                return inner.0.id == outer.ingredientId && inner.1.id == outer.measuresmentId
            }, as: {
                (inner: (SWIngredient, SWMeasuresment), outer: SWIngredientStats) -> (SWIngredient, SWMeasuresment, SWIngredientStats) in
                return (inner.0, inner.1, outer)
            })
            .leftjoin(with: biases
                .getAll()
                .filter({
                    $0.cookId == self.state.get().activeCookId
                }
            ), on: {
                (inner: (SWIngredient, SWMeasuresment, SWIngredientStats), outer: SWIngredientBias?) -> Bool in
                return inner.0.id == outer?.ingredientId
            }, as: {
                (inner: (SWIngredient, SWMeasuresment, SWIngredientStats), outer: SWIngredientBias?) -> (SWIngredient, SWMeasuresment, SWIngredientStats, SWIngredientBias?) in
                return (inner.0, inner.1, inner.2, outer)
            })
            .map({
                (tuple: (SWIngredient, SWMeasuresment, SWIngredientStats, SWIngredientBias?)) -> SWFullIngredient in
                let isBlocked = self.blockings.getAll(by: tuple.0).contains(where: {
                    block in
//                    self.options.getAll().contains(where: {
//                        option in
//                        return option.checked
//                            && block.optionId == option.id
//                            && block.ingredientId == tuple.0.id
//                    })
                    return self.checked.getEntities().contains(where: { $0.optionId == block.optionId && !$0.checked }) && block.ingredientId == tuple.0.id
                })
                let bias = tuple.3?.value ?? 1
                return SWFullIngredient(ingredient: tuple.0, measure: tuple.1, stats: tuple.2, isBlocked: isBlocked, bias: bias)
            })
        
        return full
    }
}
