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
    
    var toSelectedIngridientsView: UIView {
        get {
            guard let parent = self.superview else {
                fatalError("selectedIngridientsView is not attaced to superview")
            }
            
            self.frame.size = CGSize(width: parent.bounds.width - 32, height: 96)
            self.frame.origin = CGPoint(x: 16, y: parent.bounds.height - 16 - 96)
            
            self.backgroundColor = UIColor.white
            
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.porcelain.cgColor
            
            self.layer.shadowColor = UIColor.gallery.cgColor
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = CGSize(width: 0, height: 2)
            self.layer.shadowRadius = 9
            self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
            return self
        }
    }
    
    func attach(_ view: UIView) -> UIView {
        self.addSubview(view)
        return view
    }
    
//    func attach(to view: UIView) -> UIView {
//        view.addSubview(self)
//    }
}
