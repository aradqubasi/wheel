//
//  SelectionController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 27/11/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SelectionController {
    
    // MARK: - Public Properties
    
    var delegate: SelectionDelegate?
    
    var view: UIView {
        get {
            guard let view = _scene else {
                fatalError("no view available")
            }
            return view
        }
        set(new) {
            _scene = new
            
            _socket.frame.size = CGSize(width: (new.bounds.width - 32) * 1.5, height: 96 * 1.5)
            _socket.frame.origin = CGPoint(x: 16 - (new.bounds.width - 32) * 0.25, y: new.bounds.height - 16 - 96 - 96 * 0.25)
            new.addSubview(_socket)
            
            holder.frame.size = CGSize(width: new.bounds.width - 32, height: 96)
            holder.frame.origin = CGPoint(x: (new.bounds.width - 32) * 0.25, y: 96 * 0.25)
            _socket.addSubview(holder)
            
//            new.addSubview(holder)
            holder.toSelectedHolderView()

            _shroud.frame.origin = CGPoint(x: new.bounds.width - 95 - 16, y: new.bounds.height - 95 - 16)
            new.addSubview(_shroud)
            
            cook.frame.origin = CGPoint(x: new.frame.width - 8 - 24 - 32, y: new.frame.height - 80 - 12 + 16)
//            gradient.colors =
            new.addSubview(cook)
            
            
//            floatings.forEach({(next) in new.addSubview(next)})
            floatings.forEach({(next) in next.scene = new})
            
            discharge()
//            show()
        }
    }
    
    var state: SelectionState {
        get {
            return _state
        }
    }
    
    var selected: [Floatable] {
        get {
            return floatings.filter({ return $0.state == .inmenu })
        }
    }
    
    // MARK: - Private Properties
    

    
    // MARK: - Subviews
    
    private var _scene: UIView?
    
    private var cook: UIButton!
    
    private var statics: [StaticSelectedView] = []
    
    private var floatings: [FloatingSelectedView] = []
    
    private var _state: SelectionState!
    
