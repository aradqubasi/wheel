//
//  SWAllergiesOptionView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWAllergiesOptionView: UIView {

    //MARK: - Private Properties
    
    var _title: UILabel!
    
    var _checkbox: UISwitch!
    
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
        get {
            return _checkbox.isOn
        }
        set (new) {
            _checkbox.setOn(new, animated: true)
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
        
        _checkbox = UISwitch()
        _checkbox.addTarget(self, action: #selector(onCheck(_:)), for: .valueChanged)
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
        checked = !checked
        if let target = _target as? NSObjectProtocol, let selector = _selector, target.responds(to: selector) {
            target.perform(selector, with: self)
        }
    }
    
    // MARK: - Public Methods
    
    func alignSubviews() {
        
        let expected: CGFloat = 83
        let leading: CGFloat = 16
        let switchSize: CGSize = CGSize(width: 56, height: 32)
        let trailing: CGFloat = 24
        let top: CGFloat = 24
        let border: CGFloat = 2.16
        
        _title.frame = CGRect(origin: CGPoint(x: leading, y: 0), size: CGSize(width: bounds.width - leading, height: expected))
        
        _checkbox.frame = CGRect(origin: CGPoint(x: bounds.width - switchSize.width - trailing, y: top), size: switchSize)
        _checkbox.onTintColor = .mountainmeadow
        
        _line.frame = CGRect(origin: CGPoint(x: 0, y: bounds.height - border), size: CGSize(width: bounds.width, height: border))
        _line.alpha = 0.34
        _line.backgroundColor = .tiara
        
    }
    
    func onCheck(_ target: Any?, selector: Selector) {
        _target = target
        _selector = selector
    }

}
