//
//  ScreenViewDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 19/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol HitDelegate {
    
    func on(hit sender: Any, with event: UIEvent?) -> Void
    
}
