//
//  SWConcreteWheelsAligner.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWWideWheelsAligner: SWWheelsAligner {
    
    private func align(_ view: UIView, at index: Int) {
        guard let superview = view.superview else {
            fatalError("can not align view which is not attached to superview")
        }
        let initial = CGPoint(x: 16, y: superview.bounds.height / 3)
        let delta = (superview.bounds.height / 3 - 56 * 3) * 0.5
        view.frame.origin = CGPoint(x: initial.x, y: initial.y + (delta + 56) * CGFloat(index))
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
        let size = UIScreen.main.bounds.size
        
        if let scene = subwheel.superview {
            let projection = button.convert(button.bounds, to: scene)
            
            var anchor: CGPoint = .zero
            anchor.x = projection.origin.x + projection.width * 0.5
            if projection.origin.y <= scene.bounds.height * 0.5 {
                anchor.y = projection.origin.y
                anchor.y += projection.height * 0.5 - 72
            }
            else {
                anchor.y = projection.origin.y
                anchor.y += projection.height * 0.5 - subwheel.frame.size.height + 72
            }
            subwheel.frame.origin = anchor
        }
    }
}
