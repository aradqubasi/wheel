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
    
    init(options: SWOptionRepository) {
        self.options = options
    }
    
    func getOptions() -> [SWDietOption] {
        return [
            SWDietOption(name: "Gluten", active: #imageLiteral(resourceName: "diet/gluten"), inactive: #imageLiteral(resourceName: "diet/gluten"), color: .sandrift, background: .limedSpruce, option: options.getNoGluten(), options: self.options),
            SWDietOption(name: "Meat", active: #imageLiteral(resourceName: "diet/meat"), inactive: #imageLiteral(resourceName: "diet/meat"), color: .turkishrose, background: .limedSpruce, option: options.getNoMeat(), options: self.options),
            SWDietOption(name: "Fish", active: #imageLiteral(resourceName: "diet/fish"), inactive: #imageLiteral(resourceName: "diet/fish"), color: .wildblueyonder, background: .limedSpruce, option: options.getNoFish(), options: self.options),
            SWDietOption(name: "Dairy", active: #imageLiteral(resourceName: "diet/dairy"), inactive: #imageLiteral(resourceName: "diet/dairy"), color: .lavenderpurple, background: .limedSpruce, option: options.getNoDairy(), options: self.options)
        ]
    }
    
}
