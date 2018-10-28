//
//  SWRecipy.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

struct SWRecipy: Codable {
    
    let id: Int?
    
    var name: String
    
    var servings: Int
    
    var ingredients: [Int]
    
    var calories: Double
    
    var fats: Double
    
    var carbohydrates: Double
    
    var proteins: Double
    
    var timestamp: Date
    
    var liked: Bool
    
//    var photo: UIImage?
    
}
