//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RadialControllerDelegate, OverlayControllerDelegate
{
    
    // MARK: - Outlets
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    var bases: RadialController!
    
    var fats: RadialController!
    
    var veggies: RadialController!
    
    var proteins: RadialController!
    
    var pointer: PointerController!
    
    var selectionController: SelectionController!
    
    var unexpected: OverlayController!
    
    // MARK: - Subs
    
    var radialMenu: RadialView!
    
    var basesMenu: RadialView!
    
    var fatsMenu: RadialView!
    
    var veggiesMenu: RadialView!
    
    var proteinsMenu: RadialView!
    
    var basesMark: UILabel!
    
    var fatsMark: UILabel!
    
    var veggiesMark: UILabel!
    
    var proteinsMark: UILabel!
    
    var rollButton: UIButton!
    
    var selection: UIView!
    
    var overlay: UIView!
    
    var toUnexpected: UIButton!
    
    // MARK: - RadialControllerDelegate
    
    func onStateChange(to state: WState, of wheel: RadialView) -> Void {
        let follow = { () -> Void in
            self.radialMenu = wheel
            self.bases.state = state
            self.fats.state = state
            self.veggies.state = state
            self.proteins.state = state
            self.pointer.state = state
        }

        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: follow, completion: nil)

    }
    
    func onPinClick(in controller: RadialController, of pin: PinView, at index: Int) -> Void {
        if controller.focused == pin {
            self.select([pin])
        }
        else {
            let moveto = { () -> Void in controller.view.move(to: index) }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: moveto, completion: nil)
        }
    }
    
    // MARK: - OverlayContollerDelegate
    
    func onClose(of controller: OverlayController) -> Void {
        if controller is UnexpectedController {
            let close = { () in controller.close() }
            let discharge = { (_:Bool) in controller.discharge()}
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: discharge)
        }
    }
    
    func onSelect(in controller: OverlayController) -> Void {
        if controller is UnexpectedController {
            let close = { () in controller.close() }
            let discharge = { (_:Bool) in controller.discharge()}
            select([controller.focused])
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: discharge)
        }
    }
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.aquaHaze
        
        let leftMiddle = CGPoint(x: self.view.frame.width + 20, y: self.view.frame.height / 2)
        
        proteins = ProteinsController()
        proteins.delegate = self
        proteinsMenu = RadialView(center: leftMiddle,orientation: .left)
        self.view.addSubview(proteinsMenu)
        proteins.view = proteinsMenu
        
        veggies = VeggiesController()
        veggies.delegate = self
        veggiesMenu = RadialView(center: leftMiddle,orientation: .left)
        self.view.addSubview(veggiesMenu)
        veggies.view = veggiesMenu
        
        fats = FatsController()
        fats.delegate = self
        fatsMenu = RadialView(center: leftMiddle,orientation: .left)
        self.view.addSubview(fatsMenu)
        fats.view = fatsMenu
        
        bases = BasesController()
        bases.delegate = self
        basesMenu = RadialView(center: leftMiddle,orientation: .left)
        self.view.addSubview(basesMenu)
        bases.view = basesMenu
        
        radialMenu = basesMenu
        
        self.view.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 156)).toLayerView)
        
        rollButton = UIButton(frame: CGRect(center: leftMiddle, side: 120)).toRollButton
        rollButton.addTarget(self, action: #selector(self.onNextMenu(_:)), for: .touchUpInside)
        self.view.addSubview(rollButton)
        
        proteinsMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
        proteinsMark.textAlignment = .center
        self.view.addSubview(proteinsMark)
        proteinsMark.text = "proteins".uppercased()
        proteins.label = proteinsMark
        
        veggiesMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
        veggiesMark.textAlignment = .center
        self.view.addSubview(veggiesMark)
        veggiesMark.text = "veggies".uppercased()
        veggies.label = veggiesMark
        
        fatsMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
        fatsMark.textAlignment = .center
        self.view.addSubview(fatsMark)
        fatsMark.text = "fats".uppercased()
        fats.label = fatsMark
        
        basesMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
        basesMark.textAlignment = .center
        self.view.addSubview(basesMark)
        basesMark.text = "bases".uppercased()
        bases.label = basesMark
        
        let hand = UIImageView(image: UIImage.hand)
        self.view.addSubview(hand)
        pointer = PointerController(view: hand, in: .bases)
        
        toUnexpected = UIButton(frame: CGRect(origin: CGPoint(x: 16, y: view.frame.height / 3), size: .zero))
        toUnexpected.asToUnexpected.addTarget(self, action: #selector(onToUnexpectedClick(_:)), for: .touchUpInside)
        self.view.addSubview(toUnexpected)
        
        selectionController = SelectionController()
        selection = TransparentView(frame: self.view.bounds)
        self.view.addSubview(selection)
        selectionController.view = selection
        
        unexpected = UnexpectedController()
        unexpected.delegate = self
        overlay = TransparentView(frame: self.view.bounds)
        self.view.addSubview(overlay)
        unexpected.view = overlay
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    func onToUnexpectedClick(_ sender: Any) {
//        print("unexpected!")
        unexpected.set()
        let open = {() in self.unexpected.open() }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: nil)
    }
    
    @IBAction func onButtonClick(_ sender: Any) {
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
            
            self.selectionController.erase()
        }
        
        let select = { (_: Bool) -> Void in
            let focus = [self.proteins.focused, self.veggies.focused, self.fats.focused, self.bases.focused]
            self.select(focus)
        }
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: shuffle, completion: select)
        
    }
    
    private var scrollLastAngle: CGFloat!
    
    private var scrollLastTime: Date!
    
    private var scrollLastDeltaAngle: CGFloat!
    
    private var scrollAngleCollector: CGFloat!
    
    private var scrollTimeCollector: TimeInterval!
    
    @IBAction func onScroll(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            scrollLastAngle = getAngle(point: sender.location(in: self.view), center: radialMenu.center)
            scrollLastTime = Date()
            scrollLastDeltaAngle = 0
            //--
            scrollAngleCollector = 0
            scrollTimeCollector = 0
        case .changed:
            let newAngle = getAngle(point: sender.location(in: self.view), center: radialMenu.center)
            let newTime = Date()
            var deltaAngle = newAngle - scrollLastAngle
            var deltaTime = newTime.timeIntervalSince(scrollLastTime)
            scrollAngleCollector = scrollAngleCollector + deltaAngle
            scrollTimeCollector = scrollTimeCollector + deltaTime
            if scrollTimeCollector >= 0.1 || scrollAngleCollector >= 0.1 {
                deltaTime = scrollTimeCollector
                scrollTimeCollector = 0
                deltaAngle = scrollAngleCollector
                scrollAngleCollector = 0
                
                let follow = { () -> Void in
                    self.radialMenu.move(by: deltaAngle)
                }
                UIView.animate(withDuration: deltaTime, delay: 0, options: [], animations: follow, completion: nil)
            }
            scrollLastAngle = newAngle
            scrollLastTime = newTime
            scrollLastDeltaAngle = deltaAngle
        case .ended:
            let deceleration = {
                () -> Void in
                let angle = self.scrollLastDeltaAngle * 0.225 / CGFloat(Date().timeIntervalSince(self.scrollLastTime))
                self.radialMenu.move(by: angle)
            }

            let normalization = { (_: Bool) -> Void in
                self.radialMenu.move(to: self.radialMenu.RVFocused)
            }
            
            UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: deceleration, completion: normalization)
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
    
    private func select(_ pins: [PinView]) {
        if pins.count > 0 {
            //                self.selectionController.copy([
            //                    self.proteins.focused,
            //                    self.veggies.focused,
            //                    self.fats.focused,
            //                    self.bases.focused
            //                    ])
            self.selectionController.copy(pins)
            
            let open = { () -> Void in
                self.selectionController.open(pins.count)
            }
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: open, completion: nil)
            
            let finish = { (_:Bool) in
                self.selectionController.merge()
            }
            
            var delay: TimeInterval = 0
            let movings = self.selectionController.movings().reversed()
            for moving in movings.prefix(movings.count - 1) {
                UIView.animate(withDuration: 0.5, delay: delay, options: [.curveEaseInOut], animations: moving, completion: nil)
                delay += 0.1
            }
            
            UIView.animate(withDuration: 0.5, delay: delay, options: [.curveEaseInOut], animations: movings.last!, completion: finish)
        }
    }
    
}

