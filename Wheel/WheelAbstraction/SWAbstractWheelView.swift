//
//  SWWheelProtocol.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 31/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol SWAbstractWheelView {
    
    var index: Int { get }
    
    var count: Int { get }
    
    var delegate: SWAbstractWheelDelegate? { get set }
    
    var name: String { get set }

}
