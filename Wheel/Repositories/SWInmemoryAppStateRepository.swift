//
//  SWInmemoryAppStateRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemoryAppStateRepository: SWAppStateRepository {
    
    func get() -> SWAppState {
        return SWAppState(showOnboarding: true)
    }
    
}
