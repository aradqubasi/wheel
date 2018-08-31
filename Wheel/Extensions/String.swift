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
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.lineHeightMultiple = 1.25
        
        return NSAttributedString(string: self, attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Avenir-Medium", size: 24) as Any, .paragraphStyle: paragraphStyle])
    }

    static var tipForRollbutton: String {
        get {
            return "Quick start by pressing Roll button - App will get you recipy in no time"
        }
    }
    
    static var tipForSelectionWheel: String {
        get {
            return "You can check current selection here, rotate to see all what you picked"
        }
    }
    
    static var tipForCookbutton: String {
        get {
            return "Once right ingredients are in place proceed to recipy details"
        }
    }
    
    static var tipForFilterbutton: String {
        get {
            return "Customize your food preferences here"
        }
    }
    
    static var tipForWheel: String {
        get {
            return "You can hand-pick ingredients too! Rotate wheels to see what we have in list"
        }
    }
    
    static var tipForWheelpin: String {
        get {
            return "Click on icon or rotate it to focus position to select ingredient"
        }
    }
    
    static var tipForSelectedpin: String {
        get {
            return "Click on filled icon to remove ingredient from selection, click on empty spot to let App suggest you something"
        }
    }
    
    static var tipForEnhancerbutton: String {
        get {
            return "Variety of flavour enhancers are located here, click to see them"
        }
    }
    
    static var tipForIntroduction: String {
        get {
            return "This App will help you combine right ingredients to make a well-balanced salad"
        }
    }
    
    static var tipForOutro: String {
        get {
            return "Happy cooking!"
        }
    }
    
}
