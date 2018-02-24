//
//  Ingridient.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 26/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct SWIngredient: Hashable {
    
    // MARK: - Public Properties
    
    var id: Int?
    
    var kind: SWIngredientKinds
    
    var name: String
    
    var image: UIImage
    
    var outline: UIImage
    
    /**quantity per serving*/
    var quantity: Double
    
    /**measurment unit*/
    var unit: String
    
    init(id: Int? = nil, _ name: String, of kind: SWIngredientKinds, as image: UIImage, _ outline: UIImage, quantity: Double, unit: String) {
        self.id = id
        self.name = name
        self.kind = kind
        self.image = image
        self.outline = outline
        self.quantity = quantity
        self.unit = unit
    }
    
    // MARK: - Hashable implementation
    
    var hashValue: Int {
        get {
            return name.hashValue ^ kind.hashValue// ^ image.hashValue
        }
    }
    
    static func ==(lhs: SWIngredient, rhs: SWIngredient) -> Bool {
        return lhs.name == rhs.name && lhs.kind == rhs.kind //&& lhs.image == rhs.image
    }
}
