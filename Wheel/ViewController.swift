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
    
    var _veggies: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView()]
    
    var _proteins: [PinView] = [PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView(), PinView()]
    
    // MARK: - Subs
    
    var radialMenu: RadialView!
    
    var basesMenu: RadialView!
    
    var fatsMenu: RadialView!
    
    var veggiesMenu: RadialView!
    
    var proteinsMenu: RadialView!
    
    // MARK: - SVDelegate Methods
    
    func onTouchesBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Void {

        guard let newActiveMenu: RadialView = getWheel(by: pin) else {
            fatalError("unrecognized pin @ onTouchesBegan(_ pin: PinView, _ touches: Set<UITouch>, with event: UIEvent?) -> Voi ")
        }

        let switchWheel = { () -> Void in
            self.setActiveState(to: newActiveMenu)
        }
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: switchWheel, completion: nil)
    }
    
    // MARK: - RVDelegate Methods
    
    func numberOfSpokes(in wheel: RadialView) -> Int {
        guard let pins = getPins(for: wheel) else {
            fatalError("unrecognized wheel @ numberOfSpokes(in wheel: RadialView) -> Int ")
        }
        return pins.count
    }
    
    func radialView(_ wheel: RadialView) -> RVSettings {
        var radius: CGFloat = 120
        var distance: CGFloat = CGFloat.pi / 5
//        let thickness: CGFloat = 40
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
        return RVSettings(radius, distance)
    }

    func radialView(pinFor wheel: RadialView, at index: Int) -> UIView {
        if wheel === basesMenu {
            return _bases[index]
        }
        else if wheel === fatsMenu {
            return _fats[index]
        }
        else if wheel === veggiesMenu {
            return _veggies[index]
        }
        else if wheel === proteinsMenu {
            return _proteins[index]
        }
        else {
            fatalError("unrecognized wheel @ numberOfSpokes(in wheel: RadialView) -> Int ")
        }
    }
    
    func radialView(for wheel: RadialView, update pin: UIView, in state: SVState, at index: Int) -> Void {
        
        let radius: CGFloat
        switch wheel.RVState {
        case .active:
            radius = 25
        case .inactive:
            radius = 20
        }
        
//        let image = UIImage(named: "corn")
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
            pinButton = _bases[index]
        }
        else if wheel === fatsMenu {
            pinButton = _fats[index]
        }
        else if wheel === veggiesMenu {
            pinButton = _veggies[index]
        }
        else if wheel === proteinsMenu {
            pinButton = _proteins[index]
        }
        else {
            fatalError("unrecognized wheel @ numberOfSpokes(in wheel: RadialView) -> Int ")
        }

        switch state {
        case .focused:
            pinButton.alpha = 1
        case .visible:
            pinButton.alpha = 0.4
        case .invisible:
            pinButton.alpha = 0
        }
        
        if wheel === proteinsMenu {
            let pictures = [UIImage.peas, UIImage.fish, UIImage.boiledegg, UIImage.beans, UIImage.chickpeas, UIImage.friedegg, UIImage.lentils, UIImage.mushrooms, UIImage.shrimp]
            let Pictures = [UIImage.Peas, UIImage.Fish, UIImage.Boiledegg, UIImage.Beans, UIImage.Chickpeas, UIImage.Friedegg, UIImage.Lentils, UIImage.Mushrooms, UIImage.Shrimp]
            pinButton.setImage(wheel.RVState == .active ? Pictures[index] : pictures[index], for: .normal)
        }
        else if wheel === veggiesMenu {
            let pictures = [UIImage.asparagus, UIImage.aubergine, UIImage.broccoli, UIImage.carrot, UIImage.cauliflower, UIImage.corn, UIImage.pepper, UIImage.radish, UIImage.tomato]
            let Pictures = [UIImage.Asparagus, UIImage.Aubergine, UIImage.Broccoli, UIImage.Carrot, UIImage.Cauliflower, UIImage.Corn, UIImage.Pepper, UIImage.Radish, UIImage.Tomato]
            pinButton.setImage(wheel.RVState == .active ? Pictures[index] : pictures[index], for: .normal)
        }
        else {
            pinButton.setImage(wheel.RVState == .active ? UIImage.Corn : UIImage.corn, for: .normal)
        }
        
        pinButton.frame.origin = .zero
        pinButton.frame.size.width = radius * 4
        pinButton.frame.size.height = radius * 2
        pinButton.layer.cornerRadius = radius
        pinButton.clipsToBounds = true
        
//        return pinButton
    }
    
//    func onPinClick(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ spokeAt: RVSpokeState, _ indexIs: Int) {
//        let switchWheelGotoPin = { () -> Void in
//            self.setActiveState(to: wheel)
//            wheel.move(to: indexIs)
//        }
//        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: switchWheelGotoPin, completion: nil)
//    }
    
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
    
    private func getPins(for wheel: RadialView) -> [PinView]? {
        if wheel === basesMenu {
            return _bases
        }
        else if wheel === fatsMenu {
            return _fats
        }
        else if wheel === veggiesMenu {
            return _veggies
        }
        else if wheel === proteinsMenu {
            return _proteins
        }
        else {
            return nil
        }
    }
}

