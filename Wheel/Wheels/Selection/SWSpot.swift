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
    
    var kinds: [SWIngredientKinds] { get }
    
    var icon: UIView { get }
    
    /** current angle */
    var angle: CGFloat { get }
    
    /** current radius*/
    var radius: CGFloat { get }

    func move(angle: CGFloat, radius: CGFloat) -> Void
    
}

protocol SWLabeledSelectionSpot {
    
    var label: UILabel { get }
    
}

class SWHiddenSpot: SWSelectionSpot, SWLabeledSelectionSpot {
    
    var icon: UIView {
        get {
            return _icon
        }
    }
    
    var label: UILabel {
        get {
            return _label
        }
    }
    
    private let _label: UILabel
    
    let kinds: [SWIngredientKinds]
    
    private let size = CGSize(width: 42, height: 42)
    
    private let _icon: UIButton
    
    
    
    /** current angle */
    var angle: CGFloat = 0
    
    /** current radius*/
    var radius: CGFloat = 0
    
    init(icon spot: UIButton, label: UILabel, for kinds: [SWIngredientKinds]) {
        _icon = spot
        _label = label
        self.kinds = kinds
    }

//    func open(as label: UILabel) -> SWOpenSpot {
    func open() -> SWOpenSpot {
        icon.alpha = 1
        let openned = SWOpenSpot(icon: _icon, label: _label, kinds: self.kinds)
        if openned.kinds.contains(.base) {
            openned.label.text = "BASE"
        }
        else if openned.kinds.contains(.fat) {
            openned.label.text = "FATS"
        }
        else if openned.kinds.contains(.protein) {
            openned.label.text = "PROTEINS"
        }
        else if openned.kinds.contains(.veggy) {
            openned.label.text = "VEGGIES"
        }
        else if openned.kinds.contains(.unexpected) {
            openned.label.text = "ENHANCERS"
        }
        else if openned.kinds.contains(.dressing) {
            openned.label.text = "ENHANCERS"
        }
        else if openned.kinds.contains(.fruits) {
            openned.label.text = "ENHANCERS"
        }
        openned.angle = self.angle
        openned.radius = self.radius
        return openned
    }
    
    func alignView(to center: CGPoint, moveLabelUpBy labelRadius: CGFloat) {
        icon.alpha = 0
        icon.frame.size = size
        _icon.setImage(#imageLiteral(resourceName: "wheelgui/add"), for: .normal)
        icon.layer.cornerRadius = icon.bounds.width * 0.5
        icon.layer.borderWidth = 1
        icon.layer.borderColor = UIColor.tiara.cgColor
        icon.center = center
        
        label.center = center
        label.alpha = 0
        label.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -labelRadius)
    }
    
    func move(angle: CGFloat, radius: CGFloat) {
        self.angle = angle
        self.radius = radius
        icon.transform = CGAffineTransform.identity.rotated(by: angle + CGFloat.pi * 0.5).translatedBy(x: 0, y: -radius)
    }
    
}

class SWOpenSpot: SWSelectionSpot, SWLabeledSelectionSpot {
    
    let kinds: [SWIngredientKinds]
    
    var label: UILabel {
        get {
            return _label
        }
    }
    
    private let _label: UILabel
   
    var icon: UIView {
        get {
            return _icon
        }
    }
    
    private let _icon: UIButton
    
    /** current angle */
    var angle: CGFloat = 0
    
    /** current radius*/
    var radius: CGFloat = 0
    
    init(icon spot: UIButton, label: UILabel, kinds: [SWIngredientKinds]) {
        _icon = spot
        _label = label
        self.kinds = kinds
    }
    
    func fill(with ingredient: SWIngredient) -> SWFilledSpot {
        _icon.alpha = 1
        _icon.setImage(ingredient.image, for: .normal)
        _icon.layer.borderWidth = 0
        _icon.layer.borderColor = UIColor.clear.cgColor
        let filled = SWFilledSpot(icon: _icon, label: _label, ingredient: ingredient, kinds: self.kinds)
        filled.label.text = filled.ingredient.name.uppercased()
        filled.angle = self.angle
        filled.radius = self.radius
        return filled
    }
    
