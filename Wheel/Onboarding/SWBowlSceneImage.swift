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
    
    private var _step: SWBowlActSteps
    
//    private let _offsets: [SWPagerStates: CGPoint]
//
//    private let _scales: [SWPagerStates: CGPoint]
//
//    private let _alphas: [SWPagerStates: CGFloat]
    
    private let _story: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]]
    
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
//        set (new) {
//            _state = new
//            guard let offset = _offsets[_state] else {
//                fatalError("no offset for state \(_state)")
//            }
//            guard let scale = _scales[_state] else {
//                fatalError("no scale for state \(_state)")
//            }
//            guard let alpha = _alphas[_state] else {
//                fatalError("no alpha for state \(_state)")
//            }
//            guard let scene = _image.superview else {
//                fatalError("image without superview")
//            }
//            let center = CGPoint(x: scene.bounds.width * 0.5, y: scene.bounds.height * 0.5)
//
//            _image.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
//            _image.alpha = alpha
//            _image.transform = CGAffineTransform.identity.scaledBy(x: scale.x, y: scale.y)
//        }
    }
    
    // MARK: - Initialization
    
//    init (_ image: UIImageView, offsets: [SWPagerStates: CGPoint], scales: [SWPagerStates: CGPoint], alphas: [SWPagerStates: CGFloat], in initial: SWPagerStates) {
//        _image = image
//        _offsets = offsets
//        _scales = scales
//        _alphas = alphas
//        _state = initial
//    }
    
    init (_ image: UIImageView, with story: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]], in initial: SWPagerStates, at step: SWBowlActSteps) {
        _image = image
        _story = story
        _state = initial
        _step = step
    }
    
    // MARK: - Public Methods
    
    func play(to state: SWPagerStates, at step: SWBowlActSteps) {
        _state = state
        _step = step
        guard let story = _story[state] else {
            fatalError("no story for state \(_state)")
        }
        if let step = story[step] {
            let offset = step.offset
            let scale = step.scale
            let alpha = step.alpha
            let angle = step.angle
            guard let scene = _image.superview else {
                fatalError("image without superview")
            }
            let center = CGPoint(x: scene.bounds.width * 0.5, y: scene.bounds.height * 0.5)
            _image.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
            _image.alpha = alpha
            _image.transform = CGAffineTransform.identity.scaledBy(x: scale.x, y: scale.y).rotated(by: angle)
        }
    }
    
    // MARK: - Premades

//    class var frontbowl: SWBowlSceneImage {
//        get {
//            let above = CGPoint(x: 0, y: -28)
//            let original = CGPoint(x: 1, y: 1)
//            let visible: CGFloat = 1
//            return SWBowlSceneImage(
//                UIImageView.init(image: UIImage.frontbowl)
//                , offsets: [
//                    .obey: above,
//                    .leafs: above,
//                    .proteins: above,
//                    .veggies: above,
//                    .fats: above,
//                    .ehancers: above
//                ], scales: [
//                    .obey: CGPoint(x: 0.2, y: 0.2),
//                    .leafs: original,
//                    .proteins: original,
//                    .veggies: original,
//                    .fats: original,
//                    .ehancers: original
//                ], alphas: [
//                    .obey: 0,
//                    .leafs: visible,
//                    .proteins: visible,
//                    .veggies: visible,
//                    .fats: visible,
//                    .ehancers: visible
//                ], in: .obey)
//        }
//    }

    class var frontbowl: SWBowlSceneImage {
        get {
            let above = CGPoint(x: 0, y: -28)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.frontbowl)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: above, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    class var backbowl: SWBowlSceneImage {
        get {
            let above = CGPoint(x: 0, y: -74)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backbowl)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: above, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: above, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    class var spoon: SWBowlSceneImage {
        get {
            let upleft = CGPoint(x: -89, y: -97)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.spoon)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: upleft, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    class var backleaf1: SWBowlSceneImage {
        get {
            let upleft = CGPoint(x: -49, y: -63.5)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backleaf1)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: upleft, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }

    class var backleaf2: SWBowlSceneImage {
        get {
            let upright = CGPoint(x: 15, y: -66)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backleaf2)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: upright, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
 
    class var backleaf3: SWBowlSceneImage {
        get {
            let upleft = CGPoint(x: -89.44, y: -75.17)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backleaf3)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: upleft, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }

    class var backleaf4: SWBowlSceneImage {
        get {
            let upright = CGPoint(x: 69, y: -72.4)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.backleaf4)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: upright, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: upright, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    class var frontleaf1: SWBowlSceneImage {
        get {
            let above = CGPoint(x: -12, y: -141)
            let plate = CGPoint(x: 0, y: -67)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            let bendright: CGFloat = CGFloat.pi * 2 / 360 * 30
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.frontleaf1)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: above, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: above, scale: shrinked, alpha: invisible),
                        .after: SWBowlActParams(offset: above, scale: shrinked, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: above, scale: shrinked, alpha: invisible, angle: bendright),
                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible, angle: bendright),
                        .after: SWBowlActParams(offset: plate, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: plate, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: plate, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: plate, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: plate, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: plate, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: plate, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: plate, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: plate, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: plate, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: plate, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: plate, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: plate, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    class var frontleaf2: SWBowlSceneImage {
        get {
            let up = CGPoint(x: -37, y: -169.5)
            let down = CGPoint(x: -23, y: -60.5)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            let bendleft: CGFloat = -CGFloat.pi * 2 / 360 * 50
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.frontleaf2)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: up, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible, angle: bendleft),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible, angle: bendleft),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    class var frontleaf3: SWBowlSceneImage {
        get {
            let up = CGPoint(x: -9, y: -219)
            let down = CGPoint(x: -68, y: -57)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.frontleaf3)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: up, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    class var frontleaf4: SWBowlSceneImage {
        get {
            let up = CGPoint(x: 25, y: -228)
            let down = CGPoint(x: 0, y: -26)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.frontleaf4)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: up, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    class var frontleaf5: SWBowlSceneImage {
        get {
            let up = CGPoint(x: 37, y: -132)
            let down = CGPoint(x: 44, y: -30)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.frontleaf5)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: up, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    // MARK: - Proteins Scene Actors
    
    class var egg1: SWBowlSceneImage {
        get {
            let up = CGPoint(x: -2, y: -207.5)
            let down = CGPoint(x: 40, y: -65.5)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            let bendleft: CGFloat = CGFloat.pi * 2 / 360 * 12
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.egg1)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: up, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: up, scale: original, alpha: invisible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
    
    class var egg2: SWBowlSceneImage {
        get {
            let up = CGPoint(x: -33, y: -144)
            let down = CGPoint(x: -26, y: -67)
            let original = CGPoint(x: 1, y: 1)
            let shrinked = CGPoint(x: 0.2, y: 0.2)
            let invisible: CGFloat = 0
            let visible: CGFloat = 1
            let bendleft: CGFloat = CGFloat.pi * 2 / 360 * 12
            return SWBowlSceneImage(
                UIImageView.init(image: UIImage.egg2)
                , with: [
                    .obey: [
                        .before: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: up, scale: original, alpha: invisible)
                    ],
                    .leafs: [
                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .after: SWBowlActParams(offset: up, scale: original, alpha: invisible)
                    ],
                    .proteins: [
                        .before: SWBowlActParams(offset: up, scale: original, alpha: invisible),
                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .veggies: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .fats: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ],
                    .ehancers: [
                        .before: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .inbetween: SWBowlActParams(offset: down, scale: original, alpha: visible),
                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
                    ]
                ]
                , in: .obey
                , at: .before)
        }
    }
}
