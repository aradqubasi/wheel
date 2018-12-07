//
//  SWSliderDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/12/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWSliderViewDelegate {
    
    func onUpdate(of progress: Double) -> Void
    
    func getColor(for progress: Double) -> UIColor
    
}
