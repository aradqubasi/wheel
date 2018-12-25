//
//  SWOption.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

struct SWOption: Codable, Hashable {
    
    let id: Int?
    
    var type: SWOptionType
    
    var name: String
    
//    var checked: Bool
    
    init(_ id: Int? = nil, _ name: String, of type: SWOptionType, is checked: Bool = false) {
        
        self.id = id
        
        self.name = name
        
        self.type = type
        
//        self.checked = checked
        
    }
    
    // MARK: - Hashable implementation
    
    var hashValue: Int {
        get {
            return name.hashValue
        }
    }
    
    static func ==(lhs: SWOption, rhs: SWOption) -> Bool {
        return lhs.name == rhs.name && lhs.type == rhs.type
    }
    
}
