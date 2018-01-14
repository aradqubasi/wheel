//
//  SelectionControllerDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 17/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SelectionDelegate {
    func onRemove(of pin: Floatable, in controller: SelectionController)
    func onCook(of pins: [Floatable], in controller: SelectionController)
}
