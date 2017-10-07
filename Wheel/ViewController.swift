//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    var _prev: CGFloat?
    
    // MARK: - Subs
    
    var radialMenu: RadialView!
    
    var basesMenu: RadialView!
    
    var fatsMenu: RadialView!
    
    var veggiesMenu: RadialView!
    
    var proteinsMenu: RadialView!
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.radialMenu = RadialView(center: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2))
        
        let leftMiddle = CGPoint(x: self.view.frame.width, y: self.view.frame.height / 2)
        
        basesMenu = RadialView(center: leftMiddle, radius: 100, orientation: .left)
        
        fatsMenu = RadialView(center: leftMiddle, radius: 150, orientation: .left)
        
        veggiesMenu = RadialView(center: leftMiddle, radius: 200, orientation: .left)
        
        proteinsMenu = RadialView(center: leftMiddle, radius: 250, orientation: .left)
        
        radialMenu = basesMenu
        
        self.view.addSubview(proteinsMenu)
        self.view.addSubview(veggiesMenu)
        self.view.addSubview(fatsMenu)
        self.view.addSubview(basesMenu)
        
        for menu: RadialView in [basesMenu, fatsMenu, veggiesMenu, proteinsMenu] {
            for _ in 0..<5 {
                menu.addSpoke()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func onButtonClick(_ sender: Any) {
        radialMenu.addSpoke()
    }
    
    @IBAction func onLeftButtonClick(_ sender: Any) {
        radialMenu.shrink()
    }
    
    @IBAction func onRightButtonClick(_ sender: Any) {
        radialMenu.enlarge()
    }
    
    @IBAction func onNextMenu(_ sender: Any) {
        if radialMenu === basesMenu {
            radialMenu = proteinsMenu
        }
        else if radialMenu === fatsMenu {
            radialMenu = basesMenu
        }
        else if radialMenu === veggiesMenu {
            radialMenu = fatsMenu
        }
        else if radialMenu === proteinsMenu {
            radialMenu = veggiesMenu
        }
    }
    
    
    @IBAction func onScroll(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            print("began")
            radialMenu.beginFollow(at: getAngle(point: sender.location(in: self.view), center: radialMenu.center))
        case .cancelled:
            print("cancelled")
        case .changed:
            print("changed")
            radialMenu.continueFollow(at: getAngle(point: sender.location(in: self.view), center: radialMenu.center))
        case .ended:
            radialMenu.endFollow()
        default:
            print("\(sender.state)")
        }
    }
    
    // MARK: - Private Methods
    
    private func getAngle(point: CGPoint, center: CGPoint) -> CGFloat {
        
        let dx = point.x - center.x
        let dy = point.y - center.y
        var angle = atan(abs(dy) / abs(dx))
        
        if dx > 0 &&  dy > 0 {
            //do nothing
        }
        else if dx < 0 &&  dy > 0 {
            angle = CGFloat.pi - angle
        }
        else if dx < 0 &&  dy < 0 {
            angle = CGFloat.pi + angle
        }
        else if dx > 0 &&  dy < 0 {
            angle = CGFloat.pi * 2 - angle
        }
        return angle
    }
    
}

