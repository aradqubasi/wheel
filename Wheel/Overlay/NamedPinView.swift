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
            return _label.text ?? ""
        }
        set(new) {
           _label.text = new
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
    
    // MARK: - Private Properties
    
    var _target: Any?
    
    var _selector: Selector?

    
    // MARK: - Subviews
    
    private let _button = UIButton()
    
    private let _label = UILabel()

    // MARK: - Initialization
    
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
        addSubview(_button)
        
        _label.frame = CGRect(x: 36 - 100, y: self.bounds.height + 8, width: 200, height: 16)
        _label.textAlignment = .center
        _label.font = UIFont.namedpin
        _label.textColor = UIColor.white
        addSubview(_label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func addTarget(_ target: Any?, action selector: Selector, for event: UIControlEvents) {
//        _button.addTarget(target, action: selector, for: event)
        
//        _button.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        _target = target
        
        _selector = selector
    }
    
    // MARK: - Overriden Methods
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        print("hit")
//        return super.hitTest(point, with: event)
//    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesBegan")
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print("touchesMoved")
//    }
//
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let target = _target as? NSObjectProtocol, let selector = _selector {
            if target.responds(to: selector) {
                target.perform(selector, with: self)//.takeRetainedValue()
            }
        }
    }
    
    // MARK: - Floatable Protocol
    
    var asIngridient: Ingridient {
        get {
            return Ingridient(name, of: .unexpected, as: _button.image(for: .normal)!)
        }
    }
    
}
