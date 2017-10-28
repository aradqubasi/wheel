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
    var image: UIImage
    var pinRadius: CGFloat
//    var spokeRadius: CGFloat
    init(_ image: UIImage, _ pinRadius: CGFloat) {
        self.image = image
        self.pinRadius = pinRadius
//        self.spokeRadius = spokeRadius
    }
}
