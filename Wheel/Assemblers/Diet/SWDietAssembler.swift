//
//  SWDietAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWDietAssembler {
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> SWPieAssembler
    
    func resolve() -> SWDietSettingsRepository
    
    func resolve() -> SWDietSettingsViewModelRepository
    
    func resolve() -> SWDietOptionBuilder
    
    func resolve() -> SWUserOptionRepository
    
}
