//
//  SWUserOption.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/12/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation


struct SWUserOption: Codable {
    
    let optionId: Int
    
    var checked: Bool
    
    init(_ id: Int, _ checked: Bool) {
        self.optionId = id
        self.checked = checked
    }
    
}