//    private var holder: UIView!
    
    private var _socket: UIView!
    
    private var holder: UIScrollView!
    
    private var _shroud: UIView!
    
    // MARK: - Initializers
    
    init() {
        _socket = UIView()
        
        holder = SelectedHolderView()
//        holder.contentSize = CGSize(width: 16, height: 96)
        holder.contentSize = CGSize(width: 16 + 96, height: 96)

        
        let icon = CGRect(origin: CGPoint(x: 8, y: 16), size: CGSize(width: 64, height: 64))
        statics = [
            StaticSelectedView(frame: icon),
            StaticSelectedView(frame: icon),
            StaticSelectedView(frame: icon),
            StaticSelectedView(frame: icon),
            StaticSelectedView(frame: icon),
            StaticSelectedView(frame: icon),
            StaticSelectedView(frame: icon),
            StaticSelectedView(frame: icon)
        ]
//        statics.forEach({(next) -> Void in
//            holder.addSubview(next)
//            next.addTarget(self, action: #selector(onFoodClick(sender:)), for: .touchUpInside)
//        })
        
        cook = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        cook.setImage(UIImage.nextpressed, for: .normal)
        cook.addTarget(self, action: #selector(onCookClick(sender:)), for: .touchUpInside)
//        cook.layer.cornerRadius = 16
//        cook.layer.shadowColor = UIColor.white.cgColor
//        cook.layer.shadowOpacity = 0.5
//        cook.layer.shadowRadius = 24
//        cook.layer.shadowPath = UIBezierPath(roundedRect: cook.bounds, cornerRadius: 16).cgPath
        
        _shroud = UIView(frame: CGRect(origin: .zero, size: CGSize(side: 94)))
        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        gradient.colors = [UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 0).cgColor, UIColor.white.cgColor]
//        gradient.opacity = 0.83
        gradient.frame = _shroud.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.locations = [0, 0.75]
        _shroud.backgroundColor = UIColor.clear
        _shroud.layer.insertSublayer(gradient, at: 0)
      
        floatings = [
            FloatingSelectedView(frame: icon),
            FloatingSelectedView(frame: icon),
            FloatingSelectedView(frame: icon),
            FloatingSelectedView(frame: icon),
            FloatingSelectedView(frame: icon),
            FloatingSelectedView(frame: icon),
            FloatingSelectedView(frame: icon)
        ]
//        floatings.forEach({(next) -> Void in holder.addSubview(next)})
//        floatings.forEach({(next) -> Void in next.menu = holder})
        floatings.forEach({(next) -> Void in
            next.menu = holder
            next.addTarget(self, action: #selector(onFoodClick(sender:)), for: .touchUpInside)
        })
        
        _state = .hidden
    }
    
    // MARK: - Actions
    
    @objc private func onCookClick(sender: UIButton) -> Void {
//        discharge()
//        print("oncook")
        let ingridients = statics.filter({ return $0.state == .full})
        delegate?.onCook(of: ingridients, in: self)
    }
    
//    @objc private func onFoodClick(sender: StaticSelectedView) {
//        delegate?.onRemove(of: sender, in: self)
//    }
    @objc private func onFoodClick(sender: FloatingSelectedView) {
        delegate?.onRemove(of: sender, in: self)
    }
    
    // MARK: - Public Methods
    
    func contains(_ touch: UITouch) -> Bool {
        return holder.bounds.contains(touch.location(in: holder))
    }
    
    // MARK: - Animation Methods

    /**instant - prepare selection menu for showing up*/
    func set() {
        _socket.frame.origin.x += _socket.frame.width
        holder.alpha = 1
        holder.transform = CGAffineTransform.identity.scaledBy(x: 0.01, y: 0.01)//.rotated(by: CGFloat.pi / 12)
    }
    
    /**animatable - grow & rotate more than maximum*/
    func overgrow() {
        holder.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)//.rotated(by: -CGFloat.pi / 12)
    }
    
    /**animatable - shrink & rotate to normal*/
    func shrink() {
        holder.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)//.rotated(by: 0)
        _state = .visible
        
        cook.alpha = 1
        _shroud.alpha = 1
    }
    
    /**animatable - erase selection*/
    func erase() {
        for spot in statics {
            spot.close()
        }
        
        for spot in floatings {
            spot.discharge()
        }
        
        holder.contentSize = CGSize(width: 16 + 96, height: 96)
    }
    
    /**animatable - erase specific selected ingridient*/
    func erase(_ pin: Floatable) {
        if let erased = floatings.first(where: {
            if $0.state != .inmenu {
                return false
            }
            else if $0.asIngridient == pin.asIngridient {
                return true
            }
            else {
                return false
            }
        }) {
            
            var offset: CGFloat = 0
            let position = erased.frame.origin.x
            for spot in floatings {
                if spot.state == .inmenu && spot.frame.origin.x > position {
                    spot.frame.origin.x -= 64
                }
                offset = max(offset, spot.frame.origin.x)
            }
            erased.discharge()
            holder.contentSize = CGSize(width: offset + 8 + 96, height: 96)
        }
//        if let spot = floatings.first(where: { return $0.food == pin.asIngridient }) {
//            spot.discharge()
//            var offset = CGPoint(x: 8, y: 16)
//            floatings.filter({
//                return $0.state == .inmenu
//            }).forEach({
//                $0.frame.origin = offset
//                offset.x += 64
//            })
//            holder.contentSize = CGSize(width: offset.x - 64 + 8 + 96, height: 96)
//        }
        
        
//        if let spot = statics.first(where: { return $0.food == pin.asIngridient }) {
//            spot.close()
//            var offset = CGPoint(x: 8, y: 16)
//            statics.filter({
//                return $0.state == .full
//            }).forEach({
//                $0.frame.origin = offset
//                offset.x += 64
//            })
//            holder.contentSize = CGSize(width: offset.x - 64 + 8 + 96, height: 96)
//        }
    }
    
    /**instant - make a copies of selected pins*/
//    func copy(_ pins: [Floatable]) {
//        let copies = floatings.filter({(next) in return next.state == .free})
//        for i in 0..<min(copies.count, pins.count) {
//            copies[i].take(for: pins[i])
//        }
//    }
    
    /**old, animatable - open spots for selection*/
