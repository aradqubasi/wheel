//
//  SWConcreteBowlTimelineRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 16/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemoryBowlTimelineRepository : SWBowlTimelineRepository {
    
    func get(by state: SWPagerStates) -> SWBowlTimeline {
        switch state {
        case .obey:
            return SWBowlTimeline(state: .obey, time: 0, toInbetween: 0, toAfter: 0, toBack: 0)
        case .proceed, .leafs:
            return SWBowlTimeline(state: state, time: 0.5, toInbetween: 0.5, toAfter: 0.5, toBack: 0.35)
       default:
            return SWBowlTimeline(state: state, time: 0.5, toInbetween: 0, toAfter: 0.5, toBack: 0.35)
        }
    }
    
}
