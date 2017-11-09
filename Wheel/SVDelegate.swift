//
//  SVDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/10/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SVDelegate {
//    func getPicture(_ spoke: SpokeView, _ state: RVSpokeState) -> SVSettings
//    func spokeView(pinFor spoke: SpokeView) -> UIView
    
    func spokeView(for spoke: SpokeView, update pin: UIView) -> Void
    
    func spokeView(_ spoke: SpokeView) -> SVSettings
//
//    func onPinClick(_ spoke: SpokeView, _ state: RVSpokeState) -> Void
}
