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
            
            _ = holder.toSelectedIngridientsView
            
            show()
        }
    }
    
    // MARK: - Private Properties
    

    
    // MARK: - Subviews
    
    private var scene: UIView?
    
    private var cook: UIButton!
    
//    private var selected: [PinView] = []
    private var selected: [SelectedView] = []
    
//    private var screens: [UIView] = []
    
    private var holder: UIView!
    
    // MARK: - Initializers
    
    init() {
        holder = UIView()
        
//        selected = [
//            PinView.create.kind(of: .base),
//            PinView.create.kind(of: .protein),
//            PinView.create.kind(of: .veggy),
//            PinView.create.kind(of: .veggy),
//            PinView.create.kind(of: .veggy),
//            PinView.create.kind(of: .fat),
//            PinView.create.kind(of: .fat),
//            PinView.create.kind(of: .dressing),
//            PinView.create.kind(of: .fruits),
//            PinView.create.kind(of: .unexpected)
//        ]
//        let prepare = { (next: UIView) -> Void in
//            next.frame = CGRect(origin: .zero, size: CGSize(width: 64, height: 64))
//            if let pin = next as? PinView {
//                pin.isBlank = true
//            }
//            else {
//                next.backgroundColor = UIColor.white
//                next.isUserInteractionEnabled = true
//            }
//            self.holder.addSubview(next)
//        }
//        selected.forEach(prepare)
        
        let icon = CGRect(origin: CGPoint(x: 8, y: 16), size: CGSize(width: 64, height: 64))
        selected = [
            SelectedView(frame: icon),
            SelectedView(frame: icon),
            SelectedView(frame: icon),
            SelectedView(frame: icon)
        ]
        selected.forEach({(next) -> Void in holder.addSubview(next)})
        
        cook = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        cook.setImage(UIImage.nextpressed, for: .normal)
        cook.addTarget(self, action: #selector(onCookClick(sender:)), for: .touchUpInside)
        holder.addSubview(cook)
    }
    
    // MARK: - Actions
    
    @objc private func onCookClick(sender: UIButton) -> Void {
        let hide = { () -> Void in
            for item in self.selected {
                item.hide()
            }
        }
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: hide, completion: nil)
    }
    
    // MARK: - Public Methods
    
    func add(_ ingridients: [Ingridient]) {
        
        for ingridient in ingridients {
            let revselected = selected.reversed()
            if let spot = revselected.first(where: {(next) in return next.food == nil}) {
                spot.food = ingridient
            }
            else {
                break
            }
        }
        
        show()
//        for ingridient in ingridients {
//            if let spot = selected.first(where: {(next) in return next.isBlank}) {
//                spot.isBlank = false
//                spot.kind(of: ingridient.kind).icon(selected: ingridient.image).setImage(spot.original, for: .normal)
//            }
//            else {
//                break
//            }
//        }
//
//        show()
        
    }
    
    // MARK: - Private Methods
    
    private func show() {
        let initial: CGPoint = CGPoint(x: 8, y: 16)
        var offset: CGPoint = CGPoint(x: initial.x, y: initial.y)
        let stepx: CGFloat = 64
        for item in selected {
            if let food = item.food {
                item.show(food, at: offset)
                offset.x += stepx
            }
            else {
                item.hide()
            }
        }
//        let initial: CGPoint = CGPoint(x: 8, y: 16)
//
//        let full: CGSize = CGSize(width: 64, height: 64)
//
//        var offset: CGPoint = CGPoint(x: initial.x, y: initial.y)
//
//        var new: [PinView] = []
//
//        new.append(selected[0])
//        if selected[0].isBlank {
//            selected[0].frame.origin = initial
//            selected[0].frame.size = .zero
//        }
//        else {
//            selected[0].frame.origin = offset
//            selected[0].frame.size = full
//            offset.x += 64
//        }
//        for i in 1..<selected.count {
//            if selected[i].isBlank {
//                selected[i].frame.origin = initial
//                selected[i].frame.size = .zero
//                new.insert(selected[i], at: 0)
//            }
//            else {
//                selected[i].frame.origin = offset
//                selected[i].frame.size = full
//                offset.x += 64
//                new.append(selected[i])
//            }
//        }
//
//        selected = new
//
//        let hide = { ()
//
//        }
//
        cook.frame.origin = CGPoint(x: holder.frame.width - initial.x - 64, y: initial.y)
    }
    
}
