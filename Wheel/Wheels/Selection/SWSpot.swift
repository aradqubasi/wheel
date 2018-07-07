//
//  SWSpot.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWHiddenSpot {
    
    private let icon: UIButton
    
    init(icon spot: UIButton) {
        icon = spot
        icon.alpha = 0
        icon.setImage(#imageLiteral(resourceName: "wheelgui/add"), for: .normal)
        icon.layer.cornerRadius = icon.bounds.width * 0.5
        icon.layer.borderWidth = 1
        icon.layer.borderColor = UIColor.tiara.cgColor
//        icon.layer.borderColor = UIColor.black.cgColor
//        icon.layer.borderWidth = 2
    }
    
    func open(angle: CGFloat, radius: CGFloat, rotation: CGFloat) -> SWOpenSpot {
        icon.alpha = 1
        icon.transform = CGAffineTransform.identity.rotated(by: rotation + angle).translatedBy(x: radius, y: 0)
        return SWOpenSpot(icon: self.icon)
    }
    
}

class SWOpenSpot {
   
    private let icon: UIButton
    
    init(icon spot: UIButton) {
        icon = spot
    }
    
}
