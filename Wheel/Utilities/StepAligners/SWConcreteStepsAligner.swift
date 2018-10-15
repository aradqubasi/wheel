//
//  SWConcreteStepsAligner.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWConcreteStepsAligner: SWStepsAligner {
    
    func alignAtBottom(button: UIButton, in container: UIView) -> Void {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: button.frame.height).isActive = true
        button.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
    }
    
}
