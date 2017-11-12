//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    RadialControllerDelegate
//RVDelegate,
//PVDelegate
{
    
    // MARK: - Outlets
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    var _prev: CGFloat?
    
//    var _bases: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView()]
//
//    var _fats: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView()]
//
//    var _veggies: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView()]
//
//    var _proteins: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView()]
    
    var bases: RadialController!
    
    var fats: RadialController!
    
    var veggies: RadialController!
    
    var proteins: RadialController!
    
    // MARK: - Subs
    
    var radialMenu: RadialView!
    
    var basesMenu: RadialView!
    
    var fatsMenu: RadialView!
    
    var veggiesMenu: RadialView!
    
    var proteinsMenu: RadialView!
    
    var rollButton: UIButton!
    
    // MARK: - RadialControllerDelegate
    
    func onStateChange(to state: WState, of wheel: RadialView) -> Void {
        radialMenu = wheel
        bases.state = state
        fats.state = state
        veggies.state = state
        proteins.state = state
    }
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftMiddle = CGPoint(x: self.view.frame.width, y: self.view.frame.height / 2)
        
        bases = BasesController()
        bases.delegate = self
        basesMenu = RadialView(center: leftMiddle,orientation: .left)
        bases.view = basesMenu
        
        fats = FatsController()
        fats.delegate = self
        fatsMenu = RadialView(center: leftMiddle,orientation: .left)
        fats.view = fatsMenu
        
        veggies = VeggiesController()
        veggies.delegate = self
        veggiesMenu = RadialView(center: leftMiddle,orientation: .left)
        veggies.view = veggiesMenu
        
        proteins = ProteinsController()
        proteins.delegate = self
        proteinsMenu = RadialView(center: leftMiddle,orientation: .left)
        proteins.view = proteinsMenu
        
        radialMenu = basesMenu
        
        self.view.addSubview(proteinsMenu)
        self.view.addSubview(veggiesMenu)
        self.view.addSubview(fatsMenu)
        self.view.addSubview(basesMenu)
        
        rollButton = UIButton(frame: CGRect(x: leftMiddle.x - 40, y: leftMiddle.y - 15, width: 40, height: 30))
        rollButton.setTitle("Roll", for: .normal)
        rollButton.setTitleColor(UIColor.black, for: .normal)
        rollButton.addTarget(self, action: #selector(self.onNextMenu(_:)), for: .touchUpInside)
        
        self.view.addSubview(rollButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func onButtonClick(_ sender: Any) {
//        radialMenu.addSpoke()
    }
    
    @IBAction func onLeftButtonClick(_ sender: Any) {
    }
    
    @IBAction func onRightButtonClick(_ sender: Any) {
    }
    
    @IBAction func onNextMenu(_ sender: Any) {
        let shuffle = { () -> Void in
            self.bases.moveToRandomPin()
            self.fats.moveToRandomPin()
            self.veggies.moveToRandomPin()
            self.proteins.moveToRandomPin()
        }
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: shuffle, completion: nil)
    }
    
    private var scrollLastAngle: CGFloat!
    
    private var scrollLastTime: Date!
    
    private var scrollLastDeltaAngle: CGFloat!
    
    @IBAction func onScroll(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            scrollLastAngle = getAngle(point: sender.location(in: self.view), center: radialMenu.center)
            scrollLastTime = Date()
            scrollLastDeltaAngle = 0
        case .changed://, .ended:
            print("changed")
            let newAngle = getAngle(point: sender.location(in: self.view), center: radialMenu.center)
            let newTime = Date()
//            print("\(newAngle / CGFloat.pi)")
            let deltaAngle = newAngle - scrollLastAngle
            let deltaTime = newTime.timeIntervalSince(scrollLastTime)
//            print(deltaAngle)
            let follow = { () -> Void in
                self.radialMenu.move(by: deltaAngle)
            }

            
            UIView.animate(withDuration: deltaTime, delay: 0, options: [.curveEaseInOut], animations: follow, completion: nil)
            scrollLastAngle = newAngle
            scrollLastTime = newTime
            scrollLastDeltaAngle = deltaAngle
        case .ended:
            let deceleration = {
                () -> Void in
                let angle = self.scrollLastDeltaAngle * 0.112 / CGFloat(Date().timeIntervalSince(self.scrollLastTime))
                self.radialMenu.move(by: angle)
            }

            let normalization = { (_: Bool) -> Void in
                self.radialMenu.move(to: self.radialMenu.RVFocused)
            }
//            let deceleration = { () -> Void in
//                self.radialMenu.move(to: self.radialMenu.RVFocused)
//            }
//
//            let normalization = { (_: Bool) -> Void in
//
//            }
            
            UIView.animate(withDuration: 0.112, delay: 0, options: [.curveEaseInOut], animations: deceleration, completion: normalization)
            
            print("end")
        default:
            print("\(sender.state)")
        }
    }
    
    // MARK: - Private Methods
    
    private func setActiveState(to menu: RadialView) {
        if basesMenu === menu {
            radialMenu = menu
            basesMenu.RVState = .active
            fatsMenu.RVState = .inactive
            veggiesMenu.RVState = .inactive
            proteinsMenu.RVState = .inactive
        }
        else if fatsMenu === menu {
            radialMenu = menu
            basesMenu.RVState = .inactive
            fatsMenu.RVState = .active
            veggiesMenu.RVState = .inactive
            proteinsMenu.RVState = .inactive
        }
        else if veggiesMenu === menu {
            radialMenu = menu
            basesMenu.RVState = .inactive
            fatsMenu.RVState = .inactive
            veggiesMenu.RVState = .active
            proteinsMenu.RVState = .inactive
        }
        else if proteinsMenu === menu {
            radialMenu = menu
            basesMenu.RVState = .inactive
            fatsMenu.RVState = .inactive
            veggiesMenu.RVState = .inactive
            proteinsMenu.RVState = .active
        }
    }
    
    private func getAngle(point: CGPoint, center: CGPoint) -> CGFloat {
        
        let dx = point.x - center.x
        let dy = point.y - center.y
        var angle = atan(abs(dy) / abs(dx))
        
        if dx >= 0 &&  dy >= 0 {
            //do nothing
        }
        else if dx < 0 &&  dy >= 0 {
            angle = CGFloat.pi - angle
        }
        else if dx < 0 &&  dy < 0 {
            angle = CGFloat.pi + angle
        }
        else if dx >= 0 &&  dy < 0 {
            angle = CGFloat.pi * 2 - angle
        }
        return angle
    }
    
}

