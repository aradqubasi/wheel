//
//  SWPieChart.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/12/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWPieChart {
    
    var min: Double
    
    var center: CGPoint
    
    var innerWrapper: UIView
    
    var outerWrapper: UIView
    
    var marksWrapper: UIView
    
    var captionsWrapper: UIView
    
    var innerRadius: CGFloat
    
    var outerRadius: CGFloat
    
    var marksRadius: CGFloat
    
    var sections: [SWPieSection]
    
    init(min: Double, center: CGPoint, innerWrapper: UIView, outerWrapper: UIView, marksWrapper: UIView, captionsWrapper: UIView, innerRadius: CGFloat, outerRadius: CGFloat, marksRadius: CGFloat, sections: [SWPieSection]) {
        
        self.min = min
        self.center = center
        self.innerWrapper = innerWrapper
        self.outerWrapper = outerWrapper
        self.marksWrapper = marksWrapper
        self.captionsWrapper = captionsWrapper
        self.innerRadius = innerRadius
        self.outerRadius = outerRadius
        self.marksRadius = marksRadius
        self.sections = sections
        
    }
}
