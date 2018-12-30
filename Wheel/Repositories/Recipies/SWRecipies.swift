//
//  SWRecipies.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 30/12/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation

class SWRecipies : Codable {
    
    var bookmarkRecipyId: Int?
    
    var recipies: [Int:SWRecipy] = [:]
    
}
