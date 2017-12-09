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
    
    var view: UIView {
        get {
            guard let view = scene else {
                fatalError("no view available")
            }
            return view
        }
        set(new) {
            scene = new
            
            new.addSubview(holder)
            _ = holder.toSelectedHolderView
            
            new.addSubview(cook)
            cook.frame.origin = CGPoint(x: new.frame.width - 8 - 64, y: new.frame.height - 80 - 12)
            
            floatings.forEach({(next) in new.addSubview(next)})
            
//            show()
        }
    }
    
    // MARK: - Private Properties
    

    
    // MARK: - Subviews
    
    private var scene: UIView?
    
    private var cook: UIButton!
    
    private var statics: [StaticSelectedView] = []
    
    private var floatings: [FloatingSelectedView] = []
    
//    private var holder: UIView!
    
    private var holder: UIScrollView!
    
    // MARK: - Initializers
    
    init() {
        holder = SelectedHolderView()
        holder.contentSize = CGSize(width: 16, height: 96)
        
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
        statics.forEach({(next) -> Void in holder.addSubview(next)})
        
        cook = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        cook.setImage(UIImage.nextpressed, for: .normal)
        cook.addTarget(self, action: #selector(onCookClick(sender:)), for: .touchUpInside)
        
        floatings = [
            FloatingSelectedView(frame: icon),
            FloatingSelectedView(frame: icon),
            FloatingSelectedView(frame: icon),
            FloatingSelectedView(frame: icon)
        ]
        floatings.forEach({(next) -> Void in holder.addSubview(next)})
    }
    
    // MARK: - Actions
    
    @objc private func onCookClick(sender: UIButton) -> Void {
//        let hide = { () -> Void in
//            for item in self.statics {
//                item.hide()
//                item.food = nil
//            }
//        }
//        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: hide, completion: nil)
    }
    
    // MARK: - Public Methods

    /**animatable - erase selection*/
    func erase() {
        for spot in statics {
            spot.close()
        }
        
        for spot in floatings {
            spot.discharge()
        }
    }
    
    /**instant - make a copies of selected pins*/
    func copy(_ pins: [PinView]) {
        let copies = floatings.filter({(next) in return next.state == .free})
        for i in 0..<min(copies.count, pins.count) {
            copies[i].take(for: pins[i])
        }
    }
    
    /**animatable - open spots for selection*/
    func open(_ count: Int) {
        
        let openings = statics.filter({(next) in return next.state == .closed}).suffix(count)
        
        var offset = CGPoint(x: 8, y: 16)
        
        for spot in statics {
            if openings.contains(spot) {
                spot.open(to: offset)
                offset.x += 64
            }
            else if spot.state == .full {
                spot.frame.origin = offset
                offset.x += 64
            }
        }
        
    }
    
    /**animatable - move floatings to open spots*/
    func move() {
        
//        var offset = CGPoint(x: 8, y: 16)
//
//        for floating in floatings.filter({(next) in return next.state == .taken}) {
//            let destanation = holder.convert(offset, to: scene)
//            floating.deliver(to: destanation)
//            offset.x += 64
//        }
//
        let taken = floatings.filter({(next) in return next.state == .taken})
        
        for i in 0..<taken.count {
            let destanation = holder.convert(CGPoint(x: 8 + i * 64, y: 16), to: scene)
            taken[i].deliver(to: destanation)
        }
        
    }
    
    /**animatable - move floatings to open spots*/
    func movings() -> [() -> Void] {
        
        var movings: [() -> Void] = []
        
        let taken = floatings.filter({(next) in return next.state == .taken})
        
        for i in 0..<taken.count {
            
            let destanation = holder.convert(CGPoint(x: 8 + i * 64, y: 16), to: scene)
            
            let moving = { () -> Void in
                taken[i].deliver(to: destanation)
            }
            
            movings.append(moving)
        }
        
        return movings
    }
    
    /**instant - finish movement*/
    func merge() {
        
        let opened = statics.filter({(next) in return next.state == .opened})
        let delivered = floatings.filter({(next) in return next.state == .delivered})
        
        for i in 0..<min(opened.count, delivered.count) {
            opened[i].fill(with: delivered[i].food!)
            delivered[i].discharge()
        }
        
    }
    
    // MARK: - Private Methods
    
}
