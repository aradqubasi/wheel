//
//  SWNarrowWheelsAligner.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWNarrowWheelsAligner: SWWheelsAligner {
    
    private func align(_ view: UIView, at index: Int) {
        guard let superview = view.superview else {
            fatalError("can not align view which is not attached to superview")
        }
        var central = CGPoint(x: superview.bounds.width * 0.5 - 56 * 0.5, y: 80)
        switch (index) {
        case 0:
            central.x = central.x - 24 - 56
        case 1:
            break
        case 2:
            central.x = central.x + 56 + 24
        default:
            fatalError("can not align @ position \(index)")
        }
        view.frame.origin = central
    }
    
    func align(unexpected: UIView) {
        align(unexpected, at: 0)
    }
    
    func align(fruits: UIView) {
        align(fruits, at: 1)
    }
    
    func align(dressing: UIView) {
        align(dressing, at: 2)
    }
    
    func align(subwheel: UIView, with button: UIView) {
        if let scene = subwheel.superview {
            let projection = button.convert(button.bounds, to: scene)
            
            var anchor: CGPoint = .zero
            anchor.x = scene.bounds.width * 0.5 - subwheel.frame.width * 0.5
            anchor.y = projection.origin.y + projection.height + 16
            subwheel.frame.origin = anchor
        }
    }
}
