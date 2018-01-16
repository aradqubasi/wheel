//
//  SWObeySlideView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 15/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWObeySlideView: SWSliderView {
    
    // MARK: - Overridees
    
    override func alignSubviews(_ title: UILabel, _ subtitle: UILabel) {
        title.frame.size = SWConfiguration.ObeySlide.size
        title.attributedText = SWConfiguration.ObeySlide.text
        title.textAlignment = .center
        title.center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
    }
    
}
