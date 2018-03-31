//
//  SWOverlayController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWOverlayController {

    var aligner: SWWheelsAligner { get set }
    
    var opened: Bool { get }
    
    var focused: NamedPinView? { get }
    
    var delegate: OverlayControllerDelegate? { get set }
    
    var view: UIView? { get set }
    
    func random()
    
    func unfocus()
    
    func flushIngredients(with updated: [SWIngredient])

    /**instant - move subs into position, alignment based on open overlay button */
    func set(for button: UIButton)
    
    /**animatable - open subs*/
    func open()
    
    /**animatable - close subs*/
    func close()
    
    /**instant - remove subs from screen*/
    func discharge()
    
    func focus(on ingredient: SWIngredient)
    
}
