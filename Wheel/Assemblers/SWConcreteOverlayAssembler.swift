//
//  SWConcreteOverlayAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWConcreteOverlayAssembler: SWOverlayAssembler {
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> SWIngredientsFilter {
        return SWConcreteIngredientsFilter(ingredients: SWInmemoryIngredientRepository(), options: SWInmemoryOptionRepository(), blockings: SWInmemoryBlockingRepoitory())
    }
    
    func resolve() -> SWWheelsAligner {
        let size = UIScreen.main.bounds.size
//        UIDevice.current.model
        switch size.width {
        case 0..<414:
            return SWNarrowWheelsAligner()
        case 414..<1000:
            return SWWideWheelsAligner()
        default:
            fatalError("can not choose aligner for device \(size)")
        }
    }
    
}
