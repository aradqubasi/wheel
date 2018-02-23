//
//  SWConcreteWheelsAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteWheelsAssembler: SWWheelsAssembler {
    
    func resolve() -> SWIngredientRepository {
        return SWInmemoryIngredientRepository()
    }
    
    func resolve() -> SWBlockingRepository {
        return SWInmemoryBlockingRepoitory()
    }
    
    func resolve() -> SWOptionRepository {
        return SWInmemoryOptionRepository()
    }
    
    func resolve() -> SWWheelPositionCalculator {
        return SWConcreteWheelPositionCalculator()
    }
    
}
