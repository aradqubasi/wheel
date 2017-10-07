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
//            switch _state {
//            case .invisible:
//                _circle.backgroundColor = UIColor.white
//            case .visible:
//                _circle.backgroundColor = UIColor.black
//            case .focused:
//                _circle.backgroundColor = UIColor.yellow
//            }
        }
    }
    
    var SVSide: CGFloat {
        get {
            return _side
        }
        set (new) {
            _side = new
            show()
//            if _side != new {
//                _side = new
////                show()
//                frame.size.width = _side
//                frame.size.height = _side
//                _circle.frame.origin.x = _side / 2 - _radius
//            }
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
//                _circle.frame.size.width = _radius * 2
//                _circle.frame.size.height = _radius * 2
//                _circle.layer.cornerRadius = _radius
            }
        }
    }

    var SVPoint: CGPoint {
        get {
            return _point
        }
        set (new) {
            _point = new
//            frame.origin.x = _point.x
//            frame.origin.y = _point.y
            show()
            
        }
    }
//    var offset: CGFloat!
//
//    var visibility: Bool {
//        get {
//            return _visibility
//        }
//        set (new) {
//            if (new) {
//                circle.backgroundColor = UIColor.black
//            }
//            else {
//                circle.backgroundColor = UIColor.white
//            }
//            _visibility = new
//        }
//    }
    
    
    
    // MARK: - Private properties
    private var _circle: UIView!
    
    private var _state: RVSpokeState = .invisible
    
    private var _side: CGFloat!
    
    private var _radius: CGFloat!
    
    private var _point: CGPoint!
//    private var _visibility: Bool = true
//    
//    private var _velocity: CGFloat = 0
//    
//    private var _energy: CGFloat = 0
    
    // MARK: - Initialization
    
    init(point: CGPoint, radius: CGFloat, side: CGFloat) {
        
        self._point = point
        self._radius = radius
        self._side = side
//        super.init(frame: CGRect(origin: point, size: CGSize(width: side, height: side)))
        super.init(frame: CGRect(origin: .zero, size: .zero))
        
//        super.init(frame: CGRect(origin: point, size: CGSize(width: side, height: side)))
//        
//        self.backgroundColor = UIColor.clear
//        
////        self.offset = angle
//        
//        self.circle = UIView(frame: CGRect(origin: CGPoint(x: side / 2 - radius, y: 0), size: CGSize(width: radius * 2, height: radius * 2)))
//        circle.layer.cornerRadius = radius
////        circle.backgroundColor = background
//        
//        self.addSubview(circle)
        _circle = UIView(frame: CGRect(origin: .zero, size: .zero))
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
//        print(frame.origin)
        switch _state {
        case .invisible:
            _circle.backgroundColor = UIColor.white
        case .visible:
            _circle.backgroundColor = UIColor.black
        case .focused:
            _circle.backgroundColor = UIColor.yellow
        }
        frame.origin.x = _point.x
        frame.origin.y = _point.y
        frame.size.width = _side
        frame.size.height = _side
//        frame.size = CGSize(width: _side, height: _side)
        backgroundColor = UIColor.clear
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        _circle.frame.origin.x = _side / 2 - _radius
        _circle.frame.origin.y = 0
        _circle.frame.size.width = _radius * 2
        _circle.frame.size.height = _radius * 2
        _circle.layer.cornerRadius = _radius
        
//        print(_circle.frame.origin)
    }
    
    // MARK: - Public Methods
    
//    func push(_ velocity: CGFloat) {
//        _velocity = velocity
//        _energy = velocity * 3
//        move()
//    }
    func show(side: CGFloat, radius: CGFloat) {
        _side = side
        _radius = radius
        show()
    }
}
