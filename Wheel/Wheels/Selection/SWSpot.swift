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
    
    var icon: UIView { get }
    
    func move(angle: CGFloat, radius: CGFloat) -> Void
    
}

extension SWSelectionSpot {
    func move(angle: CGFloat, radius: CGFloat) {
        icon.transform = CGAffineTransform.identity.rotated(by: angle + CGFloat.pi * 0.5).translatedBy(x: 0, y: -radius)
    }
}

class SWHiddenSpot: SWSelectionSpot {
    
    var icon: UIView {
        get {
            return _icon
        }
    }
    
    let kinds: [SWIngredientKinds]
    
    private let size = CGSize(width: 42, height: 42)
    
    private let _icon: UIButton
    
    init(icon spot: UIButton, for kinds: [SWIngredientKinds]) {
        _icon = spot
        self.kinds = kinds
    }
    
    func open(angle: CGFloat, radius: CGFloat) -> SWOpenSpot {
        icon.alpha = 1
        self.move(angle: angle, radius: radius)
        return SWOpenSpot(icon: _icon)
    }

    func alignView(to center: CGPoint) {
        icon.alpha = 0
        icon.frame.size = size
        _icon.setImage(#imageLiteral(resourceName: "wheelgui/add"), for: .normal)
        icon.layer.cornerRadius = icon.bounds.width * 0.5
        icon.layer.borderWidth = 1
        icon.layer.borderColor = UIColor.tiara.cgColor
        icon.center = center
    }
    
}

class SWOpenSpot: SWSelectionSpot {

    var angle: CGFloat {
        get {
            return atan2(icon.transform.b, icon.transform.a)
        }
    }
   
    var icon: UIView {
        get {
            return _icon
        }
    }
    
    private let _icon: UIButton
    
    init(icon spot: UIButton) {
        _icon = spot
    }
    
    func fill(with ingredient: SWIngredient) -> SWFilledSpot {
        _icon.setImage(ingredient.image, for: .normal)
        _icon.layer.borderWidth = 0
        _icon.layer.borderColor = UIColor.clear.cgColor
        let filled = SWFilledSpot(icon: _icon, ingredient: ingredient)
        return filled
    }
    
}

class SWFilledSpot: SWSelectionSpot {
    
    private let ingredient: SWIngredient
    
    var icon: UIView {
        get {
            return _icon
        }
    }
    
    private let _icon: UIButton
    
    init(icon spot: UIButton, ingredient: SWIngredient) {
        _icon = spot
        self.ingredient = ingredient
    }
    
}

class SWDelimeterSpot: SWSelectionSpot {
    
    var angle: CGFloat {
        get {
            return atan2(icon.transform.b, icon.transform.a)
        }
    }
    
    var icon: UIView {
        get {
            return _icon
        }
    }
    
    private let _icon: UIImageView
    
    init(icon image: UIImageView) {
        _icon = image
    }
    
    func alignView(to center: CGPoint) {
        _icon.center = center
    }
    
}

