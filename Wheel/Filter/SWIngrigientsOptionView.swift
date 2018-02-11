//
//  IngrigientsOptionView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWIngrigientsOptionView: UIView, SWAlignableProtocol {
    
    //MARK: - Private Properties
    
    var _title: UILabel!
    
    var _checkbox: UIButton!
    
    var _target: Any?
    
    var _selector: Selector?
    
    var _line: UIView!
    
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
    
    override init(frame rectangle: CGRect) {
        
        super.init(frame: rectangle)
        
        _title = UILabel()
        addSubview(_title)
        
        _checkbox = UIButton()
        _checkbox.addTarget(self, action: #selector(onCheck(_:)), for: .touchUpInside)
        addSubview(_checkbox)
        
        _line = UIView()
        addSubview(_line)
        
        alignSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    @IBAction private func onCheck(_ sender: UIButton) {
        if let target = _target as? NSObjectProtocol, let selector = _selector, target.responds(to: selector) {
            target.perform(selector, with: self)
        }
    }
    
    // MARK: - Public Methods
    
    func alignSubviews() {
        
        let expected: CGFloat = 83
        let leading: CGFloat = 16
        let radius: CGFloat = 16
        let trailing: CGFloat = 24
        let border: CGFloat = 2.16

        _title.frame = CGRect(origin: CGPoint(x: leading, y: 0), size: CGSize(width: bounds.width - leading, height: expected))
        
        _checkbox.frame = CGRect(origin: CGPoint(x: bounds.width - radius * 2 - trailing, y: trailing), size: CGSize(side: radius * 2))
        _checkbox.layer.cornerRadius = radius
        _checkbox.layer.borderWidth = 1
        _checkbox.layer.borderColor = UIColor.tiara.cgColor
        _checkbox.setImage(.isCheckedMark, for: .normal)
        
        _line.frame = CGRect(origin: CGPoint(x: 0, y: bounds.height - border), size: CGSize(width: bounds.width, height: border))
        _line.backgroundColor = .tiara
        
    }
    
    func onCheck(_ target: Any?, selector: Selector) {
        _target = target
        _selector = selector
    }
    
}
