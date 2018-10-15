//
//  SWFilterAligner.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 30/09/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWFilterAligner {
    
    func alignAtBottom(button: UIButton, in bounds: CGRect) -> Void
    
    func alignAtScreen(scroll: UIScrollView, in view: UIView) -> Void
    
}
