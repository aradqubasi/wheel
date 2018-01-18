//
//  SWProteinsSlideView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWProteinsSlideView: SWSliderView {
    
    // MARK: - Overridees
    
    override func alignSubviews(_ title: UILabel, _ subtitle: UILabel) {
        var offset: CGPoint = .zero
        let center = CGPoint(x: bounds.width * 0.5, y: bounds.height * 0.5)
        
        //setup title
        do {
            title.frame.size = SWConfiguration.ProteinsSlide.Title.size
            title.attributedText = SWConfiguration.ProteinsSlide.Title.text
            title.textAlignment = .center
            offset = SWConfiguration.ProteinsSlide.Title.offset
            title.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
        }
        
        //setup subtitle
        do {
            subtitle.frame.size = SWConfiguration.ProteinsSlide.Subtitle.size
            subtitle.attributedText = SWConfiguration.ProteinsSlide.Subtitle.text
            subtitle.textAlignment = .center
            offset = SWConfiguration.ProteinsSlide.Subtitle.offset
            subtitle.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
        }
        
    }
    
}
