//
//  SWServingsCaptionGenerator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWServingsGenerator {
    
    func getCaption(for quantity: Int) -> String
    
}
