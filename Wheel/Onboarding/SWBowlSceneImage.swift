//
//  SWBowlImage.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 19/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWBowlSceneImage {

    // MARK: - Provaye Properties

    private var _image: UIImageView
    
    private var _state: SWPagerStates
    
    private let _offsets: [SWPagerStates: CGPoint]
    
    private let _scales: [SWPagerStates: CGPoint]
    
    private let _alphas: [SWPagerStates: CGFloat]
    
    // MARK: - Public Properties
    
    var image: UIImageView {
        get {
            return _image
        }
    }
    
    var state: SWPagerStates {
        get {
            return _state
        }
        set (new) {
            _state = new
            guard let offset = _offsets[_state] else {
                fatalError("no offset for state \(_state)")
            }
            guard let scale = _scales[_state] else {
                fatalError("no scale for state \(_state)")
            }
            guard let alpha = _alphas[_state] else {
                fatalError("no alpha for state \(_state)")
            }
            guard let scene = _image.superview else {
                fatalError("image without superview")
            }
            let center = CGPoint(x: scene.bounds.width * 0.5, y: scene.bounds.height * 0.5)
            
            _image.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
            _image.alpha = alpha
            _image.transform = CGAffineTransform.identity.scaledBy(x: scale.x, y: scale.y)//.translatedBy(x: offset.x, y: offset.y)
        }
    }
    
    // MARK: - Initialization
    
    init (_ image: UIImageView, offsets: [SWPagerStates: CGPoint], scales: [SWPagerStates: CGPoint], alphas: [SWPagerStates: CGFloat], in initial: SWPagerStates) {
        _image = image
        _offsets = offsets
        _scales = scales
        _alphas = alphas
        _state = initial
    }
    
    // MARK: - Premades
    
    class var frontbowl: SWBowlSceneImage {
        get {
            let slightlyUp = CGPoint(x: 0, y: -28)
            let original = CGPoint(x: 1, y: 1)
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.frontbowl)
                , offsets: [
                    .obey: slightlyUp,
                    .leafs: slightlyUp,
                    .proteins: slightlyUp,
                    .veggies: slightlyUp,
                    .fats: slightlyUp,
                    .ehancers: slightlyUp
                ], scales: [
                    .obey: CGPoint(x: 0.2, y: 0.2),
                    .leafs: original,
                    .proteins: original,
                    .veggies: original,
                    .fats: original,
                    .ehancers: original
                ], alphas: [
                    .obey: 0,
                    .leafs: visible,
                    .proteins: visible,
                    .veggies: visible,
                    .fats: visible,
                    .ehancers: visible
                ], in: .obey)
        }
    }
    
}
