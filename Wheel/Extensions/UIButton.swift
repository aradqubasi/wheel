//
//  UIButton.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    
    var toRollButton: UIButton {
        get {
            self.backgroundColor = UIColor.shamrock
            self.layer.cornerRadius = self.frame.size.width / 2
            self.setImage(UIImage.dice, for: .normal)
            self.imageEdgeInsets.left = -40
            self.imageEdgeInsets.right = 40
            return self
        }
    }
    
    var asToUnexpected: UIButton {
        get {
//            self.backgroundColor = UIColor.gray
            self.setImage(UIImage.unexpected, for: .normal)
            self.layer.cornerRadius = 28
            self.frame.size = CGSize(side: 56)
            return self
        }
    }
}
