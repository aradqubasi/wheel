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
    
    var kind: SWIngredientKinds!
    
    // MARK: - Floatable Protocol
    
    var asIngridient: SWIngredient {
        get {
            return SWIngredient(name, of: kind, as: original, original, quantity: -1, unit: -1)
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
    }
    
    private func setState(to state: PinState) {
        _state = state
        _lock.alpha = 0
//        if state == .locked {
//            _lock.alpha = 1
//        }
//        else {
//            _lock.alpha = 0
//        }
        
    }
    
    @IBAction private func onClick() {
        delegate?.onClick(self, with: nil)
    }
    
    @IBAction private func onLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            delegate?.onLongPress(in: self)
        }
    }
    
    // MARK: - Public Methods
    
    func setImage(_ image: UIImage?, for state: UIControlState) {
        _pin.setImage(image, for: state)
    }
    
    func setPin(size: CGSize) {
        self.frame.size = size
        _pin.frame.size = size
        alignSubviews()
//        do {
//            let colors: [UIColor] = [.red, .blue, .green, .black, .orange]
//            let color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
//            for x in stride(from: 0, to: bounds.width, by: 8) {
//                for y in stride(from: 0, to: bounds.height, by: 8) {
//                    let dot = UIView(frame: CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: 4, height: 4)))
//                    dot.backgroundColor = color
//                    addSubview(dot)
//                }
//            }
//        }
    }
    
    // MARK: - Helpers
    
    func icon(default image: UIImage) -> PinView {
        for wState in WState.all {
            let svState: [SVState: UIImage] = [.focused: image, .visible: image, .invisible: image]
            images[wState] = svState
        }
        return self
    }
    
    func icon(_ image: UIImage, for state: WState) -> PinView {
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
    
    func kind(of ingridient: SWIngredientKinds) -> PinView {
        self.kind = ingridient
        return self
    }
    
    static var create: PinView {
        get {
            return PinView()
        }
    }
    
}



