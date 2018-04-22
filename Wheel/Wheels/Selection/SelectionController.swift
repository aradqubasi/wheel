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
            
            holder.toSelectedHolderView()

            _shroud.frame.origin = CGPoint(x: new.bounds.width - 95 - 16, y: new.bounds.height - 95 - 16)
            new.addSubview(_shroud)
            
            cook.frame.origin = CGPoint(x: new.frame.width - 8 - 24 - 32, y: new.frame.height - 80 - 12 + 16)
            new.addSubview(cook)
            
            floatings.forEach({(next) in next.scene = new})
            
            discharge()
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
    
    // MARK: - Subviews
    
    private var _tips: SWTipController!
    
    private var _scene: UIView?
    
    private var cook: UIButton!
    
    private var floatings: [FloatingSelectedView] = []
    
    private var _state: SelectionState!
    
    private var _socket: UIView!
    
    private var holder: UIScrollView!
    
    private var _shroud: UIView!
    
    // MARK: - Initializers
    
    init() {
        _socket = UIView()
        
        holder = SelectedHolderView()
        holder.contentSize = CGSize(width: 16 + 96, height: 96)

        
        let icon = CGRect(origin: CGPoint(x: 8, y: 16), size: CGSize(width: 64, height: 64))

        cook = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        cook.setImage(UIImage.nextpressed, for: .normal)
        cook.addTarget(self, action: #selector(onCookClick(sender:)), for: .touchUpInside)

        _shroud = TransparentView(frame: CGRect(origin: .zero, size: CGSize(side: 94)))
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.init(red: 1, green: 1, blue: 1, alpha: 0).cgColor, UIColor.white.cgColor]
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

        floatings.forEach({(next) -> Void in
            next.menu = holder
            next.addTarget(self, action: #selector(onFoodClick(sender:)), for: .touchUpInside)
        })
        
        _state = .hidden
        
        _tips = SWTipController()
        
        readyCheck()
    }
    
    // MARK: - Actions
    
    @IBAction private func onCookClick(sender: UIButton) -> Void {
        delegate?.onCook(in: self)
    }
    
    @IBAction private func onCookTryClick(sender: UIButton) -> Void {
        delegate?.onCookTry(in: self)
    }
    
    @IBAction private func onFoodClick(sender: FloatingSelectedView) {
        delegate?.onRemove(of: sender, in: self)
    }
    
    // MARK: - Private Methods
    
    private func readyCheck() {
        let stuff = selected.map({ $0.asIngridient.kind })
        
        let basefull = stuff.filter({ $0 == .base }).count == 1
        let fatmost = stuff.filter({ $0 == .fat }).count == 1
        let veggitized = stuff.filter({ $0 == .veggy }).count == 1
        let proteinum = stuff.filter({ $0 == .protein }).count == 1
        let decorated = stuff.filter({
            if $0 == .unexpected {
                return true
            }
            else if $0 == .dressing {
                return true
            }
            else if $0 == .fruits {
                return true
            }
            else {
                return false
            }
        }).count >= 1
        
        if basefull && fatmost && veggitized && proteinum && decorated {
            cook.removeTarget(self, action: #selector(onCookTryClick(sender:)), for: .touchUpInside)
            cook.setImage(UIImage.nextpressed, for: .normal)
            cook.addTarget(self, action: #selector(onCookClick(sender:)), for: .touchUpInside)
//            cook.isUserInteractionEnabled = true
        }
        else {
            cook.removeTarget(self, action: #selector(onCookClick(sender:)), for: .touchUpInside)
            cook.setImage(UIImage.next, for: .normal)
            cook.addTarget(self, action: #selector(onCookTryClick(sender:)), for: .touchUpInside)
//            cook.isUserInteractionEnabled = false
        }
    }
    
    // MARK: - Public Methods
    
    func contains(_ touch: UITouch) -> Bool {
        return holder.bounds.contains(touch.location(in: holder))
    }
    
    func will(fit ingridient: SWIngredient) -> Bool {
        let selected = self.selected.map({ $0.asIngridient })
        return !selected.contains(where: { $0.kind == ingridient.kind })
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
        for spot in floatings {
            spot.discharge()
        }
        
        holder.contentSize = CGSize(width: 16 + 96, height: 96)
        
        readyCheck()
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
        
        readyCheck()
    }
    
    /**animatable - shrink to nothing*/
    func shrinkdown() {

        for spot in floatings {
            spot.discharge()
        }
        
        holder.contentSize = CGSize(width: 16 + 96, height: 96)
        
        cook.alpha = 0
        
        holder.transform = CGAffineTransform.identity.scaledBy(x: 0.01, y: 0.01)
        
        readyCheck()
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
    func push(islast: Bool) {
        if (!islast) {
            var offset = CGPoint(x: 8 + 64, y: 16)
            for spot in floatings {
                if spot.state == .inmenu {
                    spot.frame.origin.x += 64
                    offset.x += 64
                }
            }
            holder.contentSize = CGSize(width: offset.x - 64 + 8 + 96, height: 96)
        }
    }
  
    /**instant - finish movement*/
    func merging(of pin: Floatable) {
        if let delivered = floatings.first(where: { return $0.state == .delivered && $0.food == pin.asIngridient }) {
            delivered.tomenu()
        }
        readyCheck()
    }
    
    /**instant - replace existing element of kind with new of same kind, will add new if there is none*/
    func upreplace(with ingredient: SWIngredient) {
        if let existing = floatings.first(where: { $0.food?.kind == ingredient.kind }) {
            existing.replace(with: ingredient)
        }
        else if let spot = floatings.first(where: { $0.state == .free }) {
            push(islast: false)
            spot.place(with: ingredient)
        }
    }
    
    func show(tip: String) {
        _tips.show(tip: tip, at: CGPoint(x: cook.center.x, y: _socket.frame.origin.y + 24), in: view)
        
        _tips.shrink()
        let grow = { () -> Void in self._tips.grow() }
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: grow, completion: nil)
        
        let fade = { () -> Void in self._tips.fade() }
        UIView.animate(withDuration: 0.5, delay: 4, options: [.curveEaseOut], animations: fade, completion: nil)
    }
    
    func hideTip() {
        _tips.unanimate()
    }
}
