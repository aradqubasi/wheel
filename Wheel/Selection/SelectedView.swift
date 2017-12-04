//
//  SelectedView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 02/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SelectedView: UIView {
    
    // MARK: - Public Properties
    
    var food: Ingridient? {
        get {
            return _food
        }
        set (new) {
            _food = new
        }
    }
    
    // MARK: - Private Properties
    
    private var _food: Ingridient?
    
    private var _initial: CGPoint!

    // MARK: - Subviews
    
    private var item: UIButton!
    
    private var shroud: UIView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initial = CGPoint(x: 8, y: 16)
        
        item = UIButton(frame: self.bounds)
        item.addTarget(self, action: #selector(onItemClick(sender:)), for: .touchUpInside)
        self.addSubview(item)
        
        shroud = UIView(frame: self.bounds)
        shroud.backgroundColor = UIColor.white
        shroud.alpha = 1
        self.addSubview(shroud)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    
    
    // MARK: - Actions
    
    @objc private func onItemClick(sender: UIButton) {
        print("SelectedView.onItemClick")
    }
    
    // MARK: - Public Properties
    
    func show(_ food: Ingridient, at point: CGPoint) {
        _food = food
        item.setImage(food.image, for: .normal)
        self.frame.origin = point
        shroud.alpha = 0
    }
    
    func hide() {
        shroud.alpha = 1
        _food = nil
        self.frame.origin = _initial
    }
    
}
