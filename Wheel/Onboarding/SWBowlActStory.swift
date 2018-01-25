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
    
    // MARK: - Premadees
    
    class var frontbowl: SWBowlActStory {
        get {
            return getBy(name: "frontbowl")
        }
    }
    
    class var backbowl: SWBowlActStory {
        get {
            return getBy(name: "backbowl")
        }
    }
    
    class var spoon: SWBowlActStory {
        get {
            return getBy(name: "spoon")
        }
    }
    
    class var backleaf1: SWBowlActStory {
        get {
            return getBy(name: "backleaf1")
        }
    }
    
    class var backleaf2: SWBowlActStory {
        get {
            return getBy(name: "backleaf2")
        }
    }
    
    class var backleaf3: SWBowlActStory {
        get {
            return getBy(name: "backleaf3")
        }
    }
    
    class var backleaf4: SWBowlActStory {
        get {
            return getBy(name: "backleaf4")
        }
    }
    
    class var frontleaf1: SWBowlActStory {
        get {
            return getBy(name: "frontleaf1")
        }
    }
    
    class var frontleaf2: SWBowlActStory {
        get {
            return getBy(name: "frontleaf2")
        }
    }
    
    class var frontleaf3: SWBowlActStory {
        get {
            return getBy(name: "frontleaf3")
        }
    }
    
    class var frontleaf4: SWBowlActStory {
        get {
            return getBy(name: "frontleaf4")
        }
    }
    
    class var frontleaf5: SWBowlActStory {
        get {
            return getBy(name: "frontleaf5")
        }
    }
    
    class var egg1: SWBowlActStory {
        get {
            return getBy(name: "egg1")
        }
    }
    
    class var egg2: SWBowlActStory {
        get {
            return getBy(name: "egg2")
        }
    }
    
    class var mushroom1: SWBowlActStory {
        get {
            return getBy(name: "mushroom1")
        }
    }
    
    class var mushroom2: SWBowlActStory {
        get {
            return getBy(name: "mushroom2")
        }
    }
    
    class var protoleaf: SWBowlActStory {
        get {
            return getBy(name: "protoleaf")
        }
    }
    
    class var brocolli1: SWBowlActStory {
        get {
            return getBy(name: "brocolli1")
        }
    }
    
    class var brocolli2: SWBowlActStory {
        get {
            return getBy(name: "brocolli2")
        }
    }
    
    class var cucumber: SWBowlActStory {
        get {
            return getBy(name: "cucumber")
        }
    }
    
    class var pepperony: SWBowlActStory {
        get {
            return getBy(name: "pepperony")
        }
    }
    
    class var cashew1: SWBowlActStory {
        get {
            return getBy(name: "cashew1")
        }
    }
    
    class var cashew2: SWBowlActStory {
        get {
            return getBy(name: "cashew2")
        }
    }
    
    class var avocado1: SWBowlActStory {
        get {
            return getBy(name: "avocado1")
        }
    }
    
    class var olive1: SWBowlActStory {
        get {
            return getBy(name: "olive1")
        }
    }
    
    class var olive2: SWBowlActStory {
        get {
            return getBy(name: "olive2")
        }
    }
    
    class var olive3: SWBowlActStory {
        get {
            return getBy(name: "olive3")
        }
    }
    
    class var pepper1: SWBowlActStory {
        get {
            return getBy(name: "pepper1")
        }
    }
}
