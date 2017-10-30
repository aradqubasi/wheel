//
//  SpokeView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/09/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SpokeView: UIView {
    
    // MARK: - Public Properties
    
    var state: RVSpokeState{
        get {
            return _state
        }
        set (new) {
            _state = new
            show()
        }
    }
    
    var SVSide: CGFloat {
        get {
            return _side
        }
        set (new) {
            _side = new
            show()
        }
    }
    
    var SVRadius: CGFloat {
        get {
            return _radius
        }
        set (new) {
            if _side != new {
                _radius = new
                show()
            }
        }
    }

    var SVPoint: CGPoint {
        get {
            return _point
        }
        set (new) {
            _point = new
            show()
            
        }
    }
    
    var delegate: SVDelegate?
    
    // MARK: - Private properties
    private var _circle: UIImageView!
    
    private var _state: RVSpokeState = .invisible
    
    private var _side: CGFloat!
    
    private var _radius: CGFloat!
    
    private var _point: CGPoint!
    
    // MARK: - Initialization
    
    init(point: CGPoint, radius: CGFloat, side: CGFloat) {
        
        self._point = point
        self._radius = radius
        self._side = side
        super.init(frame: CGRect(origin: .zero, size: .zero))
        
        _circle = UIImageView(frame: CGRect(origin: .zero, size: .zero))
        self.addSubview(_circle)
        
        frame.origin.x = _point.x
        frame.origin.y = _point.y
        show()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func show() {
        
        frame.origin.x = _point.x
        frame.origin.y = _point.y
        
        frame.origin.x = _point.x
        frame.origin.y = _point.y
        frame.size.width = _side
        frame.size.height = _side
        backgroundColor = UIColor.clear
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        if let settings = delegate?.GetPicture(self, _state) {
            _circle.image = settings.image
            _radius = settings.pinRadius
        }
        _circle.frame.origin.x = _side / 2 - _radius
        _circle.frame.origin.y = 0
        _circle.frame.size.width = _radius * 2
        _circle.frame.size.height = _radius * 2
        _circle.layer.cornerRadius = _radius
        _circle.clipsToBounds = true
    }
    
    // MARK: - Public Methods
    
    func resize(side: CGFloat, radius: CGFloat) {
        _side = side
        _radius = radius
        show()
    }
}
