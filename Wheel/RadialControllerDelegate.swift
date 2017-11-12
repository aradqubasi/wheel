//
//  RadialControllerDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol RadialControllerDelegate {
    func onStateChange(to state: WState, of wheel: RadialView) -> Void
}
