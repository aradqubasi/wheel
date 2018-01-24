//
//  SWBowlActStory.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
struct SWBowlActStory: Codable {
    
    let initial: SWBowlActParams
    
    let differential: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]]
    
    init(initial: SWBowlActParams, differential: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]]) {
        self.differential = differential
        self.initial = initial
    }
    
    // MARK: - Private Methods
    
    private static func getBy(name asset: String) -> SWBowlActParams {
        guard let data = NSDataAsset(name: asset)?.data else {
            fatalError("data asset \(asset) does not exists")
        }
        var parsed: SWBowlActParams?
        do {
            parsed = try JSONDecoder().decode(SWBowlActParams.self, from: data)
        } catch {
            print("\(error)")
        }
        guard let value = parsed else {
            fatalError("data asset \(asset) have invalid contents")
        }
        return value
    }
    
    // MARK: - Premadees
    
    class var frontbowl: SWBowlActParams {
        get {
            return getBy(name: ""<#T##String#>"")
        }
    }
    
}
