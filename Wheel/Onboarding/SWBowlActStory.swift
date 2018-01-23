//
//  SWBowlActStory.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
struct SWBowlActStory: Codable {
    
    let byState: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]]
    
    init(_ byState: [SWPagerStates: [SWBowlActSteps: SWBowlActParams]]) {
        self.byState = byState
    }
    
}
