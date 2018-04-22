//
//  SWRingMaskDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol SWRingMaskDelegate {
    func onHit(_ sender: SWRingMaskView, with event: UIEvent?, on receiver: UIView?) -> Void
}
