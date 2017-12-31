//
//  SWWheelProtocol.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 31/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol SWWheelProtocol {
    var focused: Int { get }
    var count: Int { get }
    var delegate: SWWheelDelegate? { get set }
    var name: String { get set }
//    func 
}
