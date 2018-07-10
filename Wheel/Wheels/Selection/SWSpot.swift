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
    
    let kinds: [SWIngredientKinds]
    
    private let size = CGSize(width: 42, height: 42)
    
    private let icon: UIButton
    
    init(icon spot: UIButton, for kinds: [SWIngredientKinds]) {
        icon = spot
        self.kinds = kinds
    }
    
    func open(angle: CGFloat, radius: CGFloat) -> SWOpenSpot {
        icon.alpha = 1
        icon.transform = CGAffineTransform.identity.rotated(by: angle).translatedBy(x: radius, y: 0)
        return SWOpenSpot(icon: self.icon)
    }
    
    func move(angle: CGFloat, radius: CGFloat) {
        icon.transform = CGAffineTransform.identity.rotated(by: angle).translatedBy(x: radius, y: 0)
    }
    
    func alignView(to center: CGPoint) {
        icon.alpha = 0
        icon.frame.size = size
        icon.setImage(#imageLiteral(resourceName: "wheelgui/add"), for: .normal)
        icon.layer.cornerRadius = icon.bounds.width * 0.5
        icon.layer.borderWidth = 1
        icon.layer.borderColor = UIColor.tiara.cgColor
        icon.center = center
    }
    
}

class SWOpenSpot {

    var angle: CGFloat {
        get {
            return atan2(icon.transform.b, icon.transform.a)
        }
    }
   
    private let icon: UIButton
    
    init(icon spot: UIButton) {
        icon = spot
    }
    
    func move(angle: CGFloat, radius: CGFloat) {
        icon.transform = CGAffineTransform.identity.rotated(by: angle).translatedBy(x: radius, y: 0)
    }
    
    func fill(with ingredient: SWIngredient) -> SWFilledSpot {
        icon.setImage(ingredient.image, for: .normal)
        icon.layer.borderWidth = 0
        icon.layer.borderColor = UIColor.clear.cgColor
        let filled = SWFilledSpot(icon: self.icon, ingredient: ingredient)
        return filled
    }
    
}

class SWFilledSpot {
    
    private let ingredient: SWIngredient
    
    private let icon: UIButton
    
    init(icon spot: UIButton, ingredient: SWIngredient) {
        self.icon = spot
        self.ingredient = ingredient
    }
    
    func move(angle: CGFloat, radius: CGFloat) {
        icon.transform = CGAffineTransform.identity.rotated(by: angle).translatedBy(x: radius, y: 0)
    }
    
}

class SWDelimeterSpot {
    
    var angle: CGFloat {
        get {
            return atan2(icon.transform.b, icon.transform.a)
        }
    }
    
    private let icon: UIImageView
    
    init(icon image: UIImageView) {
        icon = image
    }
    
    func move(angle: CGFloat, radius: CGFloat) {
        icon.transform = CGAffineTransform.identity.rotated(by: angle).translatedBy(x: radius, y: 0)
    }
    
    func alignView(to center: CGPoint) {
        icon.center = center
    }
    
}

