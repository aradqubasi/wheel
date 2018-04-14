//
//  SWValidatedInput.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWValidationLine: UIView {
    
    private var front: UIView!
    
    private var new: UIView!
    
    private let colors: [SWValidatedInputStates:UIColor] = [
        .invalid : .salmon,
        .valid : .shamrock,
        .inactive : .tiara
    ]
    
    // MARK: - Initialization
    
    init(width: CGFloat) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: width, height: 1)))
        
        front = UIView()
        self.addSubview(front)
        
        new = UIView()
        self.addSubview(new)
        
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Animation
    
    func prepare(_ state: SWValidatedInputStates) {
        
        new.frame = bounds
        new.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 1)
        new.backgroundColor =  colors[state]
        new.alpha = 1
        
        front.frame = CGRect(origin: CGPoint(x: -bounds.width * 0.1, y: 0), size: CGSize(width: bounds.width * 1.2, height: 1))
        front.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 1)
        front.backgroundColor = colors[state]
        front.alpha = 0.5
        
    }
    
    func transition(to state: SWValidatedInputStates) {
        new.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        front.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
    }
    
    func finalize(_ state: SWValidatedInputStates) {
        new.alpha = 0
        front.alpha = 0
        backgroundColor = colors[state]
    }
    
}
