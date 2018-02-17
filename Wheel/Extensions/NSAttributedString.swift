//
//  NSAttributedString.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 27/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
extension NSAttributedString {
    
    // MARK: - Extension Methods
    
    func invert() -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: self)
        if let original = text.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor {
            var inverted: UIColor!
            switch original {
            case .white: inverted = .gray
            default: inverted = original
            }
            let linewise = NSRange(location: 0, length: text.length)
            text.removeAttribute(.foregroundColor, range: linewise)
            text.addAttribute(.foregroundColor, value: inverted, range: linewise)
            return text
        }
        else {
            return self
        }
    }
    
    // MARK: - Premadees
    
    class var obeyTitle: NSAttributedString {
        get {
            let bold = UIFont(name: "Avenir-Heavy", size: 32)
            
            let usual = UIFont(name: "Avenir-Book", size: 32)
            
            let text = NSMutableAttributedString(string: "Build a Power Salad to\nkeep you full and\nEnergized ", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            text.addAttributes([.font: bold as Any], range: NSMakeRange(8, 11))
            
            return text
        }
    }
    
    class var leafsTitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 28)
            let text = NSAttributedString(string: "Add Leafy Green", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var leafsSubtitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 16)
            let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var onboardingHeader: NSAttributedString {
        get {
            let bold = UIFont(name: "Avenir-Black", size: 32)
            
            let usual = UIFont(name: "Avenir-Book", size: 32)
            
            let text = NSMutableAttributedString(string: "saladwheel", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            text.addAttributes([.font: bold as Any], range: NSMakeRange(0, 5))
            
            return text
        }
    }
    
    class var proteinsTitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 28)
            let text = NSAttributedString(string: "Add Proteins", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var proteinsSubtitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 16)
            let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var veggiesTitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 28)
            let text = NSAttributedString(string: "Veggies (cooked or raw)", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var veggiesSubtitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 16)
            let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var fatsTitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 28)
            let text = NSAttributedString(string: "Add health fats", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var fatsSubtitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 16)
            let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var enhancersTitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 28)
            let text = NSAttributedString(string: "Flavor+Texture Enhancers", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var enhancersSubtitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 16)
            let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var proceedTitle: NSAttributedString {
        get {
            let usual = UIFont(name: "Avenir-Book", size: 36)
            let text = NSAttributedString(string: "Let’s build it!", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
            return text
        }
    }
    
    class var skip: NSAttributedString {
        get {
            let bold = UIFont(name: "Avenir-Heavy", size: 18)
            
            let text = NSMutableAttributedString(string: "SKIP", attributes: [.foregroundColor: UIColor.white, .font: bold as Any])
            
            return text
        }
    }
    
    class var proceed: NSAttributedString {
        get {
            let bold = UIFont(name: "Avenir-Heavy", size: 18)
            
            let text = NSMutableAttributedString(string: "PROCEED", attributes: [.foregroundColor: UIColor.white, .font: bold as Any])
            
            return text
        }
    }
    
    class var wheelsTitle: NSAttributedString {
        get {
            let bold = UIFont(name: "Avenir-Heavy", size: 24)
            
            let usual = UIFont(name: "Avenir-Light", size: 24)
            
            let text = NSMutableAttributedString(string: "Saladwheel", attributes: [.foregroundColor: UIColor.limedSpruce, .font: usual as Any])
            text.addAttributes([.font: bold as Any], range: NSMakeRange(0, 5))
            
            return text
        }
    }
    
    class var ingredientsHeader: NSAttributedString {
        get {
            let text = NSAttributedString(string: "INGREDIENTS", attributes: [.foregroundColor: UIColor.regentgrey, .font: UIFont(name: "Avenir-Medium", size: 14) as Any])
            return text
        }
    }
    
//    class var veganOption: NSAttributedString {
//        get {
//            let text = NSAttributedString(string: "Vegan", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
//            return text
//        }
//    }
//
//    class var vegeterianOption: NSAttributedString {
//        get {
//            let text = NSAttributedString(string: "Vegeterian", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
//            return text
//        }
//    }
//
//    class var percetarianOption: NSAttributedString {
//        get {
//            let text = NSAttributedString(string: "Percetarian", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
//            return text
//        }
//    }
    
    class var noFoodPreferencesOption: NSAttributedString {
        get {
            let text = NSAttributedString(string: "No food preferences", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
            return text
        }
    }
    
    class var allergiesHeader: NSAttributedString {
        get {
            let text = NSAttributedString(string: "ALLERGIES", attributes: [.foregroundColor: UIColor.regentgrey, .font: UIFont(name: "Avenir-Medium", size: 14) as Any])
            return text
        }
    }
    
    class var noAllergiesOption: NSAttributedString {
        get {
            let text = NSAttributedString(string: "No allergies", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
            return text
        }
    }
    
//    class var glutenIntolerantOption: NSAttributedString {
//        get {
//            let text = NSAttributedString(string: "Gluten intolerant", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
//            return text
//        }
//    }
//    
//    class var wheatIntolerantOption: NSAttributedString {
//        get {
//            let text = NSAttributedString(string: "Wheat intolerant", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
//            return text
//        }
//    }
//    
//    class var lactoseIntolerantOption: NSAttributedString {
//        get {
//            let text = NSAttributedString(string: "Lactose intolerant", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
//            return text
//        }
//    }
    
    class var filterTitle: NSAttributedString {
        get {
            let text = NSAttributedString(string: "Food preferences", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Heavy", size: 16) as Any])
            return text
        }
    }
    
    class var ok: NSAttributedString {
        get {
            let text = NSAttributedString(string: "OK", attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Avenir-Medium", size: 18) as Any])
            return text
        }
    }
    
//    class var grayok: NSAttributedString {
//        get {
//            let text = NSAttributedString(string: "OK", attributes: [.foregroundColor: UIColor.gray, .font: UIFont(name: "Avenir-Medium", size: 18) as Any])
//            return text
//        }
//    }
}
