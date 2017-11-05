//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RVDelegate, PVDelegate {
    
    // MARK: - Outlets
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    var _prev: CGFloat?
    
    var _bases: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView()]
    
    var _fats: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView()]
    
    var _veggies: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView()]
    
    var _proteins: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView()]
    
    // MARK: - Subs
    
    var radialMenu: RadialView!
    
    var basesMenu: RadialView!
    
    var fatsMenu: RadialView!
    
    var veggiesMenu: RadialView!
    
    var proteinsMenu: RadialView!
    
    // MARK: - SVDelegate Methods
    
    func onTouchesBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {
        if let e = event {
            print(e)
        }
        
        let isInMenu = {
            (menuPin: PinView) -> Bool in
            if menuPin === pin {
                return true
            }
            else {
                return false
            }
        }
        
        var newActiveMenu: RadialView
        var index: Int
        if let pos = _bases.index(where: isInMenu) {
            newActiveMenu = basesMenu
            index = pos
        }
        else if let pos = _fats.index(where: isInMenu) {
            newActiveMenu = fatsMenu
            index = pos
        }
        else if let pos = _veggies.index(where: isInMenu) {
            newActiveMenu = veggiesMenu
            index = pos
        }
        else if let pos = _proteins.index(where: isInMenu) {
            newActiveMenu = proteinsMenu
            index = pos
        }
        else {
            fatalError("unrecognized pin @ onTouchesBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Voi ")
        }
        
        let switchWheelGotoPin = { () -> Void in
            self.setActiveState(to: newActiveMenu)
            //newActiveMenu.move(to: index)
        }
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: switchWheelGotoPin, completion: nil)
    }
    
    // MARK: - RVDelegate Methods
    
    func numberOfSpokes(in wheel: RadialView) -> Int {
//        return 5
        if wheel === basesMenu {
            return _bases.count
        }
        else if wheel === fatsMenu {
            return _fats.count
        }
        else if wheel === veggiesMenu {
            return _veggies.count
        }
        else if wheel === proteinsMenu {
            return _proteins.count
        }
        else {
            fatalError("unrecognized wheel @ numberOfSpokes(in wheel: RadialView) -> Int ")
        }
    }
    
    func radialView(_ wheel: RadialView, _ wheelAt: RVState) -> RVSettings {
        var radius: CGFloat = 120
        var distance: CGFloat = CGFloat.pi / 5
        let thickness: CGFloat = 40
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
        return RVSettings(wheelRadius: radius, pinDistance: distance, wheelThickness: thickness )
    }
    
