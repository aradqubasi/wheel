//
//  SWConcreteModelHelper.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteModelHelper: SWModelHelper {
    
    private func getRank(of ingredient: SWIngredient) -> Int {
        if ingredient.kind == .fruits {
            return 0
        }
        else if ingredient.kind == .dressing {
            return 0
        }
        else if ingredient.kind == .unexpected {
            return 0
        }
        else if ingredient.kind == .protein {
            return 1
        }
        else if ingredient.kind == .veggy {
            return 2
        }
        else if ingredient.kind == .fat {
            return 3
        }
        else if ingredient.kind == .base {
            return 4
        }
        return 0
    }
    
    func getKindComparer() -> (_: SWIngredient, _: SWIngredient) -> Bool {
        return {
            (_ prev: SWIngredient, _ next: SWIngredient) -> Bool in
            return self.getRank(of: next) > self.getRank(of: prev)
        }
    }
    
}
