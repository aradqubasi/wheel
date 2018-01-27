//
//  UILabel.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 27/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    
    class var obeyLabel: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 340, height: 141)
            label.attributedText = NSAttributedString.obeyTitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var leafsTitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.leafsTitle
            label.textAlignment = .center
            return label
        }
    }
    
}
