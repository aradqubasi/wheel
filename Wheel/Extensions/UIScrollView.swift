//
//  UIScrollView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

extension UIScrollView {

    var toSelectedHolderView: UIScrollView {
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

}
