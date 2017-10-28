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
        var radius: CGFloat
        var distance: CGFloat
        if wheel === basesMenu {
            radius = 120
            distance = CGFloat.pi / 5
        }
        else if wheel === fatsMenu {
            radius = 120 * 1.5
            distance = CGFloat.pi / 5 / 1.5
        }
        else if wheel === veggiesMenu {
            radius = 120 * 2.25
            distance = CGFloat.pi / 5 / 2.25
        }
        else if wheel === proteinsMenu {
            radius = 120 * 3.375
            distance = CGFloat.pi / 5 / 3.375
        }
        return RVSettings(wheelRadius: radius, pinDistance: distance)
    }
    
    func radialView(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ spokeAt: RVSpokeState, _ indexIs: Int) -> SVSettings {
        
        var pin: CGFloat
        if wheelAt == .active {
            pin = 30
        }
        else if wheelAt == .inactive {
            pin = 20
        }
        
        var stateColor: UIColor
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
    
    var rollButton: UIButton!
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.radialMenu = RadialView(center: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2))
        
        let leftMiddle = CGPoint(x: self.view.frame.width, y: self.view.frame.height / 2)
        
//        let baseDistance = CGFloat.pi / 6
//        
//        let baseRadius: CGFloat = 125
        
        
//        basesMenu = RadialView(center: leftMiddle,orientation: .left, settings: RVStateSettings(wheelRadius: baseRadius, pinDistance: baseDistance))
//        
//        fatsMenu = RadialView(center: leftMiddle,orientation: .left, settings: RVStateSettings(wheelRadius: baseRadius * 1.5, pinDistance: baseDistance / 1.5))
//        
//        veggiesMenu = RadialView(center: leftMiddle,orientation: .left, settings: RVStateSettings(wheelRadius: baseRadius * 2, pinDistance: baseDistance / 2))
//        
//        proteinsMenu = RadialView(center: leftMiddle,orientation: .left, settings: RVStateSettings(wheelRadius: baseRadius * 2.5, pinDistance: baseDistance / 2.5))
        
//        basesMenu = RadialView(center: leftMiddle,orientation: .left, radius: basesActive.bases.wheelRadius, distance: basesActive.bases.pinDistance, tip: 20)
//        
//        fatsMenu = RadialView(center: leftMiddle,orientation: .left, radius: basesActive.fats.wheelRadius, distance: basesActive.fats.pinDistance, tip: 20)
//        
//        veggiesMenu = RadialView(center: leftMiddle,orientation: .left, radius: basesActive.veggies.wheelRadius, distance: basesActive.veggies.pinDistance, tip: 20)
//        
//        proteinsMenu = RadialView(center: leftMiddle,orientation: .left, radius: basesActive.proteins.wheelRadius, distance: basesActive.proteins.pinDistance, tip: 20)
        basesMenu = RadialView(center: leftMiddle,orientation: .left)
        
        fatsMenu = RadialView(center: leftMiddle,orientation: .left)
        
        veggiesMenu = RadialView(center: leftMiddle,orientation: .left)
        
        proteinsMenu = RadialView(center: leftMiddle,orientation: .left)
        setRadialsState(as: basesMenu)
        
        radialMenu = basesMenu
        
        self.view.addSubview(proteinsMenu)
        self.view.addSubview(veggiesMenu)
        self.view.addSubview(fatsMenu)
        self.view.addSubview(basesMenu)
//       setRadialsState(as: basesActive)
        for menu: RadialView in [basesMenu, fatsMenu, veggiesMenu, proteinsMenu] {
            for _ in 0..<5 {
                menu.addSpoke()
            }
        }
        
