//
//  SWPieSection.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/12/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWPieSection {
    
    var innerLayer: CAShapeLayer
    
    var innerColor: UIColor
    
    var outerLayer: CAShapeLayer
    
    var outerColor: UIColor
    
    var range: SWAngularRange
    
    var legend: SWPieLegend
    
    var markWrapper: UIView
    
    var markLabel: UILabel
    
    var captionWrapper: UIView
    
    var captionChars: [UILabel]
    
    var share: Double
    
    var markAngle: CGFloat

    init(innerLayer: CAShapeLayer, innerColor: UIColor, outerLayer: CAShapeLayer, outerColor: UIColor, range: SWAngularRange, legend: SWPieLegend, markWrapper: UIView, markLabel: UILabel, captionWrapper: UIView, captionChars: [UILabel], share: Double, markAngle: CGFloat) {
        
        self.innerLayer = innerLayer
        self.innerColor = innerColor
        self.outerLayer = outerLayer
        self.outerColor = outerColor
        self.range = range
        self.legend = legend
        self.markWrapper = markWrapper
        self.markLabel = markLabel
        self.captionWrapper = captionWrapper
        self.captionChars = captionChars
        self.share = share
        self.markAngle = markAngle
        
    }
    
}