//    func open(_ count: Int) {
//        let openings = statics.filter({(next) in return next.state == .closed}).suffix(count)
//
//        var offset = CGPoint(x: 8, y: 16)
//
//        for spot in statics {
//            if openings.contains(spot) {
//                spot.open(to: offset)
//                offset.x += 64
//            }
//            else if spot.state == .full {
//                spot.frame.origin = offset
//                offset.x += 64
//            }
//        }
//
//        holder.contentSize = CGSize(width: offset.x - 64 + 8 + 96, height: 96)
//    }
    
    /**animatable - move floatings to open spots*/
//    func move() {
//
//        let taken = floatings.filter({(next) in return next.state == .taken})
//
//        for i in 0..<taken.count {
//            let destanation = holder.convert(CGPoint(x: 8 + i * 64, y: 16), to: _scene)
//            taken[i].deliver(to: destanation)
//        }
//
//    }
    
    /**animatable - move floatings to open spots*/
//    func movings() -> [() -> Void] {
//
//        var movings: [() -> Void] = []
//
//        let taken = floatings.filter({(next) in return next.state == .taken})
//
//        for i in 0..<taken.count {
//
////            let destanation = holder.convert(CGPoint(x: 8 + i * 64, y: 16), to: _scene)
//            let destanation = holder.convert(CGPoint(x: 8 + 0, y: 16), to: _scene)
//
//            let moving = { () -> Void in
//                taken[i].deliver(to: destanation)
//            }
//
//            movings.append(moving)
//        }
//
//        return movings
//    }
    
    /**instant - finish movement*/
//    func merge() {
//
//        let opened = statics.filter({(next) in return next.state == .opened})
//        let delivered = floatings.filter({(next) in return next.state == .delivered})
//
//        for i in 0..<min(opened.count, delivered.count) {
//            opened[i].fill(with: delivered[i].food!)
//            delivered[i].discharge()
//        }
//
//    }
    
    /**animatable - shrink to nothing*/
    func shrinkdown() {
        for spot in statics {
            spot.close()
        }
        
        for spot in floatings {
            spot.discharge()
        }
        
        holder.contentSize = CGSize(width: 16 + 96, height: 96)
        
        cook.alpha = 0
        
        holder.transform = CGAffineTransform.identity.scaledBy(x: 0.01, y: 0.01)
    }
    
    /**instant - hide empty selection menu*/
    func discharge() {
        _socket.frame.origin.x -= _socket.frame.width
        holder.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        cook.alpha = 0
        holder.alpha = 0
        _shroud.alpha = 0
        _state = .hidden
    }
    
    // MARK: - New Animation Methods
    
    /**instant - make a copies of selected pins*/
    func copy(of pin: Floatable) {
        if let free = floatings.first(where: { return $0.state == .free }) {
            free.take(for: pin)
        }
    }
    
    /**animatable - move pin */
    func moving(of pin: Floatable) {
        if let taken = floatings.first(where: { return $0.food == pin.asIngridient && $0.state == .taken }) {
            taken.deliver(to: holder.convert(CGPoint(x: 8, y: 16), to: _scene))
        }
    }
    
    /**animatable - push menu*/
    func push(exception: Floatable?, islast: Bool) {
        if (!islast && exception == nil) || exception != nil {
            print("push exception: \(exception?.asIngridient.name) islast: \(islast)")
            var offset = CGPoint(x: 8 + 64, y: 16)
            
            for spot in floatings {
                print("spot \(spot.food?.name) in \(spot.state)")
                if spot.state == .inmenu && (exception == nil || exception?.asIngridient != spot.food) {
                    spot.frame.origin.x += 64
                    offset.x += 64
                    print("push")
                }
            }

            holder.contentSize = CGSize(width: offset.x - 64 + 8 + 96, height: 96)
        }
    }
    
    /**instant - finish movement*/
    func merging(of pin: Floatable) {
        if let delivered = floatings.first(where: { return $0.state == .delivered && $0.food == pin.asIngridient }) {
//            print("deliver \(pin.asIngridient.name)")
            delivered.tomenu()
            
//            push()
        }
    }
}
