//
//  SWAppStateRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWAppStateRepository {
    
    func get() -> SWAppState
    
    func setShowOnboarding(_ value: Bool)
    
    func setShowWalkthrough(_ value: Bool)
    
    func setInitializeDefaults(_ value: Bool)
    
}
