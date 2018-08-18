//
//  SWInmemoryAppStateRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemoryAppStateRepository: SWAppStateRepository {
    
    private var state: SWAppState = SWAppState(showOnboarding: true, showWalkthrough: true)
    
    func get() -> SWAppState {
        return state
    }
    
    func setShowOnboarding(_ value: Bool) {
        state = SWAppState(showOnboarding: value, showWalkthrough: state.showWalkthrough)
    }
    
    func setShowWalkthrough(_ value: Bool) {
        state = SWAppState(showOnboarding: state.showOnboarding, showWalkthrough: value)
    }
    
}
