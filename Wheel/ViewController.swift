//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RadialControllerDelegate
{
    
    // MARK: - Outlets
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
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
        let follow = { () -> Void in
            self.radialMenu = wheel
            self.bases.state = state
            self.fats.state = state
            self.veggies.state = state
            self.proteins.state = state
        }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: follow, completion: nil)

    }
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.op
        view.backgroundColor = UIColor.aquaHaze
        

        
        //------
    
        
        let leftMiddle = CGPoint(x: self.view.frame.width + 20, y: self.view.frame.height / 2)
        
//        self.view.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 600)).toLayerView)
//        self.view.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 480)).toLayerView)
//        self.view.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 360)).toLayerView)
//        self.view.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 240)).toLayerView)
        
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
        self.view.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 156)).toLayerView)
        
//        rollButton = UIButton(frame: CGRect(x: leftMiddle.x - 40, y: leftMiddle.y - 15, width: 40, height: 30)).toRollButton
        rollButton = UIButton(frame: CGRect(center: leftMiddle, side: 120)).toRollButton
//        rollButton.setTitle("Roll", for: .normal)
//        rollButton.setTitleColor(UIColor.white, for: .normal)
        
        rollButton.addTarget(self, action: #selector(self.onNextMenu(_:)), for: .touchUpInside)
//        var insets = UIEdgeInsets()
//        insets.left = -40
        
        
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
        
        
//        let follow = { () -> Void in
//            self.radialMenu.move(by: -0.00126573705433985)
//        }
//        UIView.animate(withDuration: 3.2513769865036, delay: 0, options: [], animations: follow, completion: nil)
    }
    
    private var scrollLastAngle: CGFloat!
    
    private var scrollLastTime: Date!
    
    private var scrollLastDeltaAngle: CGFloat!
    
    var a: [CGFloat] = []
    
    var t: [TimeInterval] = []
    
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
            a.append(deltaAngle)
            t.append(deltaTime)
//            UIView.animate(withDuration: deltaTime, delay: 0, options: [.curveEaseInOut], animations: follow, completion: nil)
            UIView.animate(withDuration: deltaTime, delay: 0, options: [], animations: follow, completion: nil)
            scrollLastAngle = newAngle
            scrollLastTime = newTime
            scrollLastDeltaAngle = deltaAngle
            print("changed \(deltaAngle) \(deltaTime)")
//            changed 2.65796783749384e-05 9.43823701143265
        case .ended:
            var sa: CGFloat = 0
            a.forEach({ (current) -> Void in sa+=current })
            sa = sa / CGFloat((a.count != 0 ? a.count : 1))
            a = []
            var st: TimeInterval = 0
            t.forEach({ (current) -> Void in st+=current })
            st = st / TimeInterval((t.count != 0 ? t.count : 1))
            t = []
            
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
            
            print("end \(sa) \(st)")
        default:
            print("\(sender.state)")
        }
    }
    
    // MARK: - Private Methods
    
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

