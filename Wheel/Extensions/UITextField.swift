//
//  UITextField.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    class var email: UITextField {
        get {
            let input = UITextField()
            input.attributedPlaceholder = .emailPlaceholder
            input.textAlignment = .center
            input.frame.size = CGSize(width: 200, height: 33)
            input.font = UIFont(name: "Avenir-Light", size: 24)
            return input
        }
    }
    
}
