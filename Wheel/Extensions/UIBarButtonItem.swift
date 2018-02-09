//
//  UIBarButtonItem.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
extension UIBarButtonItem {
    
    class var filter: UIBarButtonItem {
        get {
            let button = UIBarButtonItem(image: .filter, style: .plain, target: nil, action: nil)
            return button
        }
    }
    
    class var hamburger: UIBarButtonItem {
        get {
            let button = UIBarButtonItem(image: .hamburger, style: .plain, target: nil, action: nil)
            return button
        }
    }
    
}
