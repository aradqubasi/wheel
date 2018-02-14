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
        SWOption("Vegan", of: .ingredient),
        SWOption("Vegeterian", of: .ingredient),
        SWOption("Percetarian", of: .ingredient),
        SWOption("Gluten intolerant", of: .allergy),
        SWOption("Wheat intolerant", of: .allergy),
        SWOption("Lactose intolerant", of: .allergy)
    ]
    
    func getAll() -> [SWOption] {
        return SWInmemoryOptionRepository._options
    }
    
    func save(_ option: SWOption) {
        if let index = SWInmemoryOptionRepository._options.index(where: { $0.name == option.name }) {
            SWInmemoryOptionRepository._options[index] = option
        }
    }
    
}
