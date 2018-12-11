//
//  SWOptionRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWOptionRepository {
    
    func getAll() -> [SWOption]
    
    func getAll(by type: SWOptionType) -> [SWOption]
    
    func getNoGluten() -> SWOption
    
    func getNoFish() -> SWOption
    
    func getNoMeat() -> SWOption
    
    func getNoDairy() -> SWOption
    
    func save(_ option: SWOption)
    
}
