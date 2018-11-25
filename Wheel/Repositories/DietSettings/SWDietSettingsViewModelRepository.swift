//
//  SWDietSettingsViewModelRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWDietSettingsViewModelRepository {
    
    func get(by id: Int) -> SWDietSettingsViewModel?
    
    func upsert(_ value: SWDietSettingsViewModel) -> Void
    
}
