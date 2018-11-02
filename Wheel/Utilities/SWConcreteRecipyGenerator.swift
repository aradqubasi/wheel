//
//  SWConcreteRecipyGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteRecipyGenerator: SWRecipyGenerator {
    
    var recipies: SWRecipyRepository
    
    var naming: SWNameGenerator
    
    var calculator: SWServingsGenerator
    
    init(_ recipies: SWRecipyRepository, _ naming: SWNameGenerator, _ calculator: SWServingsGenerator) {
        self.recipies = recipies
        self.naming = naming
        self.calculator = calculator
    }
    
    func generate(_ selection: [SWIngredient], servings: Int) -> SWRecipy {
        var recipy = recipies.create()
        recipy.ingredients = selection.map({ $0.id! })
        recipy.name = self.naming.getName(for: selection)
        recipy.calories = self.calculator.getEnergy(for: selection, per: 1)
        recipy.carbohydrates = self.calculator.getCarbs(for: selection, per: 1)
        recipy.proteins = self.calculator.getProteins(for: selection, per: 1)
        recipy.fats = self.calculator.getFats(for: selection, per: 1)
        recipy.servings = servings
        return recipy
    }
    
}
