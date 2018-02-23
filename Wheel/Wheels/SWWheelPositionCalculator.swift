//
//  SWWheelPositionCalculator.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWWheelPositionCalculator {
    
    /**get estimated positions of pointer per state*/
    func getPointerPositions(from center: CGPoint, toward direction: CGPoint) -> [WState:CGPoint]
    
    /**get radiuses and scale per state for wheel of specified kind*/
    func getWheelGeometry(of kind: WState) -> [WState:WSettings]
    
}

class SWConcreteWheelPositionCalculator: SWWheelPositionCalculator {
    
    private let basePinWidth: CGFloat = 42
    
    private let inset: CGFloat = 5
    
    private let activeScale: CGFloat = 1
    
    private let usualScale: CGFloat = 1
    
    private let mark: CGFloat = 14
    
    private let pointer: CGFloat = 12
    
    private let foundation: CGFloat = 78
    
    private let available: [WState] = [.bases, .fats, .veggies, .proteins]
    
    func getPointerPositions(from center: CGPoint, toward direction: CGPoint) -> [WState : CGPoint] {
        var positions: [WState : CGPoint] = [:]
        
        for state in available {
            guard let radius = getWheelGeometry(of: state)[state]?.radius else {
                fatalError("undefined state \(state)")
            }
            let distance = radius - (mark + basePinWidth * activeScale + inset)
            // TODO: - use center and direction
            positions[state] = CGPoint(x: center.x - distance + pointer * 0.5, y: center.y)
        }
        return positions
    }
    
    func getWheelGeometry(of kind: WState) -> [WState : WSettings] {

        var settings: [WState : WSettings] = [:]
        let pin: CGFloat = basePinWidth
        guard let number: Int = WState.all.index(of: kind) else {
            fatalError("state does not exists at WState.all collection")
        }
        
        let usualThickness: CGFloat = mark + pin * usualScale + inset
        let activeThickness: CGFloat = pointer + mark + pin * activeScale + inset
        var before = true
        for state in WState.all {
            let isActive = state == kind
            before = isActive ? false : before
            let radius: CGFloat = foundation + CGFloat(number) * usualThickness + (before || isActive ? activeThickness : usualThickness)
            settings[state] = WSettings(radius, isActive ? activeScale : usualScale)
        }
        
        return settings
    }
}
