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
    
    func resolve() -> SWSelectionWheelAssembler
    
}
