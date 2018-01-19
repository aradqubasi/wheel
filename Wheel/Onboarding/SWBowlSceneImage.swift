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
    
    /**image itself*/
    
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
            _image.transform = CGAffineTransform.identity.scaledBy(x: scale.x, y: scale.y)
        }
    }
    
    init (_ image: UIImageView, offsets: [SWPagerStates: CGPoint], scales: [SWPagerStates: CGPoint], alphas: [SWPagerStates: CGFloat], in initial: SWPagerStates) {
        _image = image
        _offsets = offsets
        _scales = scales
        _alphas = alphas
        _state = initial
    }
    
}
