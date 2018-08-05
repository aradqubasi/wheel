//
//  SWFakeFloatable.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWFakeFloatable: UIView, Floatable {
    var asIngridient: SWIngredient {
        get {
            return ingredient
        }
    }
    var ingredient: SWIngredient!
}
