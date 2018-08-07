//
//  SWConcreteSubwheelAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWConcreteSubwheelAssembler: SWSubwheelAssembler {
    
    private let background: UIView
    
    init(background: UIView) {
        self.background = background
    }
    
    /**get background*/
    func resolve() -> UIView {
        return background
    }
    
    func resolve() -> SWIngredientRepository {
        return SWInmemoryIngredientRepository()
    }
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve(semaphor: SWAnimationSemaphor) -> SWSelectionWheelAssembler {
        return SWConcreteSelectionWheelAssembler(semaphor: semaphor)
    }
}
