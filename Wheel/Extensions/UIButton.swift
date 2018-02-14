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
            self.setImage(UIImage.unexpected, for: .normal)
            self.layer.cornerRadius = 28
            self.frame.size = CGSize(side: 56)
            return self
        }
    }
    
    var asToDressing: UIButton {
        get {
            self.setImage(UIImage.dressing, for: .normal)
            self.layer.cornerRadius = 28
            self.frame.size = CGSize(side: 56)
            return self
        }
    }
    
    var asToFruits: UIButton {
        get {
            self.setImage(UIImage.fruits, for: .normal)
            self.layer.cornerRadius = 28
            self.frame.size = CGSize(side: 56)
            return self
        }
    }
    
    // MARK: - Premadees
    
    class var skip: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 126, height: 21)))
            button.setAttributedTitle(NSAttributedString.skip, for: .normal)
            return button
        }
    }
    
    class var proceed: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 126, height: 21)))
            button.setAttributedTitle(NSAttributedString.proceed, for: .normal)
            return button
        }
    }
    
    class var ok: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 414, height: 63)))
            button.backgroundColor = .shamrock
            button.setAttributedTitle(NSAttributedString.ok, for: .normal)
            button.setAttributedTitle(NSAttributedString.grayok, for: .highlighted)
            return button
        }
    }
    
}
