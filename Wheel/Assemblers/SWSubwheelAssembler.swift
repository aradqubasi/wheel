//
//  SWSubwheelAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWSubwheelAssembler {
    
    /**get background*/
    func resolve() -> UIView
    
    func resolve() -> SWIngredientRepository
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> SWSelectionWheelAssembler
    
}
