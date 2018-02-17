//
//  String.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 15/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
extension String {
    
    var toFilterOptionCaption: NSAttributedString {
        get {
            let text = NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
            return text
        }
    }
    
}
