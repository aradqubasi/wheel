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
    
    private var option: SWOption
    
    private let options: SWOptionRepository
    
    private let button: UIButton
    
    init(name: String, active: UIImage, inactive: UIImage, color: UIColor, background: UIColor, option: SWOption, options: SWOptionRepository) {
        self.guiname = name
        self.active = active
        self.inactive = inactive
        self.color = color
        self.background = background
        self.option = option
        self.options = options
        self.button = UIButton()
        self.button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.button.frame.size = CGSize(side: 70)
        self.button.layer.cornerRadius = 14
        self.button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        self.display()
    }
    
    func setCenter(to point: CGPoint, at view: UIView) {
        view.addSubview(self.button)
        self.button.center = point
    }
    
    func save() {
        self.options.save(self.option)
    }
    
    @IBAction private func onClick() {
        self.option.checked = !self.option.checked
        display()
    }
    
    private func display() {
        if self.option.checked {
            self.button.backgroundColor = self.color
            self.button.setImage(self.active, for: .normal)
        }
        else {
            self.button.backgroundColor = self.background
            self.button.setImage(self.inactive, for: .normal)
        }
    }
    
}

