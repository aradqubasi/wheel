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
    
    var radius: CGFloat { get }
    
    var count: Int { get }
    
    var focused: PinView { get }
    
    var center: CGPoint { get }
    
    var index: Int { get }
    
    var delegate: SWAbstractWheelControllerDelegate? { get set }
    
    var state: WState { get set }
    
    var active: WState { get }
    
    var label: UILabel { get set }
    
    var isLocked: Bool { get }
    
    func move(to index: Int) -> Void
    
    func move(by angle: CGFloat) -> Void
    
    func moveToRandomPin()
    
    func refill(with pool: [SWIngredient]) -> Void
    
    func flush() -> Void
    
    func lock(on pin: PinView) -> Void
    
    func unlock() -> Void
}
