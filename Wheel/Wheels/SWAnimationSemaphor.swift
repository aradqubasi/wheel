//
//  SWAnimationSemaphor.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation

protocol SWAnimationSemaphor {
    
    func couldAnimate(sender: Any) -> Bool
    
    func onAnimationStart(sender: Any)
    
    func onAnimationEnd(sender: Any)
    
}
