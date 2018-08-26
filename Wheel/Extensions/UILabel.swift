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
    
    class var leafsSubtitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.leafsSubtitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var onboardingHeader: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 193, height: 49)
            label.attributedText = NSAttributedString.onboardingHeader
            label.textAlignment = .center
            return label
        }
    }
    
    class var proteinsTitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.proteinsTitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var proteinsSubtitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.proteinsSubtitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var veggiesTitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.veggiesTitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var veggiesSubtitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.veggiesSubtitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var fatsTitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.fatsTitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var fatsSubtitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.fatsSubtitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var enhancersTitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.enhancersTitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var enhacersSubtitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.enhancersSubtitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var proceedTitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 327, height: 31)
            label.attributedText = NSAttributedString.proceedTitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var wheelTitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 127, height: 33)
            label.attributedText = NSAttributedString.wheelsTitle
            label.textAlignment = .center
            return label
        }
    }
    
    class var filterTitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 133, height: 32)
            label.attributedText = NSAttributedString.filterTitle
            label.textAlignment = .center
            return label
        }
    }
    
    static func getRecipyTitle(_ name: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.frame.size = CGSize(width: 300, height: 32)
        label.attributedText = name.toRecipyTitle
        label.textAlignment = .center
        return label
    }
    
    static func getRecipyHeader(_ name: String, width estimated: CGFloat) -> UILabel {
        let text = name.toRecipyHeader
        let label = UILabel()
        label.numberOfLines = 0
        label.attributedText = text
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        
        label.frame.size = text.boundingRect(with: CGSize(width: estimated, height: CGFloat(MAXFLOAT)), options: [.usesFontLeading, .usesLineFragmentOrigin], context: nil).size.raise()

        return label
    }
    
    func setRecipySubheader(_ name: String) {
        self.numberOfLines = 0
        self.attributedText = name.toRecipySubheader
        self.frame.size = name.toRecipySubheader.size().wider(by: 1)
        self.textAlignment = .center
    }
    
    class var recipyListTitle: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 271, height: 19)
            label.attributedText = NSAttributedString.recipyListTitle
            label.textAlignment = .left
            return label
        }
    }
    
    static func newRecipyListQuantity(_ text: String) -> UILabel {
        let label = UILabel()
        let text = text.toRecipyListQuantity
        label.attributedText = text
        label.frame.size = text.size().wider(by: 2)
        label.textAlignment = .left
        return label
    }
    
    func setRecipyListQuantity(_ text: String) {
        let text = text.toRecipyListQuantity
        attributedText = text
        frame.size = text.size().wider(by: 2)
        textAlignment = .left
    }
    
    static func newRecipyListName(_ text: String) -> UILabel {
        let label = UILabel()
        let text = text.toRecipyListName
        label.attributedText = text
        label.frame.size = text.size().wider(by: 2)
        label.textAlignment = .left
        return label
    }
    
    static func newRecipyListKind(_ text: String) -> UILabel {
        let label = UILabel()
        let text = text.toRecipyListKind
        label.attributedText = text
        label.frame.size = text.size().wider(by: 2)
        label.textAlignment = .right
        return label
    }
    
    class var happyCooking: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 112, height: 22)
            label.attributedText = NSAttributedString.happyCooking
            label.textAlignment = .center
            return label
        }
    }
    
    class var isAnonymousLabel: UILabel {
        get {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame.size = CGSize(width: 300, height: 22)
            label.attributedText = .isAnonymous
            label.textAlignment = .left
            return label
        }
    }
    
    static func stepsExplanation(estimated width: CGFloat) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        let text = NSAttributedString.stepsExplanation
        label.frame.size = CGSize(width: width, height: text.height(in: width))
        label.attributedText = text
        label.textAlignment = .left
        return label
    }
    
    class var selectionWheelLabel: UILabel {
        get {
            let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 600, height: 14)))
            label.font = UIFont(name: "Avenir-Medium", size: 10)
            label.textColor = UIColor.shuttlegray
            label.textAlignment = .center
            return label
        }
    }
    
    func asWalkthrough(text: String, width: CGFloat) -> Void {
        let label = self
        label.numberOfLines = 0
        let attributed = text.toWalkthroughFont
        label.frame.size = CGSize(width: width, height: attributed.height(in: width))
        label.attributedText = attributed
        label.textAlignment = .center
    }
}
