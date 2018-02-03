//
//  UIView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var toLayerView: UIView {
        get {
            let r = self.frame.width / 2
            self.backgroundColor = UIColor.white
            self.layer.cornerRadius = r
            self.layer.borderColor = UIColor.mystic.cgColor
            self.layer.borderWidth = 1
            self.layer.shadowColor = UIColor.aztec.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: -4, height: 0)
            self.layer.shadowRadius = 12
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: r).cgPath
            return self
        }
    }

    
    func attach(_ view: UIView) -> UIView {
        self.addSubview(view)
        return view
    }

    var radius: CGFloat {
        get {
            return max(frame.width, frame.height)
        }
    }
    
    class var bowlSun: UIView {
        get {
            let sun = UIView(frame: CGRect(origin: .zero, size: CGSize(side: 91)))
            let r = sun.frame.width / 2
            sun.backgroundColor = UIColor.candlelight
            sun.layer.cornerRadius = r
            sun.layer.borderColor = UIColor.candlelight.cgColor
            sun.layer.borderWidth = 1
            sun.layer.shadowColor = UIColor.candlelight.cgColor
            sun.layer.shadowOpacity = 1
            sun.layer.shadowOffset = .zero
            sun.layer.shadowRadius = 52
            sun.layer.shadowPath = UIBezierPath(roundedRect: sun.bounds.insetBy(dx: -41, dy: -41), cornerRadius: r + 41).cgPath
            return sun
        }
    }
}
