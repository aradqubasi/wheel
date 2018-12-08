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
            case .gray: inverted = .white
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
    
    func blackify() -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: self)
        if text.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor != nil {
            let linewise = NSRange(location: 0, length: text.length)
            text.removeAttribute(.foregroundColor, range: linewise)
            text.addAttribute(.foregroundColor, value: UIColor.black, range: linewise)
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
    
    class var historyTitle: NSAttributedString {
        get {
            let text = NSAttributedString(string: "History", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Heavy", size: 16) as Any])
            return text
        }
    }
    
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
        
    class var recipyListTitle: NSAttributedString {
        get {
            let text = NSAttributedString(string: "INGREDIENTS", attributes: [.foregroundColor: UIColor.regentgrey, .font: UIFont(name: "Avenir-Medium", size: 14) as Any])
            return text
        }
    }
    
    class var happyCooking: NSAttributedString {
        get {
            let text = NSAttributedString(string: "Happy Cooking", attributes: [.foregroundColor: UIColor.shamrock, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
            return text
        }
    }
    
    func height(in width: CGFloat) -> CGFloat {

        let storage = NSTextStorage(attributedString: self)
        let container = NSTextContainer(size: CGSize(width: width, height: CGFloat(MAXFLOAT)))
        let manager = NSLayoutManager()
        
        manager.addTextContainer(container)
        storage.addLayoutManager(manager)
        
        manager.glyphRange(for: container)
        
        var lines: Int = 0
        var index: Int = 0
        let glyphs: Int = manager.numberOfGlyphs
        
        var range: NSRange = NSRange()
        
        while (index < glyphs) {
            manager.lineFragmentUsedRect(forGlyphAt: index, effectiveRange: &range)
            index = NSMaxRange(range)
            lines = lines + 1
        }
        
//        let baseHeight = manager.usedRect(for: container).size.height
//
//        let height = CGFloat(lines) * baseHeight
//
//        return height
        return manager.usedRect(for: container).size.height.rounded(.up)
    }
    
    class var showSteps: NSAttributedString {
        get {
            let text = NSAttributedString(string: "SHOW STEPS", attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Avenir-Heavy", size: 12) as Any])
            return text
        }
    }
    
    class var emailPlaceholder: NSAttributedString {
        get {
            let text = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.geyser, .font: UIFont(name: "Avenir-Light", size: 24) as Any])
            return text
        }
    }
    
    class var isAnonymous: NSAttributedString {
        get {
            let text = NSAttributedString(string: "Stay anonymous", attributes: [.foregroundColor: UIColor.shuttlegray, .font: UIFont(name: "Avenir-Light", size: 16) as Any])
            return text
        }
    }
    
    class var stepsExplanation: NSAttributedString {
        get {
            let text = NSAttributedString(string: "This page is reserved for a step by step cooking recipy. Tell us if you think you would need it.", attributes: [.foregroundColor: UIColor.shuttlegray, .font: UIFont(name: "Avenir-Light", size: 24) as Any])
            return text
        }
    }
    
    class var iWantIt: NSAttributedString {
        get {
            let text = NSAttributedString(string: "I want it", attributes: [.foregroundColor: UIColor.shuttlegray, .font: UIFont(name: "Avenir-Medium", size: 18) as Any])
            return text
        }
    }

    func size(in width: CGFloat) -> CGSize {
        
        let storage = NSTextStorage(attributedString: self)
        let container = NSTextContainer(size: CGSize(width: width, height: CGFloat(MAXFLOAT)))
        let manager = NSLayoutManager()
        
        manager.addTextContainer(container)
        storage.addLayoutManager(manager)
        
        manager.glyphRange(for: container)
        
        var lines: Int = 0
        var index: Int = 0
        let glyphs: Int = manager.numberOfGlyphs
        
        var range: NSRange = NSRange()
        
        while (index < glyphs) {
            manager.lineFragmentUsedRect(forGlyphAt: index, effectiveRange: &range)
            index = NSMaxRange(range)
            lines = lines + 1
        }
        
        return manager.usedRect(for: container).size.raise()
    }
    
    class var tipForRollbutton: NSAttributedString {
        get {
            return "Quick start by pressing Roll button, App will come with recipy in no time".toWalkthroughFont
        }
    }
    
    class var tipForSelectionWheel: NSAttributedString {
        get {
            return "You can check current selection here, rotate to see all what you picked".toWalkthroughFont
        }
    }
    
    class var tipForCookbutton: NSAttributedString {
        get {
            return "Once right ingredients are in place proceed to recipy details".toWalkthroughFont
        }
    }
    
    class var tipForFilterbutton: NSAttributedString {
        get {
            return "Customize your food preferences here".toWalkthroughFont
        }
    }
    
    class var tipForWheel: NSAttributedString {
        get {
            return "You can hand-pick ingredients too! Rotate wheels to see what we have in list".toWalkthroughFont
        }
    }
    
    class var tipForWheelpin: NSAttributedString {
        get {
            return "Click on icon or rotate wheel to select ingredient".toWalkthroughFont
        }
    }
    
    class var tipForSelectedpin: NSAttributedString {
        get {
            return "Click to remove or add ingredient from selection".toWalkthroughFont
        }
    }
    
    class var tipForEnhancerbutton: NSAttributedString {
        get {
            return "Variety of flavour enhancers are located here, click to see them".toWalkthroughFont
        }
    }
    
    class var tipForIntroduction: NSAttributedString {
        get {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 0
            paragraphStyle.lineHeightMultiple = 1.25
            
            let bold = UIFont(name: "Avenir-Heavy", size: 24)
            
            let usual = UIFont(name: "Avenir-Book", size: 24)
            
            let text = NSMutableAttributedString(string: "This App could assist you with choosing right ingredients to cook Power Salad", attributes: [.foregroundColor: UIColor.white, .font: usual as Any, .paragraphStyle: paragraphStyle])
            text.addAttributes([.font: bold as Any], range: NSMakeRange(66, 11))
            return text
        }
    }
    
    class var tipForOutro: NSAttributedString {
        get {
            return "Happy cooking!".toWalkthroughFont
        }
    }
    
    class var hamburgerHistoryLabel: NSAttributedString {
        get {
            let color = UIColor.dovegray
            let font = UIFont(name: "Avenir-Roman", size: 17)!
            let text = "History"
            return NSMutableAttributedString(string: text, attributes: [.foregroundColor: color as Any, .font: font as Any])
        }
    }
    
    class var hamburgerDietLabel: NSAttributedString {
        get {
            let color = UIColor.dovegray
            let font = UIFont(name: "Avenir-Roman", size: 17)!
            let text = "Diet preferences"
            return NSMutableAttributedString(string: text, attributes: [.foregroundColor: color as Any, .font: font as Any])
        }
    }
    
    class var hamburgerWalkthroughLabel: NSAttributedString {
        get {
            let color = UIColor.dovegray
            let font = UIFont(name: "Avenir-Roman", size: 17)!
            let text = "Walkthrough"
            return NSMutableAttributedString(string: text, attributes: [.foregroundColor: color as Any, .font: font as Any])
        }
    }
    
    private func unfy() -> (font: Any?, text: String, color: Any?) {
        return (
            self.attribute(.font, at: 0, effectiveRange: nil),
            self.string,
            self.attribute(.foregroundColor, at: 0, effectiveRange: nil)
        )
    }
    
    private func fy(_ fyAttibutes: (font: Any?, text: String, color: Any?)) -> NSAttributedString {
        var attributes: [NSAttributedStringKey: Any] = [:]
        if fyAttibutes.font != nil {
            attributes[NSAttributedStringKey.font] = fyAttibutes.font
        }
        if fyAttibutes.color != nil {
            attributes[NSAttributedStringKey.foregroundColor] = fyAttibutes.color
        }
        return NSMutableAttributedString(string: fyAttibutes.text, attributes: attributes)
    }
    
    func whitify() -> NSAttributedString {
        let font = self.attribute(.font, at: 0, effectiveRange: nil)
        let text = self.string
        let color = UIColor.white
        return NSMutableAttributedString(string: text, attributes: [.foregroundColor: color as Any, .font: font as Any])
    }
    
    func dovegraytify() -> NSAttributedString {
        let font = self.attribute(.font, at: 0, effectiveRange: nil)
        let text = self.string
        let color = UIColor.dovegray
        return NSMutableAttributedString(string: text, attributes: [.foregroundColor: color as Any, .font: font as Any])
    }
    
    func avenirLightify(_ size: CGFloat) -> NSAttributedString {
        let unfy = self.unfy()
        let font = UIFont(name: "Avenir-Light", size: size)
        return fy((font: font, text: unfy.text, color: unfy.color))
    }
    
    class var dietTitle: NSAttributedString {
        get {
            let text = NSAttributedString(string: "Diet", attributes: [.foregroundColor: UIColor.oxfordblue, .font: UIFont(name: "Avenir-Heavy", size: 16) as Any])
            return text
        }
    }
    
    func avenirHeavfy(_ size: CGFloat) -> NSAttributedString {
        let unfy = self.unfy()
        let font = UIFont(name: "Avenir-Heavy", size: size)
        return fy((font: font, text: unfy.text, color: unfy.color))
    }
}
