//
//  SWRecipyServingsCounter.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 06/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWRecipyServingsCounter: UILabel {
    
    // MARK: - Public Properties
    
    var servings: Int {
        get {
            return _count
        }
        set(new) {
            _count = new
            attributedText = _generator.getCaption(for: _count).toRecipyServingsCount
        }
    }
    
    // MARK: - Private Properties
    
    private var _count: Int = 2
    
    private var _generator: SWServingsGenerator!
    
    // MARK: - Initializers

    init(frame rectangle: CGRect, helper generator: SWServingsGenerator) {
        super.init(frame: rectangle)
        _generator = generator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    static func usual(with generator: SWServingsGenerator) -> SWRecipyServingsCounter {
        return SWRecipyServingsCounter(frame: CGRect(origin: .zero, size: CGSize(width: 136, height: 18)), helper: generator)
    }
}
