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
    
    func getOverlayMargin() -> CGFloat {
        return 40
    }
    
    func alignCircle(views: [UIView], center: CGPoint, radius: CGFloat, rotation: CGFloat) {
        
        let radius = radius * CGFloat(views.count) / 6.0
        
        for i in 0..<views.count {
            let step = CGFloat.pi * 2 / CGFloat(views.count)
            let pin = views[i]
            pin.center = center
            pin.transform = CGAffineTransform.identity.translatedBy(x: radius * cos(step * CGFloat(i) + rotation), y: radius * sin(step * CGFloat(i) + rotation))
        }
    }
    
    func alignToCenter(subwheel: UIView) {
        if let scene = subwheel.superview {
            var anchor: CGPoint = scene.getBoundsCenter()
            anchor.x = scene.bounds.width * 0.5 - subwheel.frame.width * 0.5
            anchor.y = scene.bounds.height * 0.5 - subwheel.frame.height * 0.5
            subwheel.frame.origin = anchor
        }
    }
}
