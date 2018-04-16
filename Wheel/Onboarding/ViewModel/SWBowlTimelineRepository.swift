//
//  SWBowlTimeLineRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 16/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWBowlTimelineRepository {
    
    func get(by state: SWPagerStates) -> SWBowlTimeline
    
}