//    func radialView(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ spokeAt: RVSpokeState, _ indexIs: Int) -> SVSettings {
//
//        var pin: CGFloat = 10
//        if wheelAt == .active {
//            pin = 25
//        }
//        else if wheelAt == .inactive {
//            pin = 20
//        }
//
//        var stateColor: UIColor = .blue
//        if spokeAt == .focused {
//            stateColor = UIColor.yellow
//        }
//        else if spokeAt == .visible {
//            stateColor = UIColor.black
//        }
//        else if spokeAt == .invisible {
//            stateColor = UIColor.white
//        }
//
//        guard let image = UIImage(color: stateColor, size: CGSize(width: pin, height: pin)) else {
//            fatalError("could not generate image for color \(stateColor) with side \(pin)")
//        }
//
//        return SVSettings(image, pin)
//    }
    
    func radialView(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ pin: UIView?, _ spokeAt: RVSpokeState, _ indexIs: Int) -> UIView {
        
        let radius: CGFloat
        switch wheelAt {
        case .active:
            radius = 25
        case .inactive:
            radius = 20
        }
        
//        let color: UIColor
//        switch spokeAt {
//        case .focused:
//            color = .yellow
//        case .visible:
//            color = .black
//        case .invisible:
//            color = .white
//        }
        
//        let image = UIImage(color: color, size: CGSize(width: radius * 2, height: radius * 2))
        
        let image = UIImage(named: "Corn")
        var pinButton: PinView
//        if pin == nil {
//            pinButton = UIButton(frame: CGRect(origin: .zero, size: .zero))
//        }
//        else {
//            guard let button = pin as? UIButton else {
//                fatalError("pin is not a UIButton")
//            }
//            pinButton = button
//        }
        //        return 5
        if wheel === basesMenu {
            pinButton = _bases[indexIs]
        }
        else if wheel === fatsMenu {
            pinButton = _fats[indexIs]
        }
        else if wheel === veggiesMenu {
            pinButton = _veggies[indexIs]
        }
        else if wheel === proteinsMenu {
            pinButton = _proteins[indexIs]
        }
        else {
            fatalError("unrecognized wheel @ numberOfSpokes(in wheel: RadialView) -> Int ")
        }

        switch spokeAt {
        case .focused:
            pinButton.alpha = 1
        case .visible:
            pinButton.alpha = 0.4
        case .invisible:
            pinButton.alpha = 0
        }
        
        pinButton.setImage(image, for: .normal)
        
        pinButton.frame.origin = .zero
        pinButton.frame.size.width = radius * 4
        pinButton.frame.size.height = radius * 2
        pinButton.layer.cornerRadius = radius
        pinButton.clipsToBounds = true
        
        return pinButton
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
        
        let setPVDelegate = {
            (pin: PinView) -> Void in
            pin.delegate = self
            pin.addTarget(self, action: #selector(self.onPinClick(_:)), for: .touchUpInside)
        }
//        let _: [Any] = ([_bases, _fats, _veggies, _proteins] as [Any]).forEach(setPVDelegates)
        _bases.forEach(setPVDelegate)
        _fats.forEach(setPVDelegate)
        _veggies.forEach(setPVDelegate)
        _proteins.forEach(setPVDelegate)
        
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
    func onPinClick(_ sender: Any) {
        guard let pin = sender as? PinView, let wheel = getWheel(by: pin), let index = getIndex(of: pin, in: wheel) else {
            fatalError()
        }
        let switchAndGo = { () -> Void in
            self.setActiveState(to: wheel)
            wheel.move(to: index)
        }
        setActiveState(to: wheel)
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: switchAndGo, completion: nil)
    }
    
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
    
    private var scrollLastDeltaAngle: CGFloat!
    
    @IBAction func onScroll(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            scrollLastAngle = getAngle(point: sender.location(in: self.view), center: radialMenu.center)
            scrollLastTime = Date()
            scrollLastDeltaAngle = 0
        case .changed://, .ended:
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
//                print("deceleration \(angle)")
                self.radialMenu.move(by: angle)
            }
            
//            let deceleration = {
//                () -> Void in
//                let velocity = sender.velocity(in: self.view)
//                let angle = (velocity.x * velocity.x + velocity.y * velocity.y).squareRoot() / (2 * CGFloat.pi * self.radialMenu.RVRadius) * 0.112
//                print(angle)
//                self.radialMenu.move(by: angle)
//            }
           
            let normalization = { (_: Bool) -> Void in
                self.radialMenu.move(to: self.radialMenu.RVFocused)
            }
            
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
    
    private func getWheel(by pin: PinView) -> RadialView? {
        if _bases.contains(pin) {
            return basesMenu
        }
        else if _fats.contains(pin) {
            return fatsMenu
        }
        else if _proteins.contains(pin) {
            return proteinsMenu
        }
        else if _veggies.contains(pin) {
            return veggiesMenu
        }
        else {
            return nil
        }
    }
    
    private func getIndex(of pin: PinView, in wheel: RadialView) -> Int? {
        for pins in [_bases, _fats, _veggies, _proteins] {
            if let index = pins.index(where: {
                (next: PinView) -> Bool in
                return next === pin
            }) {
                return index
            }
        }
        return nil
    }
}

