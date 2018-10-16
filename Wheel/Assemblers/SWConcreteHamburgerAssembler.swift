//
//  SWConcreteHamburgerAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 16/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWConcreteHamburgerAssembler: SWHamburgerAssembler {
    
    let background: UIView
    
    init(_ background: UIView) {
        self.background = background
    }
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> UIView {
        return self.background
    }
    
}
