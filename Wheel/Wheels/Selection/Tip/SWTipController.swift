//
//  TipView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWTipController {
    
    // MARK: - Subviews
    
    var tip: UILabel!
    
    var pointer: UIView!
    
    var balloon: UIView!
    
    // MARK: - Private Properties
    
    private let sidePadding: CGFloat = 16
    
    private let bottomPadding: CGFloat = 8
    
    // MARK: - Initialization
    
    init() {
        pointer = UIView()
        pointer.alpha = 0
        
        balloon = UIView()
        balloon.alpha = 0
        
        tip = UILabel()
        tip.numberOfLines = 0
        tip.alpha = 0
    }
    
    // MARK: - Public Methods
    
    func show(tip text: String, at anchor: CGPoint, in scene: UIView) {
        let tipText = text.toTipText
//        let tipAnchor = scene.convert(anchor, to: )
        
        balloon.frame.size = tipText.size(in: scene.bounds.width - sidePadding * 2).wider(by: 8).higher(by: 16)
        balloon.backgroundColor = .casablanca
        balloon.layer.cornerRadius = 4
        balloon.alpha = 1
        let balloonX: CGFloat = scene.bounds.width - (balloon.frame.size.width + sidePadding)
        let balloonY: CGFloat = anchor.y - (balloon.frame.size.height + bottomPadding)
        balloon.frame.origin = CGPoint(x: balloonX, y: balloonY)
        scene.addSubview(balloon)
        
        tip.attributedText = tipText
//        tip.frame.size = tipText.size().raise()
        tip.frame.size = tipText.size(in: scene.bounds.width - sidePadding * 2)
        tip.alpha = 1
        let tipX: CGFloat = balloon.center.x - tip.frame.width * 0.5
        let tipY: CGFloat = balloon.center.y - tip.frame.height * 0.5
        tip.frame.origin = CGPoint(x: tipX, y: tipY)
        scene.addSubview(tip)
        
        pointer.transform = CGAffineTransform.identity
        pointer.frame.size = CGSize(width: 8, height : 8)
        pointer.backgroundColor = .casablanca
        pointer.center = CGPoint(x: anchor.x, y: balloon.frame.origin.y + balloon.frame.size.height)
        pointer.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi * 0.25)
        pointer.alpha = 1
        scene.addSubview(pointer)
    }
    
    func shrink() {
        balloon.transform = CGAffineTransform.identity.translatedBy(x: pointer.center.x - balloon.center.x, y: pointer.center.y - balloon.center.y - 4).scaledBy(x: 16 / balloon.frame.size.width, y: 8 / balloon.frame.size.height)
    }
    
    func grow() {
        balloon.transform = CGAffineTransform.identity
    }
    
    func fade() {
        tip.alpha = 0
        balloon.alpha = 0
        pointer.alpha = 0
    }
    
    func unanimate() {
        tip.layer.removeAllAnimations()
        balloon.layer.removeAllAnimations()
        pointer.layer.removeAllAnimations()
    }
}
