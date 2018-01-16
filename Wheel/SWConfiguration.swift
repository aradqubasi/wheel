//
//  SWConfiguration.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWConfiguration {
    
    /**SWPagerConfig Section*/
    struct Pager {
        /**initial pager state*/
        static let inital: SWPagerStates = .obey
        
        /**size of pager dotes*/
        static let diameter: CGFloat = 8
        
        /**diatnce setween dots*/
        static let spacing: CGFloat = 8
        
        /**dot color of active page*/
        static let active: UIColor = UIColor.white
        
        /**dot color of inactive page*/
        static let inactive: UIColor = UIColor.gray
        
        /**zero-based ordered state set*/
        static let states: [SWPagerStates:Int] = [.obey : 0, .greens : 1, .proteins : 2, .veggies : 3, .fats : 4, .ehancers : 5]
    }
    
    /**SWObeySlideView configuration*/
    struct ObeySlide {
        /**title rectangle*/
        static let size: CGSize = CGSize(width: 340, height: 141)
        
        /**attributed text for title*/
        static var text: NSAttributedString {
            get {
                let bold = UIFont(name: "Avenir-Heavy", size: 32)
                let usual = UIFont(name: "Avenir-Book", size: 32)
                
                
                let text = NSMutableAttributedString(string: "Build a Power Salad to\nkeep you full and\nEnergized ", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                text.addAttributes([.font: bold as Any], range: NSMakeRange(8, 11))
                
                return text
            }
        }
    }
}

