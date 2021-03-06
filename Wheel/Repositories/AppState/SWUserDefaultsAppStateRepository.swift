//
//  SWUserDefaultsAppStateRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/09/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWUserDefaultsAppStateRepository: SWAppStateRepository {
    
    private static let keyShowOnboarding = "ShowOnboarding"
    
    private static let keyShowWalkthrough = "ShowWalkthrough"
    
    private static let keyInitializeDefaults = "InitializeDefaults"
    
    static let defaults: [String: Any] = [
        SWUserDefaultsAppStateRepository.keyShowOnboarding : true,
        SWUserDefaultsAppStateRepository.keyShowWalkthrough : true,
        SWUserDefaultsAppStateRepository.keyInitializeDefaults: true
    ]
    
    func get() -> SWAppState {
        return SWAppState(showOnboarding: UserDefaults.standard.bool(forKey: SWUserDefaultsAppStateRepository.keyShowOnboarding), showWalkthrough: UserDefaults.standard.bool(forKey: SWUserDefaultsAppStateRepository.keyShowWalkthrough), activeCookId: -1, initializeDefaults: UserDefaults.standard.bool(forKey: SWUserDefaultsAppStateRepository.keyInitializeDefaults))
    }
    
    func setShowOnboarding(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: SWUserDefaultsAppStateRepository.keyShowOnboarding)
    }
    
    func setShowWalkthrough(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: SWUserDefaultsAppStateRepository.keyShowWalkthrough)
    }
    
    func setInitializeDefaults(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: SWUserDefaultsAppStateRepository.keyInitializeDefaults)
    }
    
}
