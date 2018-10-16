//
//  SWWheelAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWWheelsAssembler {
    
    func resolve() -> SWIngredientRepository
    
    func resolve() -> SWBlockingRepository
    
    func resolve() -> SWOptionRepository
    
    func resolve() -> SWWheelPositionCalculator
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> SWRecipyAssembler
    
    func resolve() -> SWWheelsAligner
    
    func resolve() -> SWTipGenerator
    
    func resolve() -> SWFilterAssembler
    
    func resolve() -> SWOverlayAssembler
    
    func resolve() -> SWIngredientsFilter
    
    func resolve(using background: UIView) -> SWSubwheelAssembler
    
    func resolve(semaphor: SWAnimationSemaphor) -> SWSelectionWheelAssembler
    
    func resolve() -> SWAppStateRepository
    
    func resolve(from controller: UIViewController, areas: SWAreasOfInterest) -> SWWalkthroughAssembler
    
    func resolve() -> SWCheifCook
    
    func resolve(bases: SWAbstractWheelController, fats: SWAbstractWheelController, veggies: SWAbstractWheelController, proteins: SWAbstractWheelController, unexpected: UIButton, fruits: UIButton, dressings: UIButton, scene: UIView) -> SWWheelsAnimationHelper
    
    func resolve() -> SWModelHelper
    
    func resolve(using background: UIView) -> SWHamburgerAssembler
    
}
