//
//  SWConcreteServingsCaptionGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteServingsGenerator: SWServingsGenerator {
    
    private var _measuresment: SWMeasuresmentRepository!
    
    private var _stats: SWIngredientStatsRepository!
    
    init(measuresment: SWMeasuresmentRepository, stats: SWIngredientStatsRepository) {
        _measuresment = measuresment
        _stats = stats
    }
    
    func getCaption(for quantity: Int) -> String {
        switch quantity {
        case Int.min...0:
            return "0 Servings"
        case 1:
            return "1 Serving"
        case 2...Int.max:
            return "\(quantity) Servings"
        default:
            fatalError("Unimplemented case quantity = \(quantity)")
        }
    }
    
    func getEnergy(for selection: [SWIngredient], per servings: Int) -> Double {
        return calculate(for: selection, per: servings, from: { $0.calories })
    }
    
    func getFats(for selection: [SWIngredient], per servings: Int) -> Double {
        return calculate(for: selection, per: servings, from: { $0.fats })
    }
    
    func getProteins(for selection: [SWIngredient], per servings: Int) -> Double {
        return calculate(for: selection, per: servings, from: { $0.proteins })
    }
    
    func getCarbs(for selection: [SWIngredient], per servings: Int) -> Double {
        return calculate(for: selection, per: servings, from: { $0.carbohydrates })
    }
    
    // MARK: - Private Methods
    
    private func calculate(for selection: [SWIngredient], per servings: Int, from selector: (_:SWIngredientStats) -> Double) -> Double {
        var quantity: Double = 0
        do {
            for ingredient in selection {
                let unit = _measuresment.get(by: ingredient.unit)
                let stats = _stats.get(by: ingredient, and: unit)
                quantity += selector(stats) * Double(servings)
            }
        }
        return quantity
    }
    
}
