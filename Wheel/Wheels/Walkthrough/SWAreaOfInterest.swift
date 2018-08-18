//
//  SWAreaOfInterest.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct SWAreaOfInterest {
    let center: CGPoint
    let size: CGSize
    static var zero {
        get {
            return SWAreaOfInterest(center: .zero, size: .zero)
        }
    }
}
