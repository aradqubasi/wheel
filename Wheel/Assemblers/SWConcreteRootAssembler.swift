//
//  SWConcreteRootAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteRootAssembler: SWRootAssembler {
    
    func resolve() -> SWOptionRepository {
        return SWInmemoryOptionRepository()
    }
    
}
