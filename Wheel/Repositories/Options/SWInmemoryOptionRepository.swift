//
//  InmemorySWOptionRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWInmemoryOptionRepository : SWOptionRepository {
    
    private static var _options: [SWOption] = [
        SWOption(1, "Vegan", of: .ingredient),
        SWOption(2, "Vegeterian", of: .ingredient),
        SWOption(3, "Percetarian", of: .ingredient),
        SWOption(4, "Gluten intolerant", of: .allergy),
        SWOption(5, "Wheat intolerant", of: .allergy),
        SWOption(6, "Lactose intolerant", of: .allergy),
        SWOption(7, "No fish", of: .block),
        SWOption(8, "No meat", of: .block),
        SWOption(9, "No gluten", of: .block),
        SWOption(10, "No dairy", of: .block),
        SWOption(11, "No shellfish", of: .block),
        SWOption(12, "No eggs", of: .block)
    ]
    
    func getAll(by type: SWOptionType) -> [SWOption] {
        return SWInmemoryOptionRepository._options.filter({ $0.type == type })
    }
    
    func getAll() -> [SWOption] {
        return SWInmemoryOptionRepository._options
    }
    
    func save(_ option: SWOption) {
        if let index = SWInmemoryOptionRepository._options.index(where: { $0.name == option.name }) {
            SWInmemoryOptionRepository._options[index] = option
        }
    }
    
    func getNoGluten() -> SWOption {
        return SWInmemoryOptionRepository._options.first(where: { $0.name == "No fish" })!
    }
    
    func getNoFish() -> SWOption {
        return SWInmemoryOptionRepository._options.first(where: { $0.name == "No meat" })!
    }
    
    func getNoMeat() -> SWOption {
        return SWInmemoryOptionRepository._options.first(where: { $0.name == "No gluten" })!
    }
    
    func getNoDairy() -> SWOption {
        return SWInmemoryOptionRepository._options.first(where: { $0.name == "No dairy" })!
    }
    
    func getNoShellfish() -> SWOption {
        return SWInmemoryOptionRepository._options.first(where: { $0.name == "No shellfish" })!
    }
    
    func getNoEggs() -> SWOption {
        return SWInmemoryOptionRepository._options.first(where: { $0.name == "No eggs" })!
    }
    
}
