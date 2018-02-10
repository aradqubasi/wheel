//
//  IngrigientsOptionView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class IngrigientsOptionView: UIView {
    
    //MARK: - Private Properties
    
    var _title: UILabel!
    
    var _checkbox: UIButton!
    
    //MARK: - Public Properties

    /**instant*/
    var title: NSAttributedString? {
        get {
            return _title.attributedText
        }
        set(new) {
            _title.attributedText = new
        }
    }
    
    /**animatable*/
    var checked: Bool {
        get {
            return _checkbox.backgroundColor == .mountainmeadow
        }
        set (new) {
            _checkbox.backgroundColor = new ? .mountainmeadow : .white
        }
    }
    
    //MARK: - Initialization
    
    init(width parent: CGFloat) {
        let expected: CGFloat = 83
        let offset: CGFloat = 16
        let frame = CGRect(origin: .zero, size: CGSize(width: parent, height: expected))
        super.init(frame: frame)
        
        _title = UILabel(frame: CGRect(origin: CGPoint(x: offset, y: 0), size: CGSize(width: parent - offset, height: expected)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
