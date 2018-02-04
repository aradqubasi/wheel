//
//  SWBowlImage.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 19/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWBowlSceneView {

    // MARK: - Provaye Properties

    private var _image: UIView
    
    private var _state: SWPagerStates
    
    private var _step: SWBowlActSteps
    
//    private let _story: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]]
    
    private let _story: SWBowlActStory
    
    // MARK: - Public Properties
    
    var image: UIView {
        get {
            return _image
        }
    }
    
    var name: String = ""
    
    // MARK: - Initialization
    
    init (_ image: UIView, with story: SWBowlActStory, in initial: SWPagerStates, at step: SWBowlActSteps) {
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

    class var frontbowl: SWBowlSceneView {
        get {
            let image = SWBowlSceneView.init(UIImageView.init(image: UIImage.frontbowl), with: SWBowlActStory.frontbowl, in: .obey, at: .before)
            return image
        }
    }
    
    class var backbowl: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.backbowl), with: SWBowlActStory.backbowl, in: .obey, at: .before)
            return image
        }
    }
    
    class var spoon: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.spoon), with: SWBowlActStory.spoon, in: .obey, at: .before)
            return image
        }
    }
    
    class var backleaf1: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.backleaf1), with: SWBowlActStory.backleaf1, in: .obey, at: .before)
            return image
        }
    }

    class var backleaf2: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.backleaf2), with: SWBowlActStory.backleaf2, in: .obey, at: .before)
            return image
        }
    }
 
    class var backleaf3: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.backleaf3), with: SWBowlActStory.backleaf3, in: .obey, at: .before)
            return image
        }
    }

    class var backleaf4: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.backleaf4), with: SWBowlActStory.backleaf4, in: .obey, at: .before)
            return image
        }
    }
    
    class var frontleaf1: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.frontleaf1), with: SWBowlActStory.frontleaf1, in: .obey, at: .before)
            return image
        }
    }
    
    class var frontleaf2: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.frontleaf2), with: SWBowlActStory.frontleaf2, in: .obey, at: .before)
            return image
        }
    }
    
    class var frontleaf3: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.frontleaf3), with: SWBowlActStory.frontleaf3, in: .obey, at: .before)
            return image
        }
    }
    
    class var frontleaf4: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.frontleaf4), with: SWBowlActStory.frontleaf4, in: .obey, at: .before)
            return image
        }
    }
    
    class var frontleaf5: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.frontleaf5), with: SWBowlActStory.frontleaf5, in: .obey, at: .before)
            return image
        }
    }
    
    // MARK: - Proteins Scene Actors
    
    class var egg1: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.egg1), with: SWBowlActStory.egg1, in: .obey, at: .before)
            return image
        }
    }
    
    class var egg2: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.egg2), with: SWBowlActStory.egg2, in: .obey, at: .before)
            return image
        }
    }
    
    class var mushroom1: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.mushroom1), with: SWBowlActStory.mushroom1, in: .obey, at: .before)
            return image
        }
    }
    
    class var mushroom2: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.mushroom2), with: SWBowlActStory.mushroom2, in: .obey, at: .before)
            return image
        }
    }
    
    class var protoleaf: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.protoleaf), with: SWBowlActStory.protoleaf, in: .obey, at: .before)
            return image
        }
    }
    
    // MARK: - Premaded Veggies
    
    class var brocolli1: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.brocolli1), with: SWBowlActStory.brocolli1, in: .obey, at: .before)
            return image
        }
    }
    
    class var brocolli2: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.brocolli2), with: SWBowlActStory.brocolli2, in: .obey, at: .before)
            return image
        }
    }
    
    class var pepperony: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.pepperony), with: SWBowlActStory.pepperony, in: .obey, at: .before)
            return image
        }
    }
    
    class var cucumber: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.cucumber), with: SWBowlActStory.cucumber, in: .obey, at: .before)
            return image
        }
    }
    
    // MARK: - Fats
    
    class var cashew1: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.cashew1), with: SWBowlActStory.cashew1, in: .obey, at: .before)
            return image
        }
    }
    
    class var cashew2: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.cashew2), with: SWBowlActStory.cashew2, in: .obey, at: .before)
            return image
        }
    }
    
    class var avocado1: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.avocado1), with: SWBowlActStory.avocado1, in: .obey, at: .before)
            return image
        }
    }
    
    // MARK: - Enhancera
    
    class var olive1: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.olive1), with: SWBowlActStory.olive1, in: .obey, at: .before)
            return image
        }
    }
    
    class var olive2: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.olive2), with: SWBowlActStory.olive2, in: .obey, at: .before)
            return image
        }
    }
    
    class var olive3: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.olive3), with: SWBowlActStory.olive3, in: .obey, at: .before)
            return image
        }
    }
    
    class var pepper1: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.pepper1), with: SWBowlActStory.pepper1, in: .obey, at: .before)
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
    
    class var obeyTitle: SWBowlSceneView {
        get {
            let center = CGPoint(x: 0, y: 0)
            let left = CGPoint(x: -812, y: 0)
            let original = CGPoint(x: 1, y: 1)
            let visible: CGFloat = 1
            let image = SWBowlSceneView(
                UILabel.obeyLabel
                , with: SWBowlActStory(initial: SWBowlActParams(offset: center, scale: original, alpha: visible), differential: [
                    .leafs: [
                        .inbetween: SWBowlActParams(offset: left, scale: original, alpha: visible),
                    ]
                    ])
                , in: .obey
                , at: .before)
            
//            print("pepper1")
//            do {
//                let serialized = try? JSONEncoder().encode(image._story)
//                print(String(data: serialized!, encoding: String.Encoding.utf8) as String!)
//            } catch {
//                print("\(error)")
//            }
            return image
        }
    }
    
    class var leafsTitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.leafsTitle, with: SWBowlActStory.leafsTitle, in: .obey, at: .before)
            label.name = "leafsTitle"
            return label
        }
    }
    
    class var leafsSubtitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.leafsSubtitle, with: SWBowlActStory.leafsSubtitle, in: .obey, at: .before)
            label.name = "leafsSubtitle"
            return label
        }
    }
    
    class var onboardingHeader: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.onboardingHeader, with: SWBowlActStory.onboardingHeader, in: .obey, at: .before)
            return label
        }
    }
    
    class var proteinsTitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.proteinsTitle, with: SWBowlActStory.proteinsTitle, in: .obey, at: .before)
            return label
        }
    }
    
    class var proteinsSubtitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.proteinsSubtitle, with: SWBowlActStory.proteinsSubtitle, in: .obey, at: .before)
            return label
        }
    }
    
    class var veggiesTitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.veggiesTitle, with: SWBowlActStory.veggiesTitle, in: .obey, at: .before)
            return label
        }
    }
    
    class var veggiesSubtitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.veggiesSubtitle, with: SWBowlActStory.veggiesSubtitle, in: .obey, at: .before)
            return label
        }
    }
    
    class var fatsTitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.fatsTitle, with: SWBowlActStory.fatsTitle, in: .obey, at: .before)
            return label
        }
    }
    
    class var fatsSubtitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.fatsSubtitle, with: SWBowlActStory.fatsSubtitle, in: .obey, at: .before)
            return label
        }
    }
    
    class var enhancersTitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.enhancersTitle, with: SWBowlActStory.enhancersTitle, in: .obey, at: .before)
            return label
        }
    }
    
    class var enhancersSubtitle: SWBowlSceneView {
        get {
            let label = SWBowlSceneView(UILabel.enhacersSubtitle, with: SWBowlActStory.enhancersSubtitle, in: .obey, at: .before)
            return label
        }
    }
    
    class var leftBowlEye: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.leftBowlEye), with: SWBowlActStory.leftBowlEye, in: .obey, at: .before)
            return image
        }
    }
    
    class var rightBowlEye: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.rightBowlEye), with: SWBowlActStory.rightBowlEye, in: .obey, at: .before)
            return image
        }
    }
    
    class var leftBowlCheek: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.leftBowlCheek), with: SWBowlActStory.leftBowlCheek, in: .obey, at: .before)
            return image
        }
    }
    
    class var rightBowlCheek: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.rightBowlCheek), with: SWBowlActStory.rightBowlCheek, in: .obey, at: .before)
            return image
        }
    }
    
    class var bowlMounth: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIImageView.init(image: UIImage.bowlMounth), with: SWBowlActStory.bowlMounth, in: .obey, at: .before)
            return image
        }
    }
    
    class var bowlSun: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIView.bowlSun, with: SWBowlActStory.bowlSun, in: .obey, at: .before)
            return image
        }
    }
    
    class var proceedTitle: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UILabel.proceedTitle, with: SWBowlActStory.proceedTitle, in: .obey, at: .before)
            return image
        }
    }
    
    class var skip: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIButton.skip, with: SWBowlActStory.skip, in: .obey, at: .before)
            return image
        }
    }
    
    class var proceed: SWBowlSceneView {
        get {
            let image = SWBowlSceneView(UIButton.proceed, with: SWBowlActStory.proceed, in: .obey, at: .before)
            return image
        }
    }
}
