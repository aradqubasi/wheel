//
//  SWBowlActStory.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWBowlActStory: Codable {
    
    let initial: SWBowlActParams
    
    let differential: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]]
    
    init(initial: SWBowlActParams, differential: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]]) {
        self.differential = differential
        self.initial = initial
    }
    
    // MARK: - Private Methods
    
    private static func getBy(name asset: String) -> SWBowlActStory {
        guard let data = NSDataAsset(name: asset)?.data else {
            fatalError("data asset \(asset) does not exists")
        }
        var parsed: SWBowlActStory?
        do {
            parsed = try JSONDecoder().decode(SWBowlActStory.self, from: data)
        } catch {
            print("\(error)")
        }
        guard let value = parsed else {
            fatalError("data asset \(asset) have invalid contents")
        }
        return value
    }
    
    private static func getBy(asset: NSDataAsset) -> SWBowlActStory {
        let data = asset.data
        var parsed: SWBowlActStory?
        do {
            parsed = try JSONDecoder().decode(SWBowlActStory.self, from: data)
        } catch {
            print("\(error)")
        }
        guard let value = parsed else {
            fatalError("data asset \(asset) have invalid contents")
        }
        return value
    }
    
    // MARK: - Premadees
    
    class var frontbowl: SWBowlActStory {
        get {
//            return getBy(name: "frontbowl")
            return getBy(asset: NSDataAsset.frontbowl)
        }
    }
    
    class var backbowl: SWBowlActStory {
        get {
//            return getBy(name: "backbowl")
            return getBy(asset: NSDataAsset.backbowl)
        }
    }
    
    class var spoon: SWBowlActStory {
        get {
//            return getBy(name: "spoon")
            return getBy(asset: NSDataAsset.spoon)
        }
    }
    
    class var backleaf1: SWBowlActStory {
        get {
//            return getBy(name: "backleaf1")
            return getBy(asset: NSDataAsset.backleaf1)
        }
    }
    
    class var backleaf2: SWBowlActStory {
        get {
//            return getBy(name: "backleaf2")
            return getBy(asset: NSDataAsset.backleaf2)
        }
    }
    
    class var backleaf3: SWBowlActStory {
        get {
//            return getBy(name: "backleaf3")
            return getBy(asset: NSDataAsset.backleaf3)
        }
    }
    
    class var backleaf4: SWBowlActStory {
        get {
//            return getBy(name: "backleaf4")
            return getBy(asset: NSDataAsset.backleaf4)
        }
    }
    
    class var frontleaf1: SWBowlActStory {
        get {
//            return getBy(name: "frontleaf1")
            return getBy(asset: NSDataAsset.frontleaf1)
        }
    }
    
    class var frontleaf2: SWBowlActStory {
        get {
//            return getBy(name: "frontleaf2")
            return getBy(asset: NSDataAsset.frontleaf2)
        }
    }
    
    class var frontleaf3: SWBowlActStory {
        get {
//            return getBy(name: "frontleaf3")
            return getBy(asset: NSDataAsset.frontleaf3)
        }
    }
    
    class var frontleaf4: SWBowlActStory {
        get {
//            return getBy(name: "frontleaf4")
            return getBy(asset: NSDataAsset.frontleaf4)
        }
    }
    
    class var frontleaf5: SWBowlActStory {
        get {
//            return getBy(name: "frontleaf5")
            return getBy(asset: NSDataAsset.frontleaf5)
        }
    }
    
    class var egg1: SWBowlActStory {
        get {
//            return getBy(name: "egg1")
            return getBy(asset: NSDataAsset.egg1)
        }
    }
    
    class var egg2: SWBowlActStory {
        get {
//            return getBy(name: "egg2")
            return getBy(asset: NSDataAsset.egg2)
        }
    }
    
    class var mushroom1: SWBowlActStory {
        get {
//            return getBy(name: "mushroom1")
            return getBy(asset: NSDataAsset.mushroom1)
        }
    }
    
    class var mushroom2: SWBowlActStory {
        get {
//            return getBy(name: "mushroom2")
            return getBy(asset: NSDataAsset.mushroom2)
        }
    }
    
    class var protoleaf: SWBowlActStory {
        get {
//            return getBy(name: "protoleaf")
            return getBy(asset: NSDataAsset.protoleaf)
        }
    }
    
    class var brocolli1: SWBowlActStory {
        get {
//            return getBy(name: "brocolli1")
            return getBy(asset: NSDataAsset.brocolli1)
        }
    }
    
    class var brocolli2: SWBowlActStory {
        get {
//            return getBy(name: "brocolli2")
            return getBy(asset: NSDataAsset.brocolli2)
        }
    }
    
    class var cucumber: SWBowlActStory {
        get {
//            return getBy(name: "cucumber")
            return getBy(asset: NSDataAsset.cucumber)
        }
    }
    
    class var pepperony: SWBowlActStory {
        get {
//            return getBy(name: "pepperony")
            return getBy(asset: NSDataAsset.pepperony)
        }
    }
    
    class var cashew1: SWBowlActStory {
        get {
//            return getBy(name: "cashew1")
            return getBy(asset: NSDataAsset.cashew1)
        }
    }
    
    class var cashew2: SWBowlActStory {
        get {
//            return getBy(name: "cashew2")
            return getBy(asset: NSDataAsset.cashew2)
        }
    }
    
    class var avocado1: SWBowlActStory {
        get {
//            return getBy(name: "avocado1")
            return getBy(asset: NSDataAsset.avocado1)
        }
    }
    
    class var olive1: SWBowlActStory {
        get {
//            return getBy(name: "olive1")
            return getBy(asset: NSDataAsset.olive1)
        }
    }
    
    class var olive2: SWBowlActStory {
        get {
//            return getBy(name: "olive2")
            return getBy(asset: NSDataAsset.olive2)
        }
    }
    
    class var olive3: SWBowlActStory {
        get {
//            return getBy(name: "olive3")
            return getBy(asset: NSDataAsset.olive3)
        }
    }
    
    class var pepper1: SWBowlActStory {
        get {
//            return getBy(name: "pepper1")
            return getBy(asset: NSDataAsset.pepper1)
        }
    }
    
    class var leafsTitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.leafsTitle)
        }
    }
    
    class var leafsSubtitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.leafsSubtitle)
        }
    }
    
    class var onboardingHeader: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.onboardingHeader)
        }
    }
    
    class var proteinsTitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.proteinsTitle)
        }
    }
    
    class var proteinsSubtitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.proteinsSubtitle)
        }
    }
    
    class var veggiesTitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.veggiesTitle)
        }
    }
    
    class var veggiesSubtitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.veggiesSubtitle)
        }
    }
    
    class var fatsTitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.fatsTitle)
        }
    }
    
    class var fatsSubtitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.fatsSubtitle)
        }
    }
    
    class var enhancersTitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.enhancersTitle)
        }
    }
    
    class var enhancersSubtitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.enhancersSubtitle)
        }
    }
    
    class var leftBowlEye: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.leftBowlEye)
        }
    }
    
    class var rightBowlEye: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.rightBowlEye)
        }
    }
    
    class var leftBowlCheek: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.leftBowlCheek)
        }
    }
    
    class var rightBowlCheek: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.rightBowlCheek)
        }
    }
    
    class var bowlMounth: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.bowlMounth)
        }
    }
    
    class var bowlSun: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.bowlSun)
        }
    }
    
    class var proceedTitle: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.proceedTitle)
        }
    }
    
    class var skip: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.skip)
        }
    }
    
    class var proceed: SWBowlActStory {
        get {
            return getBy(asset: NSDataAsset.proceed)
        }
    }
}
