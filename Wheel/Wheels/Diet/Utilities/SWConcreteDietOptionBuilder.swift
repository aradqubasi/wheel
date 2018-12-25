//
//  SWConcreteDietOptionBuilder.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/12/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation

class SWConcreteDietOptionBuilder: SWDietOptionBuilder {
    
    private let options: SWOptionRepository
    
    private let userOptions: SWUserOptionRepository
    
    init(options: SWOptionRepository, userOptions: SWUserOptionRepository) {
        self.options = options
        self.userOptions = userOptions
    }
    
    func getOptions() -> [SWDietOption] {
        let userOptions = self.userOptions.getEntities()
        return [
            SWDietOption(name: "Gluten", active: #imageLiteral(resourceName: "diet/gluten"), inactive: #imageLiteral(resourceName: "diet/gluten"), color: .sandrift, background: .limedSpruce, userOption: userOptions.first(where: { $0.optionId == self.options.getNoGluten().id })!),
            SWDietOption(name: "Meat", active: #imageLiteral(resourceName: "diet/meat"), inactive: #imageLiteral(resourceName: "diet/meat"), color: .turkishrose, background: .limedSpruce, userOption: userOptions.first(where: { $0.optionId == self.options.getNoMeat().id })!),
            SWDietOption(name: "Fish", active: #imageLiteral(resourceName: "diet/fish"), inactive: #imageLiteral(resourceName: "diet/fish"), color: .wildblueyonder, background: .limedSpruce, userOption: userOptions.first(where: { $0.optionId == self.options.getNoFish().id })!),
            SWDietOption(name: "Dairy", active: #imageLiteral(resourceName: "diet/dairy"), inactive: #imageLiteral(resourceName: "diet/dairy"), color: .lavenderpurple, background: .limedSpruce, userOption: userOptions.first(where: { $0.optionId == self.options.getNoDairy().id })!),
            SWDietOption(name: "Shellfish", active: #imageLiteral(resourceName: "diet/shellfish"), inactive: #imageLiteral(resourceName: "diet/shellfish"), color: .lavenderpurple, background: .limedSpruce, userOption: userOptions.first(where: { $0.optionId == self.options.getNoShellfish().id })!),
            SWDietOption(name: "Eggs", active: #imageLiteral(resourceName: "diet/eggs"), inactive: #imageLiteral(resourceName: "diet/eggs"), color: .lavenderpurple, background: .limedSpruce, userOption: userOptions.first(where: { $0.optionId == self.options.getNoEggs().id })!)
        ]
    }
    
}
