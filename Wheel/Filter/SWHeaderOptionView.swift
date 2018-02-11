//
//  SWHeaderOptionView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWHeaderOptionView: UIView, SWAlignableProtocol {

    //MARK: - Private Properties
    
    var _title: UILabel!
    
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
    
    //MARK: - Initialization
    
    override init(frame rectangle: CGRect) {
        
        super.init(frame: rectangle)
        
        _title = UILabel()
        addSubview(_title)
        
        alignSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    // MARK: - Public Methods
    
    func alignSubviews() {
        
        let top: CGFloat = 24
        let expected: CGFloat = 19
        let leading: CGFloat = 16
        
        _title.frame = CGRect(origin: CGPoint(x: leading, y: top), size: CGSize(width: bounds.width - leading, height: expected))
        
    }

}
