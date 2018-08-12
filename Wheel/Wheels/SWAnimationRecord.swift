//
//  SWAnimationRecord.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 12/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWAnimationRecord {
    var type: SWAnimationTypes
    var startTime: Date
    var endTime: Date?
    init(of type: SWAnimationTypes) {
        self.type = type
        startTime = Date()
    }
}

