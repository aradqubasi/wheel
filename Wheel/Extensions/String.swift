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
    
    var toWhiteAvenir14: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Avenir-Medium", size: 14) as Any])
    }
    
    var toWalkthroughFont: NSAttributedString {
        return NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Avenir-Medium", size: 21) as Any])
    }
    
    static var introduction: String {
        get {
            return "Please spent few moments getting familiar with interface features"
        }
    }

    static var tipForRollbutton: String {
        get {
            return "Press this button to generate salad!"
        }
    }
    
    static var tipForSelectionWheel: String {
        get {
            return "This is plate with ingredients, pan left/right to rotate it"
        }
    }
    
    static var tipForCookbutton: String {
        get {
            return "Once all ingredeitns in place, tap to navigate to recipy"
        }
    }
    
    static var tipForFilterbutton: String {
        get {
            return "Customize your food preferences here"
        }
    }
    
     static var tipForWheelpin: String {
        get {
            return "Click to select ingredient, pan to rotate wheel"
        }
    }
    
     static var tipForEnhancerbutton: String {
        get {
            return "Variety of flavour enhancers are located here, click to see them"
        }
    }
}
