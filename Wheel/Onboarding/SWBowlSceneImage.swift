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
    
//    private let _story: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]]
    
    private let _story: SWBowlActStory
    
    // MARK: - Public Properties
    
    var image: UIImageView {
        get {
            return _image
        }
    }
    
    // MARK: - Initialization
    
    init (_ image: UIImageView, with story: SWBowlActStory, in initial: SWPagerStates, at step: SWBowlActSteps) {
        _image = image
        _story = story
        _state = initial
        _step = step
    }
    
    // MARK: - Public Methods
    
    func play(to state: SWPagerStates, at step: SWBowlActSteps) {
        _state = state
        _step = step
        
        var actual: SWBowlActParams = _story.initial
        for state in SWPagerStates.all() {
            for step in SWBowlActSteps.all() {
                
                if let byState = _story.differential[state] {
                    if let byStep = byState[step] {
                        actual = byStep
                    }
                }
                
                if state == _state && step == _step {
                    break
                }
                
            }
            
            if state == _state {
                break
            }
        }
        
        let offset = actual.offset
        let scale = actual.scale
        let alpha = actual.alpha
        let angle = actual.angle
        guard let scene = _image.superview else {
            fatalError("image without superview")
        }
        let center = CGPoint(x: scene.bounds.width * 0.5, y: scene.bounds.height * 0.5)
        _image.center = CGPoint(x: center.x + offset.x, y: center.y + offset.y)
        _image.alpha = alpha
        _image.transform = CGAffineTransform.identity.scaledBy(x: scale.x, y: scale.y).rotated(by: angle)
        
    }
    
    // MARK: - Premades

    class var frontbowl: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage.init(UIImageView.init(image: UIImage.frontbowl), with: SWBowlActStory.frontbowl, in: .obey, at: .before)
            return image
        }
    }
    
    class var backbowl: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.backbowl), with: SWBowlActStory.backbowl, in: .obey, at: .before)
            return image
        }
    }
    
    class var spoon: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.spoon), with: SWBowlActStory.spoon, in: .obey, at: .before)
            return image
        }
    }
    
    class var backleaf1: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.backleaf1), with: SWBowlActStory.backleaf1, in: .obey, at: .before)
            return image
            
//            let upleft = CGPoint(x: -49, y: -63.5)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.backleaf1)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: upleft, scale: original, alpha: invisible), differential: [
//                    .leafs: [
//                        .before: SWBowlActParams(offset: upleft, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("backleaf1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }

    class var backleaf2: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.backleaf2), with: SWBowlActStory.backleaf2, in: .obey, at: .before)
            return image
            
//            let upright = CGPoint(x: 15, y: -66)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.backleaf2)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: upright, scale: original, alpha: invisible), differential: [
//                    .leafs: [
//                        .before: SWBowlActParams(offset: upright, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("backleaf2")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
 
    class var backleaf3: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.backleaf3), with: SWBowlActStory.backleaf3, in: .obey, at: .before)
            return image
            
//            let upleft = CGPoint(x: -89.44, y: -75.17)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.backleaf3)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: upleft, scale: original, alpha: invisible), differential: [
//                    .leafs: [
//                        .before: SWBowlActParams(offset: upleft, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: upleft, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("backleaf3")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }

    class var backleaf4: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.backleaf4), with: SWBowlActStory.backleaf4, in: .obey, at: .before)
            return image
//            let upright = CGPoint(x: 69, y: -72.4)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.backleaf4)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: upright, scale: original, alpha: invisible), differential: [
//                    .leafs: [
//                        .before: SWBowlActParams(offset: upright, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: upright, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("backleaf4")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var frontleaf1: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.frontleaf1), with: SWBowlActStory.frontleaf1, in: .obey, at: .before)
            return image
            
//            let above = CGPoint(x: -12, y: -141)
//            let plate = CGPoint(x: 0, y: -67)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let bendright: CGFloat = CGFloat.pi * 2 / 360 * 30
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.frontleaf1)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: above, scale: shrinked, alpha: invisible), differential: [
//                    .leafs: [
//                        .before: SWBowlActParams(offset: above, scale: shrinked, alpha: invisible, angle: bendright),
//                        .inbetween: SWBowlActParams(offset: above, scale: original, alpha: visible, angle: bendright),
//                        .after: SWBowlActParams(offset: plate, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("frontleaf1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var frontleaf2: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.frontleaf2), with: SWBowlActStory.frontleaf2, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -37, y: -169.5)
//            let down = CGPoint(x: -23, y: -60.5)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let bendleft: CGFloat = -CGFloat.pi * 2 / 360 * 50
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.frontleaf2)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: original, alpha: invisible), differential: [
//                    .leafs: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible, angle: bendleft),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible, angle: bendleft),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("frontleaf2")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var frontleaf3: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.frontleaf3), with: SWBowlActStory.frontleaf3, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -9, y: -219)
//            let down = CGPoint(x: -68, y: -57)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.frontleaf3)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: original, alpha: invisible), differential: [
//                    .leafs: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("frontleaf3")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var frontleaf4: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.frontleaf4), with: SWBowlActStory.frontleaf4, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 25, y: -228)
//            let down = CGPoint(x: 0, y: -26)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.frontleaf4)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: original, alpha: invisible), differential: [
//                    .leafs: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("frontleaf4")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var frontleaf5: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.frontleaf5), with: SWBowlActStory.frontleaf5, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 37, y: -132)
//            let down = CGPoint(x: 44, y: -30)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.frontleaf5)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: original, alpha: invisible), differential: [
//                    .leafs: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("frontleaf5")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    // MARK: - Proteins Scene Actors
    
    class var egg1: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.egg1), with: SWBowlActStory.egg1, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -2, y: -207.5)
