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
    
    // MARK: - SWPagerConfig
    
    struct Pager {
        /**initial pager state*/
        static let inital: SWPagerStates = .obey
        
        /**size of pager dotes*/
        static let diameter: CGFloat = 8
        
        /**diatnce setween dots*/
        static let spacing: CGFloat = 8
        
        /**dot color of active page*/
        static let color: UIColor = UIColor.white
        
        /**dot color of active page*/
        static let active = UIColor.white.withAlphaComponent(1)
        
        /**dot color of inactive page*/
        static let inactive = UIColor.white.withAlphaComponent(0.4)
        
        /**zero-based ordered state set*/
        static let states: [SWPagerStates:Int] = [.obey : 0, .leafs : 1, .proteins : 2, .veggies : 3, .fats : 4, .ehancers : 5]
    }
    
    // MARK: - SWObeySlideView
    
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
    
    // MARK: - SWLeafsSlideView
    
    struct LeafsSlide {
        
        /**Title label settings*/
        struct Title {
            
            /**attributed string with title text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 28)
                    let text = NSAttributedString(string: "Add Leafy Green", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of title's frame*/
            static let size: CGSize = CGSize(width: 320, height: 32)
            
            /**offset of center of title frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 56)
            
        }
        
        /**Subtitle label settings*/
        struct Subtitle {
            
            /**attributed string with subtitle text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 16)
                    let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of subtitle's frame*/
            static let size: CGSize = CGSize(width: 320, height: 32)
            
            /**offset of center of subtitle frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 88)
            
        }
    }
    
    // MARK: - SWProteinsSlideView
    
    struct ProteinsSlide {
        
        /**Title label settings*/
        struct Title {
            
            /**attributed string with title text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 28)
                    let text = NSAttributedString(string: "Add Proteins", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of title's frame*/
            static let size: CGSize = CGSize(width: 320, height: 32)
            
            /**offset of center of title frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 56)
            
        }
        
        /**Subtitle label settings*/
        struct Subtitle {
            
            /**attributed string with subtitle text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 16)
                    let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of subtitle's frame*/
            static let size: CGSize = CGSize(width: 320, height: 32)
            
            /**offset of center of subtitle frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 88)
            
        }
        
    }
    
    // MARK: - SWVeggiesSlideView
    
    struct VeggiesSlide {
        
        /**Title label settings*/
        struct Title {
            
            /**attributed string with title text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 28)
                    let text = NSAttributedString(string: "Veggies (cooked or raw)", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of title's frame*/
            static let size: CGSize = CGSize(width: 320, height: 32)
            
            /**offset of center of title frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 56)
            
        }
        
        /**Subtitle label settings*/
        struct Subtitle {
            
            /**attributed string with subtitle text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 16)
                    let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of subtitle's frame*/
            static let size: CGSize = CGSize(width: 320, height: 32)
            
            /**offset of center of subtitle frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 88)
            
        }
        
    }
    
    // MARK: - SWFatsSlideView
    
    struct FatsSlide {
        
        /**Title label settings*/
        struct Title {
            
            /**attributed string with title text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 28)
                    let text = NSAttributedString(string: "Add health fats", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of title's frame*/
            static let size: CGSize = CGSize(width: 320, height: 32)
            
            /**offset of center of title frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 56)
            
        }
        
        /**Subtitle label settings*/
        struct Subtitle {
            
            /**attributed string with subtitle text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 16)
                    let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of subtitle's frame*/
            static let size: CGSize = CGSize(width: 320, height: 32)
            
            /**offset of center of subtitle frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 88)
            
        }
        
    }
    
    // MARK: - SWEnhancersSlideView
    
    struct EnhancersSlide {
        
        /**Title label settings*/
        struct Title {
            
            /**attributed string with title text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 28)
                    let text = NSAttributedString(string: "Flavor+Texture Enhancers", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of title's frame*/
            static let size: CGSize = CGSize(width: 327, height: 32)
            
            /**offset of center of title frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 56)
            
        }
        
        /**Subtitle label settings*/
        struct Subtitle {
            
            /**attributed string with subtitle text*/
            static var text: NSAttributedString {
                get {
                    let usual = UIFont(name: "Avenir-Book", size: 16)
                    let text = NSAttributedString(string: "Choose one", attributes: [.foregroundColor: UIColor.white, .font: usual as Any])
                    return text
                }
            }
            
            /**size of subtitle's frame*/
            static let size: CGSize = CGSize(width: 320, height: 32)
            
            /**offset of center of subtitle frame to its superview*/
            static let offset: CGPoint = CGPoint(x: 0, y: 88)
            
        }
        
    }
}

