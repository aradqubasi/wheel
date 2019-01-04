//
//  SWDietOption.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/12/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWDietOption {
    
    let guiname: String
    
    private let active: UIImage
    
    private let inactive: UIImage
    
    private let color: UIColor
    
    private let background: UIColor
    
    private var userOption: SWUserOption
    
    private let button: UIButton
    
    private let label: UILabel
    
    var UserOption: SWUserOption {
        get {
            return self.userOption
        }
    }
    
    init(name: String, active: UIImage, inactive: UIImage, color: UIColor, background: UIColor, userOption: SWUserOption) {
        self.guiname = name
        self.active = active
        self.inactive = inactive
        self.color = color
        self.background = background
        self.userOption = userOption
        
        self.button = UIButton()
        self.button.frame.size = CGSize(side: 50)
        self.button.layer.cornerRadius = 25
        
        self.label = UILabel()
        let text = NSAttributedString(string: self.guiname).avenirLightify(12).whitify()
        self.label.frame.size = text.size()
        self.label.attributedText = text
        
        self.button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        self.display()
    }
    
    func setCenter(to point: CGPoint, at view: UIView) {
        view.addSubview(self.button)
        self.button.center = point
        
        view.addSubview(self.label)
        self.label.center = point + CGPoint(x: 0, y: self.button.frame.height * 0.5 + self.label.frame.height * 0.5)
    }
    
    @IBAction private func onClick() {
        self.userOption.checked = !self.userOption.checked
        display()
    }
    
    private func display() {
        if self.userOption.checked {
            self.button.backgroundColor = self.color
            self.button.setImage(self.active, for: .normal)
        }
        else {
            self.button.backgroundColor = self.background
            self.button.setImage(self.inactive, for: .normal)
        }
    }
    
}