//        setRadialsState(as: basesActive)
        
        rollButton = UIButton(frame: CGRect(x: leftMiddle.x - 40, y: leftMiddle.y - 15, width: 40, height: 30))
        rollButton.setTitle("Roll", for: .normal)
        rollButton.setTitleColor(UIColor.black, for: .normal)
        rollButton.addTarget(self, action: #selector(self.onNextMenu(_:)), for: .touchUpInside)
//        setRadialsState(as: basesActive)
        
        
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
//        radialMenu.shrink()
    }
    
    @IBAction func onRightButtonClick(_ sender: Any) {
//        radialMenu.enlarge()
    }
    
    var some: Bool?
    
    
    @IBAction func onNextMenu(_ sender: Any) {
        
//        var animation: () -> Void
//        
//        if some == nil {
//            animation = { () -> Void in
//                //self.radialMenu.move(by: CGFloat.pi / 6)
//                self.radialMenu.move(by: CGFloat.pi * CGFloat(3))
//            }
//            some = false
//        }
//        else if some! {
//            animation = { () -> Void in
//                //self.radialMenu.move(by: CGFloat.pi / 6)
//                self.radialMenu.move(by: CGFloat.pi * CGFloat(6))
//            }
//            some = false
//        }
//        else {
//            animation = { () -> Void in
//                //self.radialMenu.move(by: CGFloat.pi / 6)
//                self.radialMenu.move(by: CGFloat.pi * -CGFloat(6))
//            }
//            some = true
//        }
//        
//        
//        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: animation, completion: nil)
        
        let  resize = { () -> Void in
            if self.radialMenu === self.basesMenu {
                self.radialMenu.st
                self.radialMenu = self.proteinsMenu
                self.
                self.setRadialsState(as: self.proteinsActive)
            }
            else if self.radialMenu === self.fatsMenu {
                self.radialMenu = self.basesMenu
                self.setRadialsState(as: self.basesActive)
            }
            else if self.radialMenu === self.veggiesMenu {
                self.radialMenu = self.fatsMenu
                self.setRadialsState(as: self.fatsActive)
            }
            else if self.radialMenu === self.proteinsMenu {
                self.radialMenu = self.veggiesMenu
                self.setRadialsState(as: self.veggiesActive)
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
            
            let follow = { () -> Void in
                self.radialMenu.move(by: deltaAngle)
            }

            
            UIView.animate(withDuration: deltaTime, delay: 0, options: [.curveEaseInOut], animations: follow, completion: nil)
        case .ended:
            let normalization = { () -> Void in
                self.radialMenu.move(to: self.radialMenu.RVFocused)
            }
            
            UIView.animate(withDuration: 0.1, delay: 0, options: [.curveEaseInOut], animations: normalization, completion: nil)
            
            print("end")
        default:
            print("\(sender.state)")
        }
//        switch sender.state {
//        case .began:
//            print("began")
//            radialMenu.beginFollow(at: getAngle(point: sender.location(in: self.view), center: radialMenu.center))
//        case .cancelled:
//            print("cancelled")
//        case .changed:
//            print("changed")
//            radialMenu.continueFollow(at: getAngle(point: sender.location(in: self.view), center: radialMenu.center))
//        case .ended:
//            radialMenu.endFollow()
//        default:
//            print("\(sender.state)")
//        }
    }
    
    // MARK: - Private Methods
    
    private func setRadialsState(as settings: WStateSettings) {
//        basesMenu.RVSettings = settings.bases
//        fatsMenu.RVSettings = settings.fats
//        proteinsMenu.RVSettings = settings.proteins
//        veggiesMenu.RVSettings = settings.veggies
        var radius: CGFloat
        var distance: CGFloat
        var tip: CGFloat
        
        radius = settings.bases.wheelRadius
        distance = settings.bases.pinDistance
//        tip = settings.bases.pinRadius
        basesMenu.resize(radius, distance, tip)
        
        radius = settings.fats.wheelRadius
        distance = settings.fats.pinDistance
//        tip = settings.fats.pinRadius
        fatsMenu.resize(radius, distance, tip)
        
        radius = settings.proteins.wheelRadius
        distance = settings.proteins.pinDistance
//        tip = settings.proteins.pinRadius
        proteinsMenu.resize(radius, distance, tip)
        
        radius = settings.veggies.wheelRadius
        distance = settings.veggies.pinDistance
//        tip = settings.veggies.pinRadius
        veggiesMenu.resize(radius, distance, tip)
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

