//
//  SWRecipyIngridientView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWRecipyIngridientView: UIView {
    
    // MARK: - Private Propertues
    
    private var ingredient: SWIngredient!
    
    private var image: UIImageView!

    // MARK: - Initialization
    
    init(frame rectangle: CGRect, for model: SWIngredient) {
        super.init(frame: rectangle)
        ingredient = model
        image = UIImageView()
        self.addSubview(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func alignSubviews() {
        image.frame = self.bounds.shrinkify(by: 16)
        image.image = ingredient.image
        image.layer.cornerRadius = 4
        layer.cornerRadius = 4
        backgroundColor = .white
        layer.shadowColor = UIColor.aztec.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4).cgPath
    }
    
}