//            let down = CGPoint(x: 40, y: -65.5)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let bendleft: CGFloat = CGFloat.pi * 2 / 360 * 12
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.egg1)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .proteins: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible, angle: bendleft)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("egg1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var egg2: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.egg2), with: SWBowlActStory.egg2, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -33, y: -144)
//            let down = CGPoint(x: -26, y: -67)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.egg2)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .proteins: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("egg2")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var mushroom1: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.mushroom1), with: SWBowlActStory.mushroom1, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -72, y: -171)
//            let down = CGPoint(x: -85, y: -75)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.mushroom1)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .proteins: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("mushroom1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var mushroom2: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.mushroom2), with: SWBowlActStory.mushroom2, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 38.1, y: -169.9)
//            let down = CGPoint(x: 15.86, y: -61.14)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.mushroom2)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .proteins: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("mushroom2")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var protoleaf: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.protoleaf), with: SWBowlActStory.protoleaf, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 33.52, y: -117.7)
//            let down = CGPoint(x: 6, y: -15)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.protoleaf)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .proteins: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("protoleaf")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    // MARK: - Premaded Veggies
    
    class var brocolli1: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.brocolli1), with: SWBowlActStory.brocolli1, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -14, y: -134)
//            let down = CGPoint(x: 5, y: -79)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.brocolli1)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: original, alpha: invisible), differential: [
//                    .veggies: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("brocolli1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var brocolli2: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.brocolli2), with: SWBowlActStory.brocolli2, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 63, y: -148.5)
//            let down = CGPoint(x: 54, y: -27.5)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.brocolli2)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: original, alpha: invisible), differential: [
//                    .veggies: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("brocolli2")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var pepperony: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.pepperony), with: SWBowlActStory.pepperony, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -77, y: -200.5)
//            let down = CGPoint(x: -38, y: -88.5)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.pepperony)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: original, alpha: invisible), differential: [
//                    .veggies: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("pepperony")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var cucumber: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.cucumber), with: SWBowlActStory.cucumber, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 15, y: -188)
//            let down = CGPoint(x: 27, y: -99)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.cucumber)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .veggies: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("cucumber")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    // MARK: - Fats
    
    class var cashew1: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.cashew1), with: SWBowlActStory.cashew1, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -48.8, y: -182)
//            let down = CGPoint(x: -43, y: -65.5)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.cashew1)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .fats: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("cashew1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var cashew2: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.cashew2), with: SWBowlActStory.cashew2, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 75.5, y: -235)
//            let down = CGPoint(x: 49, y: -90)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.cashew2)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .fats: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("cashew2")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var avocado1: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.avocado1), with: SWBowlActStory.avocado1, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 0, y: -175)
//            let down = CGPoint(x: -80, y: -89)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.avocado1)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .fats: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("avocado1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    // MARK: - Enhancera
    
    class var olive1: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.olive1), with: SWBowlActStory.olive1, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -27.5, y: -239.5)
//            let down = CGPoint(x: -75.5, y: -87.5)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.olive1)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .ehancers: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("olive1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var olive2: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.olive2), with: SWBowlActStory.olive2, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: -4, y: -150)
//            let down = CGPoint(x: -13, y: -92)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.olive2)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .ehancers: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("olive2")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var olive3: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.olive3), with: SWBowlActStory.olive3, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 74, y: -169)
//            let down = CGPoint(x: 62, y: -102)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.olive3)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .ehancers: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("olive3")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
    
    class var pepper1: SWBowlSceneImage {
        get {
            let image = SWBowlSceneImage(UIImageView.init(image: UIImage.pepper1), with: SWBowlActStory.pepper1, in: .obey, at: .before)
            return image
            
//            let up = CGPoint(x: 33, y: -214)
//            let down = CGPoint(x: -23, y: -89)
//            let original = CGPoint(x: 1, y: 1)
//            let shrinked = CGPoint(x: 0.2, y: 0.2)
//            let invisible: CGFloat = 0
//            let visible: CGFloat = 1
//            let image = SWBowlSceneImage(
//                UIImageView.init(image: UIImage.pepper1)
//                , with: SWBowlActStory(initial: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible), differential: [
//                    .ehancers: [
//                        .before: SWBowlActParams(offset: up, scale: shrinked, alpha: invisible),
//                        .inbetween: SWBowlActParams(offset: up, scale: original, alpha: visible),
//                        .after: SWBowlActParams(offset: down, scale: original, alpha: visible)
//                    ]
//                ])
//                , in: .obey
//                , at: .before)
//
//            print("pepper1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
//            return image
        }
    }
}
