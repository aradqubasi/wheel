//
//  SWXPhoneFilterAligner.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 30/09/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWXPhoneFilterAligner: SWFilterAligner {
    
    func alignAtBottom(button: UIButton, in bounds: CGRect) -> Void {
        button.frame.size.width = -12 + bounds.width + -12
        button.frame.origin = CGPoint(x: 12, y: bounds.height - button.frame.height - 24)
        button.layer.cornerRadius = 12
    }
    
    func alignAtScreen(scroll: UIScrollView, in view: UIView) -> Void {
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24 + -64).isActive = true
        scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
}
