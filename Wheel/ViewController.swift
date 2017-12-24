//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RadialControllerDelegate, OverlayControllerDelegate, SelectionDelegate, UIGestureRecognizerDelegate
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
    
    var dressing: OverlayController!
    
    var fruits: OverlayController!
    
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
    
    var toUnexpected: ToOverlayButton!
    
    var toDressing: ToOverlayButton!
    
    var toFruits: ToOverlayButton!
    
    var bottomleftDecoration: UIView!
    
    var bottomrightDecoration: UIView!
    
    var topleftDecoration: UIView!
    
    var leftDecoration: UIView!
    
    var wheels: UIView!
    
    var spinner: UIPanGestureRecognizer!
    
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
//            self.selectPins([pin])
            self.add([pin])
        }
        else {
            let moveto = { () -> Void in controller.view.move(to: index) }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: moveto, completion: nil)
        }
    }
    
    // MARK: - OverlayContollerDelegate
    
    func onClose(of controller: OverlayController) -> Void {
        let close = { () in controller.close() }
        let discharge = { (_:Bool) in controller.discharge()}
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: discharge)
    }
    
    func onSelect(in controller: OverlayController) -> Void {
        let close = { () in controller.close() }
        let discharge = { (_:Bool) in controller.discharge()}
//        selectPins([controller.focused])
        add([controller.focused])
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: discharge)
    }
    
    // MARK: - SelectionDelegate
    
    func onRemove(of pin: Floatable, in controller: SelectionController) {
        if controller.selected.count == 1 && controller.selected.first(where: { return $0.asIngridient == pin.asIngridient }) != nil {
            let shrinkdown = { () in self.selectionController.shrinkdown() }
            let discharge = { (_:Bool) in self.selectionController.discharge() }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: shrinkdown, completion: discharge)
        }
        else {
            let close = { () in controller.erase(pin) }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: nil)
        }
    }
    
    func onCook(of pins: [Floatable], in controller: SelectionController) {
        if selectionController.state == .visible {
            let shrinkdown = { () in self.selectionController.shrinkdown() }
            let discharge = { (_:Bool) in self.selectionController.discharge() }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: shrinkdown, completion: discharge)
        }
    }
    
    // MARK: - UIGestureRegocnizerDelegate Methods
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !selectionController.contains(touch) && !unexpected.opened && !dressing.opened && !fruits.opened
    }
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.removeGestureRecognizer(view.gestureRecognizers!.first!)
        
        view.backgroundColor = UIColor.aquaHaze
        
        bottomleftDecoration = UIView(frame: CGRect(x: -137, y: view.bounds.height - 95, width: 243, height: 243))
        bottomleftDecoration.backgroundColor = UIColor.swansdown
        bottomleftDecoration.layer.cornerRadius = 121.5
        view.addSubview(bottomleftDecoration)
        
        bottomrightDecoration = UIView(frame: CGRect(x: view.bounds.width - 253, y: view.bounds.height - 126.5, width: 253, height: 253))
        let border = CAShapeLayer()
        border.strokeColor = UIColor.tiara.cgColor
        border.fillColor = nil
        border.lineDashPattern = [3, 3]
        border.path = UIBezierPath(ovalIn: bottomrightDecoration.bounds).cgPath
        bottomrightDecoration.layer.addSublayer(border)
        view.addSubview(bottomrightDecoration)
        
        topleftDecoration = UIView(frame: CGRect(x: -129, y: -158, width: 253, height: 253))
        topleftDecoration.layer.borderColor = UIColor.jaggedice.cgColor
        topleftDecoration.layer.cornerRadius = topleftDecoration.bounds.width * 0.5
        topleftDecoration.layer.borderWidth = 38
        view.addSubview(topleftDecoration)
        
        leftDecoration = UIView(frame: CGRect(x: 0, y: view.bounds.height - 125 - (12 * 3 + 11 * 2), width: 12 * 5 + 11.5 + 4, height: 12 * 3 + 11 * 2))
        var offset: CGPoint = .zero
        for _ in 0..<3 {
            offset.x = 0
            for _ in 0..<5 {
                let dot = UIView(frame: CGRect(origin: offset, size: CGSize(side: 12)))
                dot.backgroundColor = UIColor.tiara
                dot.layer.cornerRadius = 6
                leftDecoration.addSubview(dot)
                offset.x += 12 + 11.5
            }
            offset.y += 12 + 11
        }
        leftDecoration.alpha = 0.08
        view.addSubview(leftDecoration)
        
        wheels = UIView(frame: view.bounds)
        view.addSubview(wheels)
        
//        let leftMiddle = CGPoint(x: self.view.frame.width + 20, y: self.view.frame.height / 2)
        let leftMiddle = CGPoint(x: wheels.bounds.width + 20, y: wheels.bounds.height / 2)
        
        proteins = ProteinsController()
        proteins.delegate = self
        proteinsMenu = RadialView(center: leftMiddle,orientation: .left)
