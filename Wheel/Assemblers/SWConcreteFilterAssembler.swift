//
//  SWConcreteFilterAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 22/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteFilterAssembler: SWFilterAssembler {
    
    func resolve() -> SWOptionRepository {
        return SWInmemoryOptionRepository()
    }
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
}
