//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RadialControllerDelegate, OverlayControllerDelegate, SelectionDelegate, UIGestureRecognizerDelegate, OptionsDelegate//, SWAbstractWheelDelegate
{
    
    // MARK: - Outlets
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
//    var showtime: Bool!
    
    var bases: SWAbstractWheelController!
//    var bases: RadialController!
    
    var fats: SWAbstractWheelController!
//    var fats: RadialController!
    
    var veggies: SWAbstractWheelController!
//    var veggies: RadialController!
    
    var proteins: SWAbstractWheelController!
//    var proteins: RadialController!
    
    var pointer: PointerController!
    
    var selectionController: SelectionController!
    
    var unexpected: OverlayController!
    
    var dressing: OverlayController!
    
    var fruits: OverlayController!
    
    var options: OptionsController!
    
    // MARK: - Subs
    
    var radialMenu: SWAbstractWheelView!
 
    var basesMenu: SWAbstractWheelView!
    
    var fatsMenu: SWAbstractWheelView!
//    var fatsMenu: RadialView!
    
    var veggiesMenu: SWAbstractWheelView!
//    var veggiesMenu: RadialView!
    
    var proteinsMenu: SWAbstractWheelView!
//    var proteinsMenu: RadialView!
    
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
    
    var disabled: [Int : UIView] = [:]
    
    var scrollvelocity: CGFloat!
    
    var adding: Bool!
    
    // MARK: - RadialControllerDelegate
    
    func onStateChange(to state: WState, of wheel: SWAbstractWheelView) -> Void {
        print("onStateChange")
        
        _decelerating = false
        
        let follow = { () -> Void in
            self.radialMenu = wheel
            self.bases.state = state
            self.fats.state = state
            self.veggies.state = state
            self.proteins.state = state
            self.pointer.state = state
        }
        
        let showend = { (_: Bool) -> Void in }

        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: follow, completion: showend)

    }
    
    func onPinClick(in controller: SWAbstractWheelController, of pin: PinView, at index: Int) -> Void {
        print("onPinClick")
        if controller.focused == pin {
            self.add([pin])
        }
        else {
            let moveto = { () -> Void in
                controller.move(to: index)
            }
            
            let showend = { (_: Bool) -> Void in }
            
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: moveto, completion: showend)
        }
    }
    
    func radialController(preesing pin: PinView, in controller: SWAbstractWheelController, at index: Int) {
        print("radialController")
        
        options.set(for: pin)
        
        let show = { () -> Void in
            self.options.show()
        }
        
        let showend = { (_: Bool) -> Void in }
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: show, completion: showend)
    }
    
    // MARK: - OverlayContollerDelegate
    
    func onClose(of controller: OverlayController) -> Void {
        print("onClose")
        let close = { () in
            controller.close()
        }
        let discharge = { (_:Bool) in
            controller.discharge()
        }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: discharge)
    }
    
    func onSelect(in controller: OverlayController) -> Void {
        print("onSelect")
        
        let close = { () in
            controller.close()
        }
        
        let discharge = { (_:Bool) in
            controller.discharge()
        }

        add([controller.focused])
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: discharge)
    }
    
    // MARK: - SelectionDelegate
    
    func onRemove(of pin: Floatable, in controller: SelectionController) {
        print("onRemove")
        
        if controller.selected.count == 1 && controller.selected.first(where: { return $0.asIngridient == pin.asIngridient }) != nil {
            
            let shrinkdown = { () in
                self.selectionController.shrinkdown()
            }
            
            let discharge = { (_:Bool) in
                self.selectionController.discharge()
            }
            
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: shrinkdown, completion: discharge)
        }
        else {
            
            let close = { () in
                controller.erase(pin)
            }
            
            let showend = { (_: Bool) -> Void in }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: showend)
            
        }
    }
    
    func onCook(of pins: [Floatable], in controller: SelectionController) {
        
        if selectionController.state == .visible {
            let shrinkdown = { () in
                self.selectionController.shrinkdown()
            }
            let discharge = { (_:Bool) in
                self.selectionController.discharge()
            }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: shrinkdown, completion: discharge)
        }
    }
    
    // MARK: - UIGestureRegocnizerDelegate Methods
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !selectionController.contains(touch) && !unexpected.opened && !dressing.opened && !fruits.opened && !options.opened
    }
    
    // MARK: - OptionsDelegate Methods
    
    func optionsDelegate(on action: OptionsActions, in controller: OptionsController) -> Void {
        print("optionsDelegate")
        switch action {
        case .add:
            if let pin = options.pin {
                let hide = { () -> Void in
                    controller.hide()
                }
                let reset = { (_: Bool) -> Void in
                    self.options.discharge()
                }
                UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: hide, completion: reset)
                add([pin])
            }
        case .more:
            let hide = { () -> Void in
                controller.hide()
            }
            let reset = { (_: Bool) -> Void in
                self.options.discharge()
            }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: hide, completion: reset)
        case .lock:
            let hide = { () -> Void in
                controller.hide()
                if let pin = self.options.pin {
                    pin.state = pin.state == .locked ? .free : .locked
                }
            }
            let reset = { (_: Bool) -> Void in
                self.options.discharge()
            }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: hide, completion: reset)

        case .close:
            print("hide")
            let hide = { () -> Void in
                controller.hide()
            }
            let reset = { (_: Bool) -> Void in
                self.options.discharge()
            }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: hide, completion: reset)
        }
    }
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

        let leftMiddle = CGPoint(x: wheels.bounds.width + 20, y: wheels.bounds.height / 2)
   
        //setup proteins
        do {
            let container = TransparentView.init(frame: CGRect(center: leftMiddle, side: 800))
            wheels.addSubview(container)
            let wheel = SWProteinsWheelView(in: container)
            proteinsMenu = wheel.asSWAbstractWheelView()
            wheel.delegate = self
            proteins = wheel
            
            proteinsMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
            proteinsMark.textAlignment = .center
            wheels.addSubview(proteinsMark)
            proteinsMark.text = "veggies".uppercased()
            proteins.label = proteinsMark
        }
        
        //setup veggies
        do {
            let container = TransparentView.init(frame: CGRect(center: leftMiddle, side: 600))
            wheels.addSubview(container)
            let wheel = SWVeggiesWheelView(in: container)
            veggiesMenu = wheel.asSWAbstractWheelView()
            wheel.delegate = self
            veggies = wheel
            
            veggiesMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
            veggiesMark.textAlignment = .center
            wheels.addSubview(veggiesMark)
            veggiesMark.text = "veggies".uppercased()
            veggies.label = veggiesMark
        }
        
        //setup fats
        do {
            let container = TransparentView.init(frame: CGRect(center: leftMiddle, side: 430))
            wheels.addSubview(container)
            let wheel = SWFatsWheelView(in: container)
            fatsMenu = wheel.asSWAbstractWheelView()
            wheel.delegate = self
            fats = wheel
            
            fatsMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
            fatsMark.textAlignment = .center
            wheels.addSubview(fatsMark)
            fatsMark.text = "fats".uppercased()
            fats.label = fatsMark
        }
        
        //setup bases
        do {
            let container = TransparentView.init(frame: CGRect(center: leftMiddle, side: 400))
            wheels.addSubview(container)
            let wheel = SWBasesWheelView(in: container)
            basesMenu = wheel.asSWAbstractWheelView()
            wheel.delegate = self
            bases = wheel
            
            basesMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
            basesMark.textAlignment = .center
            wheels.addSubview(basesMark)
            basesMark.text = "bases".uppercased()
            bases.label = basesMark
        }
        
        radialMenu = basesMenu
        
        wheels.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 156)).toLayerView)
        
        rollButton = UIButton(frame: CGRect(center: leftMiddle, side: 120)).toRollButton
        rollButton.addTarget(self, action: #selector(self.onNextMenu(_:)), for: .touchUpInside)
        wheels.addSubview(rollButton)
        
        let hand = UIImageView(image: UIImage.hand)
        wheels.addSubview(hand)
        pointer = PointerController(view: hand, in: .bases)
        
        selectionController = SelectionController()
        selectionController.delegate = self
        selection = TransparentView(frame: self.view.bounds)
        wheels.addSubview(selection)
        selectionController.view = selection
        
        //left side menu initialization
        var nextLeftMenu = CGPoint(x: 16, y: view.bounds.height / 3)
        let deltaLeftMenu = (view.bounds.height / 3 - 56 * 3) * 0.5
        toUnexpected = ToOverlayButton(frame: CGRect(origin: nextLeftMenu, size: .zero))
        toUnexpected.asToUnexpected.addTarget(self, action: #selector(onToUnexpectedClick(_:)), for: .touchUpInside)
        wheels.addSubview(toUnexpected)
        nextLeftMenu.y = toUnexpected.frame.origin.y + toUnexpected.frame.height + deltaLeftMenu
        
        toDressing = ToOverlayButton(frame: CGRect(origin: nextLeftMenu, size: .zero))
        toDressing.asToDressing.addTarget(self, action: #selector(onToDressingClick(_:)), for: .touchUpInside)
        wheels.addSubview(toDressing)
        nextLeftMenu.y = toDressing.frame.origin.y + toDressing.frame.height + deltaLeftMenu
        
        toFruits = ToOverlayButton(frame: CGRect(origin: nextLeftMenu, size: .zero))
        toFruits.asToFruits.addTarget(self, action: #selector(onToFruitsClick(_:)), for: .touchUpInside)
        wheels.addSubview(toFruits)
        
        overlay = TransparentView(frame: self.view.bounds)
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
        
        options = OptionsController()
        options.view = overlay
        options.delegate = self
        
        adding = false

        let titleView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 25, height: 25)))
        titleView.backgroundColor = UIColor.red
        navigationItem.titleView = titleView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    @IBAction func onToUnexpectedClick(_ sender: UIButton) {
        print("onToUnexpectedClick")
        unexpected.set(for: sender)
        let open = { () in
            self.unexpected.open()
        }
        let showend = { (_: Bool) -> Void in }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: showend)
    }
    
    @IBAction func onToDressingClick(_ sender: UIButton) {
        print("onToDressingClick")
        dressing.set(for: sender)
        let open = { () in
            self.dressing.open()
        }
        let showend = { (_: Bool) -> Void in }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: showend)
    }
    
    @IBAction func onToFruitsClick(_ sender: UIButton) {
        print("onToFruitsClick")
        fruits.set(for: sender)
        let open = { () in
            self.fruits.open()
        }
        let showend = { (_: Bool) -> Void in }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: showend)
    }
    
    @IBAction func onNextMenu(_ sender: Any) {
        print("onNextMenu")
        
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
        
        let select = { (_: Bool) -> Void in
            let focus: [Floatable] = [self.proteins.focused, self.veggies.focused, self.fats.focused, self.bases.focused, self.toUnexpected, self.toDressing, self.toFruits]
            self.add(focus)
            
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: shuffle, completion: select)
        
    }
    
    private var scrollLastAngle: CGFloat!
    
    private var scrollLastTime: Date!
    
    private var scrollLastDeltaAngle: CGFloat!
    
    private var scrollAngleCollector: CGFloat!
    
    private var scrollTimeCollector: TimeInterval!
    
    //TODO
    @IBAction func onScroll(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            scrollLastAngle = getAngle(point: sender.location(in: self.view), center: radialMenu.center)
            scrollLastTime = Date()
            scrollLastDeltaAngle = 0
            //--
            scrollAngleCollector = 0
            scrollTimeCollector = 0
            scrollvelocity = 0
            _decelerating = false
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
                let check = { (_: Bool) -> Void in  /*_ = self.radialMenu.current*/ }
                UIView.animate(withDuration: deltaTime, delay: 0, options: [], animations: follow, completion: check)
            }
            scrollLastAngle = newAngle
            scrollLastTime = newTime
            scrollLastDeltaAngle = deltaAngle
            scrollvelocity = deltaAngle / CGFloat(deltaTime)
        case .ended:
            deceleration(of: radialMenu, with: scrollvelocity)
        default:
            print("\(sender.state)")
        }
    }
    
    // MARK: - Private Methods
    
    private var _decelerating: Bool!
    
    private func deceleration(of wheel: SWAbstractWheelView, with velocity: CGFloat) {
        if let wheel = wheel as? RadialView {
            let velocity = min(abs(velocity), 3) * (velocity.sign == .minus ? -1 : 1)
            
            let k: CGFloat = 0.5
            var time = velocity * k
            
            //        let path = min(abs(wheel.pathToEnd(at: velocity.sign)), abs(velocity * time)) * (velocity.sign == .minus ? -1 : 1)
            
            let maxPath = wheel.pathToEnd(at: velocity.sign)
            
            var path = velocity * time
            
            if abs(path) > abs(maxPath) {
                path = maxPath
                time = path / velocity
            }
            
            let move = { wheel.move(by: path) }
            
            print("velocity \(velocity) time \(time) path \(path)")
            UIView.animate(withDuration: TimeInterval(time), delay: 0, options: [.curveEaseOut], animations: move, completion: nil)
        }
        else if wheel is SWWheelViewAbstracted {
//            let wheel = wheel as! SWWheelView

            let sliding: () -> Void = {
                if velocity != 0 {
                    let step = CGFloat.pi * 2 / CGFloat(wheel.count)
                    var path = abs(velocity) * 0.5
                    let steps = (path / step).rounded()
                    path = abs(steps) < 1 ? step : step * steps
                    path = velocity.sign == .minus ? -path : path
                    wheel.move(by: path)
                }
            }
            
            let normalization = { (isDone: Bool) -> Void in
                if isDone {
                    let toSocket = { () -> Void in
                        wheel.move(to: self.radialMenu.index)
                    }
                    UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: toSocket, completion: nil)
                }
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: sliding, completion: normalization)
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
    
    private func estimateSelectionTime(of pins: [Floatable]) -> TimeInterval {
        if pins.count > 0 {
            return 0.5 + TimeInterval(pins.count - 1) * 0.1 + 0.1
        }
        else {
            return 0
        }
    }
    
    private func add(_ pins: [Floatable]) {
        if adding {
            return
        }
        adding = true
        
        let pins = pins.filter({ selectionController.will(fit: $0.asIngridient) })
        if pins.count > 0 {
            
            if selectionController.state == .hidden {
                self.selectionController.set()
                let shrink = { () in self.selectionController.shrink() }
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: shrink, completion: nil)
            }
            
            var delay: TimeInterval = 0
            let speed: TimeInterval = 0.15
            let count: TimeInterval = pins.count == 1 ? 0.5 : 1
            
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
                        if pin.asIngridient == last {
//                            self.setUserInteractionEnabled(to: true, in: self.view, true)
                            self.adding = false
//                            print("self.adding = false")
                        }
                    }
                    UIView.animate(withDuration: 1 * speed, delay: 0 * speed, options: [.curveEaseOut], animations: merge, completion: last)
                }
                UIView.animate(withDuration: 5 * speed * count, delay: delay * speed, options: [.curveEaseIn], animations: move, completion: finish)
                delay += 1.5
            }
        }
        else {
            adding = false
        }
    }
}

