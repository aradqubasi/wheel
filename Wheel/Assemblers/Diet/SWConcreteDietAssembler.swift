//
//  SWConcreteDietAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWConcreteDietAssembler: SWDietAssembler {
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> SWPieAssembler {
        return SWConcretePieAssembler()
    }
    
    func resolve() -> SWDietSettingsRepository {
        return SWPersistantDietSettingsRepository()
    }
    
    func resolve() -> SWDietSettingsViewModelRepository {
        return SWPersistantDietSettingsViewModelRepository()
    }
    
}
