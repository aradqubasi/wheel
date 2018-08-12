//
//  SWAnimationTypes.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 12/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
enum SWAnimationTypes: String {
    case moveToSelectionWheelIngredient
    case moveToSelectionWheelFirstOpenKind
    case popingIngredientsAtSelectionWheel
    case fetchingIngredientsIntoSelectionWheel
    case movingIngredientCopiesToSelectionWheel
    case movingAllWheels
    case movingOneWheel
    case focusingWheel
    
    static func All() -> Set<SWAnimationTypes> {
        return [
            .moveToSelectionWheelIngredient,
            .moveToSelectionWheelFirstOpenKind,
            .popingIngredientsAtSelectionWheel,
            .fetchingIngredientsIntoSelectionWheel,
            .movingIngredientCopiesToSelectionWheel,
            .movingAllWheels,
            .movingOneWheel,
            .focusingWheel
        ]
    }
    
    static func AllSelectionWheelAnimations() -> Set<SWAnimationTypes> {
        return [
            .moveToSelectionWheelIngredient,
            .moveToSelectionWheelFirstOpenKind,
            .popingIngredientsAtSelectionWheel,
            .fetchingIngredientsIntoSelectionWheel,
            .movingIngredientCopiesToSelectionWheel
        ]
    }
}
