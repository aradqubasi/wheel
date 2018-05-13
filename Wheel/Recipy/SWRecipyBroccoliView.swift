//
//  SWRecipyBroccoliView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/03/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWRecipyBroccoliView: UIView {
    
    // MARK: - Private Properties
    
    private var _image: UIImageView!
    
    private var _showed: CGFloat = 0
    
    private var _shroud: UIView!
    
    // MARK: - Public Properties
    
    /**animatable - partion of happy broccoli visible in frame - [0;1]*/
    var showed: CGFloat {
        get {
            return _showed
        }
        set(new) {
            _showed = max(0, min(1, new))
            _image.frame.origin = CGPoint(x: 0, y: bounds.height * (1 - _showed))
            _shroud.alpha = 1 - _showed
        }
    }

    // MARK: - Initialization
    
    init() {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 83, height: 64)))
//        clipsToBounds = true
        
        _image = UIImageView(image: .happy_broccoli)
        addSubview(_image)
        
        _shroud = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 64), size: CGSize(width: 83, height: 100)))
        _shroud.backgroundColor = .white
        _shroud.alpha = 1
        addSubview(_shroud)
        
        showed = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
