//
//  SWConcreteFilterAligner.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 30/09/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWConcreteFilterAligner: SWFilterAligner {
    
    func alignAtBottom(button: UIButton, in bounds: CGRect) -> Void {
        button.frame.size.width = bounds.width
        button.frame.origin = CGPoint(x: 0, y: bounds.height - button.frame.height)
    }
    
    func alignAtScreen(scroll: UIScrollView, in view: UIView) -> Void {
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64).isActive = true
        scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
}

