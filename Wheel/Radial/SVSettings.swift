//
//  SVSettings.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/10/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct SVSettings {
    var boxSide: CGFloat
    var boxOrigin: CGPoint
    init(_ boxOrigin: CGPoint, _ boxSide: CGFloat) {
        self.boxSide = boxSide
        self.boxOrigin = boxOrigin
    }
}
