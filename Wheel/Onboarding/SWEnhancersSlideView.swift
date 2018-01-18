//
//  SWEnhancerSlideView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWEnhancersSlideView: SWSliderView {
    
    // MARK: - Overridees
    
    override func alignSubviews(_ title: UILabel, _ subtitle: UILabel) {
        var offset: CGPoint = .zero
        let center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        
        //setup title
        do {
            title.frame.size = SWConfiguration.EnhancersSlide.Title.size
            title.attributedText = SWConfiguration.EnhancersSlide.Title.text
            title.textAlignment = .center
            offset = SWConfiguration.EnhancersSlide.Title.offset
            title.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
        }
        
        //setup subtitle
        do {
            subtitle.frame.size = SWConfiguration.EnhancersSlide.Subtitle.size
            subtitle.attributedText = SWConfiguration.EnhancersSlide.Subtitle.text
            subtitle.textAlignment = .center
            offset = SWConfiguration.EnhancersSlide.Subtitle.offset
            subtitle.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
        }
        
    }
    
}
