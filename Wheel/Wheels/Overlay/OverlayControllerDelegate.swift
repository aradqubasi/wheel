//
//  OverlayControllerDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol OverlayControllerDelegate {
    func onClose(of controller: OverlayController) -> Void
    
    func onSelect(in controller: OverlayController) -> Void
}
