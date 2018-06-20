//
//  NamedPinView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class NamedPinView: UIView, Floatable {
    
    // MARK: - Public Properties
    
    var name: String {
        get {
            return _label.attributedText?.string ?? ""
        }
        set(new) {
            let text = NSAttributedString(string: new, attributes: [.foregroundColor: UIColor.white, .font: UIFont(name: "Avenir-Medium", size: 12) as Any])
            _label.attributedText = text
            _label.frame.size.height = text.size(in: _label.frame.width).raise().height
        }
    }
    
    var image: UIImage? {
        get {
            return _button.image(for: .normal)
        }
        set(new) {
            _button.setImage(new, for: .normal)
        }
    }
    
    var state: NamedPinState {
        get {
            return _state
        }
        set (new) {
            _state = new
            switch _state {
            case .regular:
                _button.layer.borderWidth = 0
            case .highlight:
                _button.layer.borderWidth = 2
            default:
                fatalError("\(new) state in NamedPinState is unhandled")
            }
            
        }
    }
    
    // MARK: - Private Properties
    
    var _target: Any?

    var _selector: Selector?
    
    var _state: NamedPinState!
    
    var _ingredient: SWIngredient!

    
    // MARK: - Subviews
    
    private let _button = UIButton()
    
    private let _label = UILabel()

    // MARK: - Initialization
    
    convenience init(for ingredient: SWIngredient) {
        self.init()
        _ingredient = ingredient
        self.name = _ingredient.name.uppercased()
        self.image = _ingredient.image
    }
    
    init() {
        let frame = CGRect(origin: .zero, size: CGSize(side: 72))
        super.init(frame: frame)
        
        _button.frame = self.bounds
        _button.imageEdgeInsets.left = 5
        _button.imageEdgeInsets.right = 5
        _button.imageEdgeInsets.top = 5
        _button.imageEdgeInsets.bottom = 5
        _button.layer.cornerRadius = 36
        _button.backgroundColor = UIColor.white
        _button.layer.borderColor = UIColor.shamrock.cgColor
        addSubview(_button)

        _label.frame = CGRect(x: 36 - 72 * 0.5, y: self.bounds.height + 8, width: 72, height: 16 * 2)
        _label.textAlignment = .center
        _label.numberOfLines = 0
        addSubview(_label)
        
        state = .regular
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func addTarget(_ target: Any?, action selector: Selector, for event: UIControlEvents) {
        _target = target
        _selector = selector
        _button.addTarget(self, action: #selector(onClick), for: event)
    }
    
    // MARK: - Floatable Protocol
    
    var asIngridient: SWIngredient {
        get {
            if _ingredient == nil {
                return SWIngredient(name, of: .unexpected, as: _button.image(for: .normal)!, _button.image(for: .normal)!, quantity: -1, unit: -1)
            }
            else {
                return _ingredient
            }
        }
    }
    
    // MARK: - Private Methods
    
    @IBAction private func onClick() {
        if let target = _target as? NSObjectProtocol, let selector = _selector {
            if target.responds(to: selector) {
                target.perform(selector, with: self)
            }
        }
    }
}
