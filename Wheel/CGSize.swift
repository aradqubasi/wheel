//
//  CGSize.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
public extension CGSize {
    // MARK: - Custom Initializer
    
    public init(side: CGFloat) {
        self.init(width: side, height: side)
    }
}
