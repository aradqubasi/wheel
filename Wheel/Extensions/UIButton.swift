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
//            self.backgroundColor = UIColor.shamrock
            self.backgroundColor = UIColor.casablanca
            self.layer.cornerRadius = self.frame.size.width / 2
            self.setImage(UIImage.dice, for: .normal)
            self.imageEdgeInsets.left = -40
            self.imageEdgeInsets.right = 40
            return self
        }
    }
    
    var toTextRollButton: UIButton {
        get {
            self.backgroundColor = UIColor.casablanca
            self.layer.cornerRadius = self.frame.size.width / 2
            self.setAttributedTitle(NSAttributedString(string: "ROLL").avenirHeavfy(12).whitify().kernify(0.6), for: .normal)
            self.titleEdgeInsets.top = -72
            self.imageEdgeInsets.bottom = 72
            self.transform = CGAffineTransform.identity.rotated(by: -CGFloat.pi * 0.5)
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
            button.setAttributedTitle(NSAttributedString.skip.invert(), for: .highlighted)
            return button
        }
    }
    
    class var proceed: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 126, height: 21)))
            button.setAttributedTitle(NSAttributedString.proceed, for: .normal)
            button.setAttributedTitle(NSAttributedString.proceed.invert(), for: .highlighted)
            return button
        }
    }
    
    class var ok: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 414, height: 63)))
            button.backgroundColor = .shamrock
            button.setAttributedTitle(NSAttributedString.ok, for: .normal)
            button.setAttributedTitle(NSAttributedString.ok.invert(), for: .highlighted)
//            button.setAttributedTitle(NSAttributedString.grayok, for: .highlighted)
            return button
        }
    }

    class var increase: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 32)))
            button.backgroundColor = .white
            button.setImage(.increase, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.shamrock.cgColor
            let path = UIBezierPath(roundedRect:button.bounds, byRoundingCorners:[.topRight, .bottomRight], cornerRadii: CGSize(width: 3, height:  3))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            button.layer.mask = maskLayer
            return button
        }
    }
    
    class var decrease: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 32)))
            button.backgroundColor = .white
            button.setImage(.decrease, for: .normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.shamrock.cgColor
            let path = UIBezierPath(roundedRect:button.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize(width: 3, height:  3))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            button.layer.mask = maskLayer
            return button
        }
    }
    
    class var lock: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 32)))
            button.backgroundColor = UIColor.azureradiance
            button.layer.cornerRadius = 16
            button.clipsToBounds = false
            button.setImage(UIImage.lock, for: .normal)
            return button
        }
    }
    
    class var showSteps: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 176, height: 56)))
            button.backgroundColor = UIColor.shamrock
            button.layer.cornerRadius = 28
            button.clipsToBounds = false
            button.setAttributedTitle(.showSteps, for: .normal)
            button.setAttributedTitle(NSAttributedString.showSteps.invert(), for: .highlighted)
            return button
        }
    }
    
    class var iwant: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 414, height: 63)))
            button.backgroundColor = .shamrock
            button.setAttributedTitle(NSAttributedString.ok, for: .normal)
            button.setAttributedTitle(NSAttributedString.ok.invert(), for: .highlighted)
            return button
        }
    }
    
    class var cook: UIButton {
        get {
            let cook = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 96))
            cook.setImage(UIImage.nextpressed, for: .normal)
//            cook.layer.borderColor = UIColor.red.cgColor
//            cook.layer.borderWidth = 1
            return cook
        }
    }
    
    func invertTextColors() {
        setAttributedTitle(self.attributedTitle(for: .normal)?.invert(), for: .normal)
        setAttributedTitle(self.attributedTitle(for: .highlighted)?.invert(), for: .highlighted)
    }
    
    class var saveRecipy: UIButton {
        get {
            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 176, height: 56)))
            button.backgroundColor = UIColor.shamrock
            button.layer.cornerRadius = 28
            button.clipsToBounds = false
            button.setAttributedTitle(.saveRecipy, for: .normal)
            button.setAttributedTitle(NSAttributedString.saveRecipy.invert(), for: .highlighted)
            return button
        }
    }
    
}
