//
//  SWRecipyListView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWRecipyListView: UIView {
    
    // MARK: - Private Properties
    
    private var _servings: Int = 0
    
    private var _generator: SWRecipyListGenerator!
    
    private var _quantityPreIngredient: [SWIngredient: UILabel]!
    
    // MARK: - Public Properties
    
    var servings: Int {
        get {
            return _servings
        }
        set(new) {
            _servings = new
            _quantityPreIngredient.forEach({
                $0.value.setRecipyListQuantity(_generator.getQuantity(for: $0.key, per: _servings))
                $0.value.addSizeConstraints()
                print("\($0.key.name) \($0.value.constraints.count)")
//                $0.value.ali
            })
        }
    }
    
    // MARK: - Initialization
    
    init(for ingredients: [SWIngredient], with generator: SWRecipyListGenerator) {
        _generator = generator
        _quantityPreIngredient = [:]
        super.init(frame: .zero)
        
        var height: CGFloat = 0
        var isFirst: Bool = true
        var last: UIView = UIView()
        do {
            for ingredient in ingredients {
                let quantity = UILabel.newRecipyListQuantity(_generator.getQuantity(for: ingredient, per: _servings))
                let name = UILabel.newRecipyListName(_generator.getName(for: ingredient))
                let kind = UILabel.newRecipyListKind(_generator.getKind(for: ingredient))
                
                [quantity, name, kind].forEach({
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    $0.addSizeConstraints()
                    self.addSubview($0)
                    $0.topAnchor.constraint(equalTo: isFirst ? self.topAnchor : last.bottomAnchor, constant: isFirst ? 0 : 8).isActive = true
                })
                
                quantity.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
                
                name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 72).isActive = true
                
                kind.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
                
                _quantityPreIngredient[ingredient] = quantity
                height += name.bounds.size.height + (isFirst ? 0 : 8)
                last = name
                isFirst = false
            }
        }
        
        self.frame.size = CGSize(width: 0, height: height)
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
