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
    
    /**isOn = _checkfront.scale == 0*/
    var _checkbox: UIButton!
    
    /**colored circle for checkbox animation*/
    var _checkback: UIView!
    
    /**white circle with viariable scale for checkbox animation*/
    var _checkfront: UIView!
    
    var _target: Any?
    
    var _selector: Selector?
    
    var _line: UIView!
    
    var _order: Int?
    
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
//        get {
//            return _checkbox.backgroundColor == .mountainmeadow
//        }
//        set (new) {
//            _checkbox.backgroundColor = new ? .mountainmeadow : .white
//        }
        get {
            return _checkfront.scale != 1
        }
        set (new) {
            _checkfront.transform = CGAffineTransform.identity.scaledBy(x: new ? 0.1 : 1, y: new ? 0.1 : 1)
            _checkfront.alpha = new ? 0 : 1
        }
    }
    
    var order: Int {
        get {
            if _order == nil {
                _order = 0
                return 0
            }
            else {
                return _order!
            }
        }
        set(new) {
            _order = new
        }
    }
    
    //MARK: - Initialization
    
    override init(frame rectangle: CGRect) {
        
        super.init(frame: rectangle)
        
        _title = UILabel()
        addSubview(_title)
        
        _checkback = UIView()
        addSubview(_checkback)
        
        _checkfront = UIView()
        addSubview(_checkfront)
        
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
        
        let circle = CGRect(origin: CGPoint(x: bounds.width - radius * 2 - trailing, y: trailing), size: CGSize(side: radius * 2))
        
        _checkback.frame = circle
        _checkback.layer.cornerRadius = radius
        _checkback.backgroundColor = .mountainmeadow
        
        _checkfront.frame = circle
        _checkfront.layer.cornerRadius = radius
        _checkfront.backgroundColor = .white
        _checkfront.transform = CGAffineTransform.identity
        
        _checkbox.frame = CGRect(origin: CGPoint(x: bounds.width - radius * 2 - trailing, y: trailing), size: CGSize(side: radius * 2))
        _checkbox.layer.cornerRadius = radius
        _checkbox.layer.borderWidth = 1
        _checkbox.layer.borderColor = UIColor.tiara.cgColor
        _checkbox.setImage(.isCheckedMark, for: .normal)
        
//        _checkbox.frame = CGRect(origin: CGPoint(x: bounds.width - radius * 2 - trailing, y: trailing), size: CGSize(side: radius * 2))
//        _checkbox.layer.cornerRadius = radius
//        _checkbox.layer.borderWidth = 1
//        _checkbox.layer.borderColor = UIColor.tiara.cgColor
//        _checkbox.setImage(.isCheckedMark, for: .normal)
        
        _line.frame = CGRect(origin: CGPoint(x: 0, y: bounds.height - border), size: CGSize(width: bounds.width, height: border))
        _line.alpha = 0.34
        _line.backgroundColor = .tiara
        
    }
    
    func onCheck(_ target: Any?, selector: Selector) {
        _target = target
        _selector = selector
    }
    
}
