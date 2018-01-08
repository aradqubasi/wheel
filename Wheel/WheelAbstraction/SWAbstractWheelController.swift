//
//  SWAbstractWheelController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol SWAbstractWheelController {
    
    var focused: PinView { get }
    
    var delegate: RadialControllerDelegate? { get set }
    
    var state: WState { get set }
    
    var label: UILabel { get set }
    
    func move(to index: Int) -> Void
    
    func moveToRandomPin()
}
