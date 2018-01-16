//
//  SWSlideView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 15/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWSliderView: UIView {
    
    // MARK: - Outlets
    
    var _title: UILabel!
    
    var _subtitle: UILabel!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _title = UILabel()
        _title.numberOfLines = 0
        _subtitle = UILabel()
        _subtitle.numberOfLines = 0
        self.addSubview(_title)
        self.addSubview(_subtitle)
        alignSubviews(_title, _subtitle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func alignSubviews(_ title: UILabel, _ subtitle: UILabel) {

    }
    
}
