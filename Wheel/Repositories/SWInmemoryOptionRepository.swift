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
        SWOption(6, "Lactose intolerant", of: .allergy)
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
    
}