    func hide() -> SWHiddenSpot {
        let hidden = SWHiddenSpot(icon: _icon, label: _label, for: kinds)
        
        hidden.icon.alpha = 0
        hidden.label.alpha = 0
        hidden.label.text = nil
        
        return hidden
    }
    
    func move(angle: CGFloat, radius: CGFloat) {
        self.angle = angle
        self.radius = radius
        icon.transform = CGAffineTransform.identity.rotated(by: angle + CGFloat.pi * 0.5).translatedBy(x: 0, y: -radius)
    }
    
    func dissolve() {
        _icon.alpha = 0.5
    }
}

class SWFilledSpot: SWSelectionSpot, SWLabeledSelectionSpot {
    
    let kinds: [SWIngredientKinds]
    
    let ingredient: SWIngredient
    
    var label: UILabel {
        get {
            return _label
        }
    }
    
    private let _label: UILabel
    
    var icon: UIView {
        get {
            return _icon
        }
    }
    
    private let _icon: UIButton
    
    /** current angle */
    var angle: CGFloat = 0
    
    /** current radius*/
    var radius: CGFloat = 0
    
    init(icon spot: UIButton, label: UILabel, ingredient: SWIngredient, kinds: [SWIngredientKinds]) {
        _icon = spot
        self.ingredient = ingredient
        self.kinds = kinds
        _label = label
    }
    
    func move(angle: CGFloat, radius: CGFloat) {
        self.angle = angle
        self.radius = radius
        icon.transform = CGAffineTransform.identity.rotated(by: angle + CGFloat.pi * 0.5).translatedBy(x: 0, y: -radius)
    }
    
    func close() -> SWOpenSpot {
        let openned = SWOpenSpot(icon: _icon, label: _label, kinds: self.kinds)

        _icon.alpha = 1
        _icon.setImage(#imageLiteral(resourceName: "wheelgui/add"), for: .normal)
        _icon.layer.cornerRadius = icon.bounds.width * 0.5
        _icon.layer.borderWidth = 1
        _icon.layer.borderColor = UIColor.tiara.cgColor
        
        if openned.kinds.contains(.base) {
            openned.label.text = "BASE"
        }
        else if openned.kinds.contains(.fat) {
            openned.label.text = "FATS"
        }
        else if openned.kinds.contains(.protein) {
            openned.label.text = "PROTEINS"
        }
        else if openned.kinds.contains(.veggy) {
            openned.label.text = "VEGGIES"
        }
        else if openned.kinds.contains(.unexpected) {
            openned.label.text = "ENHANCERS"
        }
        else if openned.kinds.contains(.dressing) {
            openned.label.text = "ENHANCERS"
        }
        else if openned.kinds.contains(.fruits) {
            openned.label.text = "ENHANCERS"
        }
        
        openned.angle = self.angle
        openned.radius = self.radius
        return openned
    }
}

class SWDelimeterSpot: SWSelectionSpot {
    
    var icon: UIView {
        get {
            return _icon
        }
    }
    
    private let _icon: UIImageView
    
    let kinds: [SWIngredientKinds] = []
    
    /** current angle */
    var angle: CGFloat = 0
    
    /** current radius*/
    var radius: CGFloat = 0
    
    init(icon image: UIImageView) {
        _icon = image
    }
    
    func alignView(to center: CGPoint) {
        _icon.center = center
//        icon.layer.borderWidth = 1
//        icon.layer.borderColor = UIColor.tiara.cgColor
    }
    
    func move(angle: CGFloat, radius: CGFloat) {
        self.angle = angle
        self.radius = radius
        icon.transform = CGAffineTransform.identity.rotated(by: angle + CGFloat.pi * 0.5).translatedBy(x: 0, y: -radius)
    }
}

