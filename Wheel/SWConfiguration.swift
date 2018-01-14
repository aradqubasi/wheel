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
    
    // MARK: - SWPagerConfig Section
    
    struct Pager {
        /**initial pager state*/
        let inital: SWPagerStates = .obey
        
        /**size of pager dotes*/
        let radius: CGFloat = 8
        
        /**diatnce setween dots*/
        let spacing: CGFloat = 8
        
        /**dot color of active page*/
        let active: UIColor = UIColor.white
        
        /**dot color of inactive page*/
        let inactive: UIColor = UIColor.gray
        
        /**zero-based ordered state set*/
        let states: [SWPagerStates:Int] = [.obey : 0, .greens : 1, .proteins : 2, .veggies : 3, .fats : 4, .ehancers : 5]
    }

    /**pager configuration*/
    class var pager: SWConfiguration.Pager {
        get {
            return SWConfiguration.Pager()
        }
    }
}

