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
}
