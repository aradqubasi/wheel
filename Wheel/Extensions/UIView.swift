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
}
