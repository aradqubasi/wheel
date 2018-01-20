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
            let above = CGPoint(x: 0, y: -28)
            let original = CGPoint(x: 1, y: 1)
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.frontbowl)
                , offsets: [
                    .obey: above,
                    .leafs: above,
                    .proteins: above,
                    .veggies: above,
                    .fats: above,
                    .ehancers: above
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
    
    class var backbowl: SWBowlSceneImage {
        get {
            let above = CGPoint(x: 0, y: -74)
            let original = CGPoint(x: 1, y: 1)
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backbowl)
                , offsets: [
                    .obey: above,
                    .leafs: above,
                    .proteins: above,
                    .veggies: above,
                    .fats: above,
                    .ehancers: above
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
    
    class var spoon: SWBowlSceneImage {
        get {
            let upleft = CGPoint(x: -89, y: -97)
            let original = CGPoint(x: 1, y: 1)
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.spoon)
                , offsets: [
                    .obey: upleft,
                    .leafs: upleft,
                    .proteins: upleft,
                    .veggies: upleft,
                    .fats: upleft,
                    .ehancers: upleft
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
    
    class var backleaf1: SWBowlSceneImage {
        get {
            let upleft = CGPoint(x: -49, y: -63.5)
            let original = CGPoint(x: 1, y: 1)
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backleaf1)
                , offsets: [
                    .obey: upleft,
                    .leafs: upleft,
                    .proteins: upleft,
                    .veggies: upleft,
                    .fats: upleft,
                    .ehancers: upleft
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
    
    class var backleaf2: SWBowlSceneImage {
        get {
            let upright = CGPoint(x: 15, y: -66)
            let original = CGPoint(x: 1, y: 1)
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backleaf2)
                , offsets: [
                    .obey: upright,
                    .leafs: upright,
                    .proteins: upright,
                    .veggies: upright,
                    .fats: upright,
                    .ehancers: upright
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
    
    class var backleaf3: SWBowlSceneImage {
        get {
            let upleft = CGPoint(x: -89.44, y: -75.17)
            let original = CGPoint(x: 1, y: 1)
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backleaf3)
                , offsets: [
                    .obey: upleft,
                    .leafs: upleft,
                    .proteins: upleft,
                    .veggies: upleft,
                    .fats: upleft,
                    .ehancers: upleft
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
    
    class var backleaf4: SWBowlSceneImage {
        get {
            let upright = CGPoint(x: 69, y: -72.4)
            let original = CGPoint(x: 1, y: 1)
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backleaf4)
                , offsets: [
                    .obey: upright,
                    .leafs: upright,
                    .proteins: upright,
                    .veggies: upright,
                    .fats: upright,
                    .ehancers: upright
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
