//
//  SWMissingIngridient.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
struct SWRecipy {
    let kind: [IngridientKinds]
    let min: Int
    let max: Int
    
    init(of kind: [IngridientKinds], from min: Int, to max: Int) {
        self.kind = kind
        self.min = min
        self.max = max
    }
//    
//    func missing(in selected: [Ingridient]) -> SWRecipy {
//        
//        return []
//    }
}
