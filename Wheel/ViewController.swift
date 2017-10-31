//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RVDelegate {
    
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
    
    // MARK: - RVDelegate Methods
    
    func numberOfSpokes(in wheel: RadialView) -> Int {
        return 5
    }
    
    func radialView(_ wheel: RadialView, _ wheelAt: RVState) -> RVSettings {
        var radius: CGFloat = 120
        var distance: CGFloat = CGFloat.pi / 5
        if wheel === basesMenu {
            radius = 120
            distance = CGFloat.pi / 5
        }
        else if wheel === fatsMenu {
            radius = 180
            distance = CGFloat.pi / 5 * 0.67
        }
        else if wheel === veggiesMenu {
            radius = 240
            distance = CGFloat.pi / 5 * 0.5
        }
        else if wheel === proteinsMenu {
            radius = 300
            distance = CGFloat.pi / 5 * 0.4
        }
        return RVSettings(wheelRadius: radius, pinDistance: distance)
    }
    
    func radialView(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ spokeAt: RVSpokeState, _ indexIs: Int) -> SVSettings {
        
        var pin: CGFloat = 10
        if wheelAt == .active {
            pin = 25
        }
        else if wheelAt == .inactive {
            pin = 20
        }
        
        var stateColor: UIColor = .blue
        if spokeAt == .focused {
            stateColor = UIColor.yellow
        }
        else if spokeAt == .visible {
            stateColor = UIColor.black
        }
        else if spokeAt == .invisible {
            stateColor = UIColor.white
        }
        
        guard let image = UIImage(color: stateColor, size: CGSize(width: pin, height: pin)) else {
            fatalError("could not generate image for color \(stateColor) with side \(pin)")
        }
        
        return SVSettings(image, pin)
    }
    
    func onPinClick(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ spokeAt: RVSpokeState, _ indexIs: Int) {
        let switchWheelGotoPin = { () -> Void in
            self.setActiveState(to: wheel)
            wheel.move(to: indexIs)
        }
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: switchWheelGotoPin, completion: nil)
    }
    
    var rollButton: UIButton!
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftMiddle = CGPoint(x: self.view.frame.width, y: self.view.frame.height / 2)
        
        basesMenu = RadialView(center: leftMiddle,orientation: .left)
        basesMenu.delegate = self
        
        fatsMenu = RadialView(center: leftMiddle,orientation: .left)
        fatsMenu.delegate = self
        
        veggiesMenu = RadialView(center: leftMiddle,orientation: .left)
        veggiesMenu.delegate = self
        
        proteinsMenu = RadialView(center: leftMiddle,orientation: .left)
        proteinsMenu.delegate = self
        
        setActiveState(to: basesMenu)
        
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
        radialMenu.addSpoke()
    }
    
    @IBAction func onLeftButtonClick(_ sender: Any) {
    }
    
    @IBAction func onRightButtonClick(_ sender: Any) {
    }
    
    @IBAction func onNextMenu(_ sender: Any) {
        let  resize = { () -> Void in
            if self.radialMenu === self.basesMenu {
                self.setActiveState(to: self.fatsMenu)
            }
            else if self.radialMenu === self.fatsMenu {
                self.setActiveState(to: self.veggiesMenu)
            }
            else if self.radialMenu === self.veggiesMenu {
                self.setActiveState(to: self.proteinsMenu)
            }
            else if self.radialMenu === self.proteinsMenu {
                self.setActiveState(to: self.basesMenu)
            }
        }
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: resize, completion: nil)
    }
    
    private var scrollLastAngle: CGFloat!
    
    private var scrollLastTime: Date!
    
    @IBAction func onScroll(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            scrollLastAngle = getAngle(point: sender.location(in: self.view), center: radialMenu.center)
            scrollLastTime = Date()
        case .changed://, .ended:
            let newAngle = getAngle(point: sender.location(in: self.view), center: radialMenu.center)
            let newTime = Date()
//            print("\(newAngle / CGFloat.pi)")
            let deltaAngle = newAngle - scrollLastAngle
            let deltaTime = newTime.timeIntervalSince(scrollLastTime)
            print(deltaAngle)
            let follow = { () -> Void in
                self.radialMenu.move(by: deltaAngle)
            }

            
            UIView.animate(withDuration: deltaTime, delay: 0, options: [.curveEaseInOut], animations: follow, completion: nil)
            scrollLastAngle = newAngle
            scrollLastTime = newTime
        case .ended:
            let normalization = { () -> Void in
                self.radialMenu.move(to: self.radialMenu.RVFocused)
            }
            
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: normalization, completion: nil)
            
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

