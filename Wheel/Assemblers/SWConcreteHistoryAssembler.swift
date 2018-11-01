//
//  SWConcreteHistoryRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 26/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWConcreteHistoryAssembler: SWHistoryAssembler {
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> SWRecipyRepository {
        return SWPersistantRecipyRepository()
    }
    
    func resolve() -> SWHistoryCellAligner {
        return SWConcreteHistoryCellAligner(SWConcreteDateStringifier())
    }
}

