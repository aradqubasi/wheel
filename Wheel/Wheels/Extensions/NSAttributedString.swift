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
}
