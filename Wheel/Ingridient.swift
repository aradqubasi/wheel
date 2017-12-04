//
//  Ingridient.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 26/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct Ingridient {
    
    // MARK: - Public Properties
    
    var kind: IngridientKinds
    
    var name: String
    
    var image: UIImage
    
    init(_ name: String, of kind: IngridientKinds, as image: UIImage) {
        self.name = name
        self.kind = kind
        self.image = image
    }
}
