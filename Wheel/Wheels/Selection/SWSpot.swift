//
//  SWSpot.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWSelectionSpot {
    
}

class SWHiddenSpot {
    
    private let frame = CGRect(origin: .zero, size: CGSize(width: 42, height: 42))
    
    private let icon: UIButton
    
    init(icon spot: UIButton) {
        icon = spot
    }
    
    func open(angle: CGFloat, radius: CGFloat, rotation: CGFloat) -> SWOpenSpot {
        icon.alpha = 1
        icon.transform = CGAffineTransform.identity.rotated(by: rotation + angle).translatedBy(x: radius, y: 0)
        return SWOpenSpot(icon: self.icon)
    }
    
    func move(angle: CGFloat, radius: CGFloat, rotation: CGFloat) {
        icon.transform = CGAffineTransform.identity.rotated(by: rotation + angle).translatedBy(x: radius, y: 0)
    }
    
    func alignView(to center: CGPoint) {
        icon.alpha = 0
        icon.setImage(#imageLiteral(resourceName: "wheelgui/add"), for: .normal)
        icon.layer.cornerRadius = icon.bounds.width * 0.5
        icon.layer.borderWidth = 1
        icon.layer.borderColor = UIColor.tiara.cgColor
        icon.frame = frame
        icon.center = center
    }
    
}

class SWOpenSpot {
   
    private let icon: UIButton
    
    init(icon spot: UIButton) {
        icon = spot
    }
    
}

class SWDelimeterSpot {
    
    private let icon: UIImageView
    
    init(icon image: UIImageView) {
        icon = image
    }
    
    func move(angle: CGFloat, radius: CGFloat, rotation: CGFloat) {
//        icon.transform = CGAffineTransform.identity.rotated(by: rotation + angle).translatedBy(x: radius, y: 0)
        icon.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(rotation + angle), y: radius * sin(rotation + angle))
    }
    
    func alignView(to center: CGPoint) {
        icon.center = center
    }
    
}

