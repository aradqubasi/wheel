//
//  SWConcreteNavigationAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 19/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteNavigationAssembler: SWNavigationAssembler {
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
}
