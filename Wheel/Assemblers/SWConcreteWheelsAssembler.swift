//
//  SWConcreteWheelsAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
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
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> SWRecipyAssembler {
        return SWConcreteRecipyAssembler()
    }
    
    func resolve() -> SWWheelsAligner {
        let size = UIScreen.main.bounds.size
        switch size.width {
        case 0..<414:
            return SWNarrowWheelsAligner()
        case 414..<1000:
            return SWWideWheelsAligner()
        default:
            fatalError("can not choose aligner for device \(size)")
        }
    }
    
    func resolve() -> SWTipGenerator {
        return SWConcreteTipGenerator()
    }
    
    func resolve() -> SWFilterAssembler {
        return SWConcreteFilterAssembler()
    }
    
    func resolve() -> SWOverlayAssembler {
        return SWConcreteOverlayAssembler()
    }
    
    func resolve() -> SWIngredientsFilter {
        return SWConcreteIngredientsFilter(ingredients: resolve(), options: resolve(), blockings: resolve())
    }
    
    func resolve(using background: UIView) -> SWSubwheelAssembler {
        return SWConcreteSubwheelAssembler(background: background)
    }
}
