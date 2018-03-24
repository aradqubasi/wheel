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
    
    init(side: CGFloat) {
        self.init(width: side, height: side)
    }
    
    // MARK: - Helpers
    
    func wider(by margin: CGFloat) -> CGSize {
        return CGSize(width: width + margin * 2, height: height)
    }
    
    func higher(by margin: CGFloat) -> CGSize {
        return CGSize(width: width, height: height + margin * 2)
    }
    
    func raise() -> CGSize {
        let uppedWidth = self.width.rounded(.up)
        let uppedHeight = self.height.rounded(.up)
        return CGSize(width: uppedWidth, height: uppedHeight)
    }
    
}
