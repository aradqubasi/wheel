//
//  Floatable.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol Floatable {
    
    var asIngridient: SWIngredient { get }
    
    func convert(_ point: CGPoint, to coordinateSpace: UICoordinateSpace) -> CGPoint
    
}
