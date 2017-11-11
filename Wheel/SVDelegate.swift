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

    func spokeView(for spoke: SpokeView, update pin: UIView) -> Void
    
    func spokeView(_ spoke: SpokeView) -> SVSettings

}