//        self.view.addSubview(proteinsMenu)
        wheels.addSubview(proteinsMenu)
        proteins.view = proteinsMenu
        
        veggies = VeggiesController()
        veggies.delegate = self
        veggiesMenu = RadialView(center: leftMiddle,orientation: .left)
//        self.view.addSubview(veggiesMenu)
        wheels.addSubview(veggiesMenu)
        veggies.view = veggiesMenu
        
        fats = FatsController()
        fats.delegate = self
        fatsMenu = RadialView(center: leftMiddle,orientation: .left)
//        self.view.addSubview(fatsMenu)
        wheels.addSubview(fatsMenu)
        fats.view = fatsMenu
        
        bases = BasesController()
        bases.delegate = self
        basesMenu = RadialView(center: leftMiddle,orientation: .left)
//        self.view.addSubview(basesMenu)
        wheels.addSubview(basesMenu)
        bases.view = basesMenu
        
        radialMenu = basesMenu
        
//        self.view.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 156)).toLayerView)
        wheels.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 156)).toLayerView)
        
        rollButton = UIButton(frame: CGRect(center: leftMiddle, side: 120)).toRollButton
        rollButton.addTarget(self, action: #selector(self.onNextMenu(_:)), for: .touchUpInside)
//        self.view.addSubview(rollButton)
        wheels.addSubview(rollButton)
        
        proteinsMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
        proteinsMark.textAlignment = .center
//        self.view.addSubview(proteinsMark)
        wheels.addSubview(proteinsMark)
        proteinsMark.text = "proteins".uppercased()
        proteins.label = proteinsMark
        
        veggiesMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
        veggiesMark.textAlignment = .center
//        self.view.addSubview(veggiesMark)
        wheels.addSubview(veggiesMark)
        veggiesMark.text = "veggies".uppercased()
        veggies.label = veggiesMark
        
        fatsMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
        fatsMark.textAlignment = .center
//        self.view.addSubview(fatsMark)
        wheels.addSubview(fatsMark)
        fatsMark.text = "fats".uppercased()
        fats.label = fatsMark
        
        basesMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
        basesMark.textAlignment = .center
//        self.view.addSubview(basesMark)
        wheels.addSubview(basesMark)
        basesMark.text = "bases".uppercased()
        bases.label = basesMark
        
        let hand = UIImageView(image: UIImage.hand)
//        self.view.addSubview(hand)
        wheels.addSubview(hand)
        pointer = PointerController(view: hand, in: .bases)
        
        selectionController = SelectionController()
        selectionController.delegate = self
        selection = TransparentView(frame: self.view.bounds)
//        self.view.addSubview(selection)
        wheels.addSubview(selection)
        selectionController.view = selection
        
        //left side menu initialization
        var nextLeftMenu = CGPoint(x: 16, y: view.bounds.height / 3)
        let deltaLeftMenu = (view.bounds.height / 3 - 56 * 3) * 0.5
        toUnexpected = ToOverlayButton(frame: CGRect(origin: nextLeftMenu, size: .zero))
        toUnexpected.asToUnexpected.addTarget(self, action: #selector(onToUnexpectedClick(_:)), for: .touchUpInside)
        //        self.view.addSubview(toUnexpected)
        wheels.addSubview(toUnexpected)
        nextLeftMenu.y = toUnexpected.frame.origin.y + toUnexpected.frame.height + deltaLeftMenu
        
        toDressing = ToOverlayButton(frame: CGRect(origin: nextLeftMenu, size: .zero))
        toDressing.asToDressing.addTarget(self, action: #selector(onToDressingClick(_:)), for: .touchUpInside)
        //        self.view.addSubview(toDressing)
        wheels.addSubview(toDressing)
        nextLeftMenu.y = toDressing.frame.origin.y + toDressing.frame.height + deltaLeftMenu
        
        toFruits = ToOverlayButton(frame: CGRect(origin: nextLeftMenu, size: .zero))
        toFruits.asToFruits.addTarget(self, action: #selector(onToFruitsClick(_:)), for: .touchUpInside)
        //        self.view.addSubview(toFruits)
        wheels.addSubview(toFruits)
        
        overlay = TransparentView(frame: self.view.bounds)
//        self.view.addSubview(overlay)
        wheels.addSubview(overlay)
        
        unexpected = UnexpectedController()
        unexpected.delegate = self
        unexpected.view = overlay
        toUnexpected.overlay = unexpected
        
        dressing = DressingController()
        dressing.delegate = self
        dressing.view = overlay
        toDressing.overlay = dressing
        
        fruits = FruitsController()
        fruits.delegate = self
        toFruits.overlay = fruits
        fruits.view = overlay
        
        spinner = UIPanGestureRecognizer(target: self, action: #selector(onScroll(_:)))
        spinner.delegate = self
        wheels.addGestureRecognizer(spinner)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    func onToUnexpectedClick(_ sender: UIButton) {
        unexpected.set(for: sender)
        let open = { () in self.unexpected.open() }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: nil)
    }
    
    func onToDressingClick(_ sender: UIButton) {
        dressing.set(for: sender)
        let open = { () in self.dressing.open() }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: nil)
    }
    
    func onToFruitsClick(_ sender: UIButton) {
        fruits.set(for: sender)
        let open = { () in self.fruits.open() }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: nil)
    }
    
    @IBAction func onNextMenu(_ sender: Any) {
        let shuffle = { () -> Void in
            self.bases.moveToRandomPin()
            self.fats.moveToRandomPin()
            self.veggies.moveToRandomPin()
            self.proteins.moveToRandomPin()
            self.unexpected.random()
            self.dressing.random()
            self.fruits.random()
            
            self.selectionController.erase()
        }
        
//        let select = { (_: Bool) -> Void in
//            let focus: [Floatable] = [self.proteins.focused, self.veggies.focused, self.fats.focused, self.bases.focused]
//            self.selectPins(focus)
//
//            let placeholder = { () -> Void in self.toUnexpected.frame.origin.x += 0.1 }
//            let offset = self.estimateSelectionTime(of: focus)
//            let extra: [Floatable] = [self.toUnexpected, self.toDressing, self.toFruits]
//            let upselect = {(_:Bool) in
//                self.selectPins(extra)
//                self.toUnexpected.frame.origin.x -= 0.1
//            }
//            UIView.animate(withDuration: 0.1, delay: offset, options: [], animations: placeholder, completion: upselect)
//        }
        
        let select = { (_: Bool) -> Void in
            let focus: [Floatable] = [self.proteins.focused, self.veggies.focused, self.fats.focused, self.bases.focused, self.toUnexpected, self.toDressing, self.toFruits]
            self.add(focus)
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
    
    private func estimateSelectionTime(of pins: [Floatable]) -> TimeInterval {
        if pins.count > 0 {
            return 0.5 + TimeInterval(pins.count - 1) * 0.1 + 0.1
        }
        else {
            return 0
        }
    }
    
    private func add(_ pins: [Floatable]) {
        if pins.count > 0 {
            
            if selectionController.state == .hidden {
                self.selectionController.set()
                let shrink = { () in self.selectionController.shrink() }
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: shrink, completion: nil)
            }
            
            var delay: TimeInterval = 0
            let speed: TimeInterval = 0.15
            let count: TimeInterval = pins.count == 1 ? 0.5 : 1
//            let speed: TimeInterval = 1
//            let single = pins.count == 1 ? pins[0] : nil
            
            if pins.count == 1 {
                let merge = { () -> Void in
                    self.selectionController.push(islast: false)
                }
                let last = {(finished: Bool) -> Void in
                }
                UIView.animate(withDuration: 1 * speed, delay: 0 * speed, options: [.curveEaseOut], animations: merge, completion: last)
            }
            
            let last = pins.last!.asIngridient
            for pin in pins {
                selectionController.copy(of: pin)

                let move = { () -> Void in
//                    print("\(Date()) move \(pin.asIngridient.name)")
                    self.selectionController.moving(of: pin)
                }
                let finish = { (finished: Bool) -> Void in
//                    print("\(Date()) finish \(pin.asIngridient.name) \(finished)")
                    self.selectionController.merging(of: pin)
                    let merge = { () -> Void in
//                        self.selectionController.push(exception: single, islast: pin.asIngridient == last)
//                        self.selectionController.push(excluding: last)
                        self.selectionController.push(islast: pin.asIngridient == last)
                    }
                    let last = {(finished: Bool) -> Void in
//                        print("\(Date()) last \(pin.asIngridient.name) \(finished)")
                    }
                    UIView.animate(withDuration: 1 * speed, delay: 0 * speed, options: [.curveEaseOut], animations: merge, completion: last)
                }
                UIView.animate(withDuration: 5 * speed * count, delay: delay * speed, options: [.curveEaseIn], animations: move, completion: finish)
                delay += 1.5
            }
        }
    }
    
//    private func selectPins(_ pins: [Floatable]) {

//        if pins.count > 0 {
//
//            if selectionController.state == .hidden {
//                let set = { () in self.selectionController.set() }
//                let overgrow = { () in self.selectionController.overgrow() }
//                let shrink = { () in self.selectionController.shrink() }
//                set()
//
//                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: shrink, completion: nil)
//            }
//
//            self.selectionController.copy(pins)
//
//            let open = { () -> Void in
//                self.selectionController.open(pins.count)
//            }
//            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: open, completion: nil)
//
//            let finish = { (_:Bool) in
//                self.selectionController.merge()
//            }
//
//            var delay: TimeInterval = 0
//            let movings = self.selectionController.movings().reversed()
//            for moving in movings.prefix(movings.count - 1) {
//                UIView.animate(withDuration: 0.5, delay: delay, options: [.curveEaseInOut], animations: moving, completion: nil)
//                delay += 0.1
//            }
//
//            UIView.animate(withDuration: 0.5, delay: delay, options: [.curveEaseInOut], animations: movings.last!, completion: finish)
//
//        }
//    }
    
}

