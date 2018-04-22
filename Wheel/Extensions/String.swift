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
    
    var toRecipyTitle: NSAttributedString {
        get {
            let text = NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Heavy", size: 16) as Any])
            return text
        }
    }
 
    var toRecipyHeader: NSAttributedString {
        get {
            let text = NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Black", size: 28) as Any])
            return text
        }
    }
    
    var toRecipySubheader: NSAttributedString {
        get {
            let text = NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.regentgrey, .font: UIFont(name: "Avenir-Book", size: 12) as Any])
            return text
        }
    }
    
    var toRecipyServingsCount: NSAttributedString {
        get {
            let text = NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.regentgrey, .font: UIFont(name: "Avenir-Heavy", size: 16) as Any])
            return text
        }
    }
    
    var toRecipyListQuantity: NSAttributedString {
        get {
            let text = NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.mineshaft, .font: UIFont(name: "Avenir-Light", size: 14) as Any])
            return text
        }
    }
    
    var toRecipyListName: NSAttributedString {
        get {
            let text = NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.mineshaft, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
            return text
        }
    }
    
    var toRecipyListKind: NSAttributedString {
        get {
            let text = NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.tiara, .font: UIFont(name: "Avenir-Roman", size: 12) as Any])
            return text
        }
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var toTipText: NSAttributedString {
        get {
            let text = NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Avenir-Book", size: 14) as Any])
            return text
        }
    }
}
