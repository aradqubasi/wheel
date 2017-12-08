//
//  StaticSelectedView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 07/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class StaticSelectedView: UIView {
    
    // MARK: - Properties
    
    var state: StaticSelectedViewStates {
        get {
            return _state
        }
    }
    
    var food: Ingridient? {
        get {
            return _food
        }
    }
    
    // MARK: - Private Properties
    
    private var _food: Ingridient?
    
    private var _state: StaticSelectedViewStates!
    
    // MARK: - Subviews
    
//    private var _size: CGSize!
    
    private var _item: UIButton!
    
    private var _shroud: UIView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _item = UIButton(frame: self.bounds)
        self.addSubview(_item)
        
        _shroud = UIView(frame: self.bounds)
        _shroud.backgroundColor = UIColor.white
        self.addSubview(_shroud)
        
        close()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    /**animatable - hide picture and move to head*/
    func close() {
        _state = .closed
        _food = nil
        
        _item.isUserInteractionEnabled = false
        
        _shroud.alpha = 1
    }

    /**animatable - open blank spot at the point @ holder coordinate system*/
    func open(to point: CGPoint) {
        _state = .opened
        _food = nil
        
        frame.origin = point
        
        _item.setImage(nil, for: .normal)
        _item.isUserInteractionEnabled = false
        
        _shroud.alpha = 1
    }

    /**instant - fill spot with image*/
    func fill(with food: Ingridient) {
        _state = .full
        _food = food
        
        _item.setImage(food.image, for: .normal)
        _item.isUserInteractionEnabled = true
        
        _shroud.alpha = 0
    }
    
}
