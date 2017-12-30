//
//  PinView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

enum PinState {
    case locked
    case free
}

class _PinView: UIButton {
    var delegate: PVDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.onTouchesBegan(superview! as! PinView, touches, with: event)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.onTouchesMoved(superview! as! PinView, touches, with: event)
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.onTouchesEnded(superview! as! PinView, touches, with: event)
        super.touchesEnded(touches, with: event)
    }
    
    override var isUserInteractionEnabled: Bool {
        get {
            return super.isUserInteractionEnabled
        }
        set (new) {
            super.isUserInteractionEnabled = new
        }
    }
}

class PinView: UIView, Floatable {
    
    // MARK: - Private Properties
    
    private var _lock: UIButton!
    
    private var _pin: _PinView!
    
    private var _state: PinState!
    
    private var _delegate: PVDelegate?
    
    private var _tapper: UILongPressGestureRecognizer!
    
    // MARK: - Public Properties
    
    var delegate: PVDelegate? {
        get {
            return _delegate
        }
        set (new) {
            _pin.delegate = new
            _delegate = new
        }
    }
    
    var images: [WState: [SVState: UIImage]] = [:]
    
    var name: String = ""
    
    var original: UIImage!
    
    var isBlank: Bool = false
    
    var kind: IngridientKinds!
    
    // MARK: - Floatable Protocol
    
    var asIngridient: Ingridient {
        get {
            return Ingridient(name, of: kind, as: original)
        }
    }
    
    var state: PinState {
        get {
            return _state
        }
        set (new) {
            setState(to: new)
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _state = .free
        
        _pin = _PinView()
        _pin.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        self.addSubview(_pin)
        
        _lock = UIButton(frame: CGRect(origin: CGPoint(x: -16, y: -16), size: CGSize(side: 32)))
        _lock.backgroundColor = UIColor.azureradiance
        _lock.layer.cornerRadius = 16
        _lock.clipsToBounds = false
        _lock.setImage(UIImage.lock, for: .normal)
        self.addSubview(_lock)
        
        _tapper = UILongPressGestureRecognizer(target: self, action: #selector(onLongPress(_:)))
        _tapper.minimumPressDuration = 1
        _tapper.numberOfTouchesRequired = 1
        _pin.addGestureRecognizer(_tapper)
        
        alignSubviews()
        setState(to: _state)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func alignSubviews() {
        _lock.frame.origin = CGPoint(x: -16, y: -16)
        
        _pin.frame.origin = .zero
        _pin.imageEdgeInsets.left = 5
        _pin.imageEdgeInsets.right = 5
        _pin.imageEdgeInsets.top = 5
        _pin.imageEdgeInsets.bottom = 5
    }
    
    private func setState(to state: PinState) {
        _state = state
        if state == .locked {
            _lock.alpha = 1
//            _lock.transform = CGAffineTransform.identity
        }
        else {
            _lock.alpha = 0
//            _lock.transform = CGAffineTransform.identity.scaledBy(x: 0.01, y: 0.01)
        }
        
    }
    
    @objc private func onClick() {
        delegate?.onClick(self, with: nil)
    }
    
    @objc private func onLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            delegate?.onLongPress(in: self)
        }
    }
    
    // MARK: - Public Methods
    
    func setImage(_ image: UIImage?, for state: UIControlState) {
        _pin.setImage(image, for: state)
    }
    
//    func addTarget(_ target: Any?, action selector: Selector, for event: UIControlEvents) {
//        _target = target
//        _selector = selector
//        _pin.addTarget(self, action: #selector(onClick), for: event)
//    }
    
    func setPin(size: CGSize) {
//        self.frame.size = CGSize(width: size.width + 16, height: size.height + 16)
        self.frame.size = size
        _pin.frame.size = size
        alignSubviews()
    }
    
    // MARK: - Overriden Methods
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        delegate?.onTouchesBegan(self, touches, with: event)
//        super.touchesBegan(touches, with: event)
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        delegate?.onTouchesMoved(self, touches, with: event)
//        super.touchesMoved(touches, with: event)
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        delegate?.onTouchesEnded(self, touches, with: event)
//        super.touchesEnded(touches, with: event)
//    }
    
    // MARK: - Helpers
    
    func icon(default image: UIImage) -> PinView {
        for wState in WState.all {
//            let svState: [SVState: UIImage] = [.focused: image, .visible: image, .invisible: image.alpha(0)]
            let svState: [SVState: UIImage] = [.focused: image, .visible: image, .invisible: image]
            images[wState] = svState
        }
        return self
    }
    
    func icon(_ image: UIImage, for state: WState) -> PinView {
//        images[state] = [.focused: image, .visible: image.alpha(0.5), .invisible: image.alpha(0)]
        images[state] = [.focused: image, .visible: image.alpha(0.5), .invisible: image.alpha(0.5)]

        return self
    }
    
    func icon(selected image: UIImage) -> PinView {
        original = image
        return self
    }
    
    func name(_ name: String) -> PinView {
        self.name = name
        return self
    }
    
    func kind(of ingridient: IngridientKinds) -> PinView {
        self.kind = ingridient
        return self
    }
    
    static var create: PinView {
        get {
            return PinView()
        }
    }
}


//class _PinView: UIButton, Floatable {
//
//    // MARK: - Subviews
//
//    private var _lock: UIButton!
//
//    // MARK: - Publish Properties
//
//    var delegate: PVDelegate?
//
//    var images: [WState: [SVState: UIImage]] = [:]
//
//    var name: String = ""
//
//    var original: UIImage!
//
//    var isBlank: Bool = false
//
//    var kind: IngridientKinds!
//
//    // MARK: - Floatable Protocol
//
//    var asIngridient: Ingridient {
//        get {
//            return Ingridient(name, of: kind, as: original)
//        }
//    }
//
//    // MARK: - Initialization
//
////    override init(frame: CGRect) {
////        super.init(frame: frame)
////        _lock = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(side: 32)))
////        _lock.backgroundColor = UIColor.blue
////        _lock.layer.cornerRadius = 16
////        _lock.clipsToBounds = true
////        self.addSubview(_lock)
////    }
////
////    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//
//    // MARK: - Overriden Methods
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        delegate?.onTouchesBegan(self, touches, with: event)
//        super.touchesBegan(touches, with: event)
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        delegate?.onTouchesMoved(self, touches, with: event)
//        super.touchesMoved(touches, with: event)
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        delegate?.onTouchesEnded(self, touches, with: event)
//        super.touchesEnded(touches, with: event)
//    }
//
//    // MARK: - Helpers
//
//    func icon(default image: UIImage) -> PinView {
//        for wState in WState.all {
//            let svState: [SVState: UIImage] = [.focused: image, .visible: image, .invisible: image.alpha(0)]
//            images[wState] = svState
//        }
//        return self
//    }
//
//    func icon(_ image: UIImage, for state: WState) -> PinView {
//        images[state] = [.focused: image, .visible: image.alpha(0.5), .invisible: image.alpha(0)]
//        return self
//    }
//
//    func icon(selected image: UIImage) -> PinView {
//        original = image
//        return self
//    }
//
//    func name(_ name: String) -> PinView {
//        self.name = name
//        return self
//    }
//
//    func kind(of ingridient: IngridientKinds) -> PinView {
//        self.kind = ingridient
//        return self
//    }
//
//    static var create: PinView {
//        get {
//            return PinView()
//        }
//    }
//}

