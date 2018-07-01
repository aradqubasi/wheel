//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class WheelsViewController: SWViewController, SWAbstractWheelControllerDelegate, OverlayControllerDelegate, SelectionDelegate, UIGestureRecognizerDelegate, OptionsDelegate, SWTransparentViewDelegate//, UINavigationControllerDelegate
{
    
    // MARK: - Outlets
    
    // MARK: - Public Properties
    
    var assembler: SWWheelsAssembler!
    
    // MARK: - Private Properties
    
    private var _tipster: SWTipGenerator!
    
    private var _aligner: SWWheelsAligner!
    
    private var _ingredients: SWIngredientRepository!
    
    private var _blockings: SWBlockingRepository!
    
    private var _options: SWOptionRepository!
        
    var bases: SWAbstractWheelController!
    
    var fats: SWAbstractWheelController!
    
    var veggies: SWAbstractWheelController!
    
    var proteins: SWAbstractWheelController!
    
    var pointer: PointerController!
    
    var selectionController: SelectionController!
    
    var selected: [SWIngredient]!
    
    var unexpected: SWOverlayController!
    
    var dressing: SWOverlayController!
    
    var fruits: SWOverlayController!
    
    var options: OptionsController!
    
    var overlayTransitionContext: SWIngredientKinds?
    
//    var tips: SWTipController!
    
    // MARK: - Subs
    
    var current: SWAbstractWheelController!
    
    var basesMark: UILabel!
    
    var fatsMark: UILabel!
    
    var veggiesMark: UILabel!
    
    var proteinsMark: UILabel!
    
    var rollButton: UIButton!
    
    var selection: TransparentView!
    
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
    
    var scrollvelocity: CGFloat!
    
    var adding: Bool!
    
    // MARK: - Debug
    
    var input: UITextField!
    
    var roll: UIButton!
    
    // MARK: - TransparentView delegate
    
    func onClickThrough(at view: TransparentView) -> Void {
        selectionController.hideTip()
    }
    
    // MARK: - SWAbstractWheelControllerDelegate
    
    func onStateChange(_ sender: SWAbstractWheelController, to state: WState) -> Void {
        print("onStateChange")
        
        _decelerating = false
        
        let follow = { () -> Void in
            self.current = sender
            self.bases.state = state
            self.fats.state = state
            self.veggies.state = state
            self.proteins.state = state
            self.pointer.state = state
        }
        
        let showend = { (_: Bool) -> Void in }

        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: follow, completion: showend)

    }
    
    func onPinClick(_ sender: SWAbstractWheelController, of pin: PinView, at index: Int) -> Void {
        
        if current.isLocked && current.focused.kind == pin.kind && current.index != index {
            shake(of: current, thoward: index > current.index ? 1 : -1)
        }
        else if self.selectionController.selected.first(where: { $0.asIngridient.kind == pin.asIngridient.kind }) != nil {
            let moveto = { () -> Void in
                sender.move(to: index)
                self.selectionController.upreplace(with: pin.asIngridient)
            }
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: moveto, completion: nil)
        }
        else {
            let moveto = { () -> Void in
                sender.move(to: index)
            }
            let showend = { (_: Bool) -> Void in
                self.add([pin])
            }

            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: moveto, completion: showend)
        }
        
    }
    
    func onPinPress(_ sender: SWAbstractWheelController, of pin: PinView, at index: Int) {
        
        onStateChange(sender, to: sender.active)
        
        options.set(for: pin)
        
        let show = { () -> Void in
            self.options.show()
        }
        
        let showend = { (_: Bool) -> Void in }
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: show, completion: showend)
    }
    
    func onUnlockClick(_ sender: SWAbstractWheelController, of pin: PinView, at index: Int) -> Void {
        let unlocking = { () -> Void in
            sender.unlock()
        }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: unlocking, completion: nil)
    }
    
    // MARK: - OverlayContollerDelegate
    
    func onClose(of controller: SWOverlayController) -> Void {
        print("onClose")
        let close = { () in
            controller.close()
        }
        let discharge = { (_:Bool) in
            controller.discharge()
        }
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: discharge)
    }
    
    func onSelect(of pin: NamedPinView, in controller: SWOverlayController) -> Void {
        
        controller.focus(on: pin.asIngridient)
        
        let close = { () in
            controller.close()
        }
        
        let discharge = { (_:Bool) in
            controller.discharge()
        }

        if let focused = controller.focused {
            if selectionController.selected.first(where: { $0.asIngridient.kind == pin.asIngridient.kind }) != nil {
                selectionController.upreplace(with: focused.asIngridient)
            }
            else {
                add([focused])
            }
        }
        
        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: close, completion: discharge)
    }
    
    func onFocus(of pin: SWIngredient, in controller: SWOverlayController) {
        if let selected = selectionController.selected.map({ $0.asIngridient }).first(where: { $0.kind == pin.kind }) {
            controller.focus(on: selected)
        }
        else {
            controller.focus(on: pin)
        }
    }
    
    // MARK: - SelectionDelegate
    
    func onRemove(of pin: Floatable, in controller: SelectionController) {
        if pin.asIngridient.kind == .dressing {
            dressing.unfocus()
        }
        else if pin.asIngridient.kind == .unexpected {
            unexpected.unfocus()
        }
        else if pin.asIngridient.kind == .fruits {
            fruits.unfocus()
        }
        
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
    
    func onCook(in controller: SelectionController) {
        
        selected = selectionController.selected.map({ $0.asIngridient })
        perform(segue: segues.getWheelsToRecipy())
    }
    
    func onCookTry(in controller: SelectionController) {
        let text = _tipster.getTip(for: controller.selected.map({ $0.asIngridient }))
        controller.show(tip: text)
//        tips.show(tip: "cook try bal bla bla", at: CGPoint(x: 354, y: 607), in: selection)
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
                    
                    let unlocking = pin.state == .locked
                    var wheel: SWAbstractWheelController!
                    
                    switch pin.kind {
                    case .base:
                        wheel = self.bases
                    case .fat:
                        wheel = self.fats
                    case .veggy:
                        wheel = self.veggies
                    case .protein:
                        wheel = self.proteins
                    default: break
                    }
                    
                    if wheel.isLocked && unlocking {
                        wheel.unlock()
                    }
                    else if wheel.isLocked && !unlocking {
                        wheel.unlock()
                        wheel.lock(on: pin)
                    }
                    else if !wheel.isLocked && !unlocking {
                        wheel.lock(on: pin)
                    }
                    
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
    
    // MARK: - UINavigationControllerDelegate Methods
    
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        if fromVC is StepsViewController && toVC is RecipyViewController {
//            return SWDismissAnimationContorller()
//        }
//        else {
//            return nil
//        }
//    }
    
    // MARK: - Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _tipster = assembler.resolve()
        _ingredients = assembler.resolve()
        _blockings = assembler.resolve()
        _options = assembler.resolve()
        segues = assembler.resolve()
        _aligner = assembler.resolve()
        
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
            let wheel = SWWheelView.init(_ingredients.getAll(by: .protein), with: 20, as: .proteins, in: container, facing: .leftward)
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
            let wheel = SWWheelView.init(_ingredients.getAll(by: .veggy), with: 20, as: .veggies, in: container, facing: .leftward)
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
            let wheel = SWWheelView.init(_ingredients.getAll(by: .fat), with: 20, as: .fats, in: container, facing: .leftward)
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
            let wheel = SWWheelView.init(_ingredients.getAll(by: .base), with: 20, as: .bases, in: container, facing: .leftward)
            wheel.delegate = self
            bases = wheel
            
            basesMark = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 14))
            basesMark.textAlignment = .center
            wheels.addSubview(basesMark)
            basesMark.text = "bases".uppercased()
            bases.label = basesMark
        }
        
        current = bases
        
        wheels.addSubview(UIView(frame: CGRect(center: leftMiddle, side: 156)).toLayerView)
        
        rollButton = UIButton(frame: CGRect(center: leftMiddle, side: 120)).toRollButton
        rollButton.addTarget(self, action: #selector(self.onNextMenu(_:)), for: .touchUpInside)
        wheels.addSubview(rollButton)
        
        let hand = UIImageView(image: UIImage.hand)
        wheels.addSubview(hand)
        pointer = PointerController(view: hand, in: .bases, at: assembler.resolve(), origin: leftMiddle)
        
        //left side menu initialization
        /*
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
        */
        
        toUnexpected = ToOverlayButton(frame: .zero)
        toUnexpected.asToUnexpected.addTarget(self, action: #selector(onToUnexpectedClick(_:)), for: .touchUpInside)
        wheels.addSubview(toUnexpected)
        _aligner.align(unexpected: toUnexpected)
        
        toDressing = ToOverlayButton(frame: .zero)
        toDressing.asToDressing.addTarget(self, action: #selector(onToDressingClick(_:)), for: .touchUpInside)
        wheels.addSubview(toDressing)
        _aligner.align(dressing: toDressing)
        
        toFruits = ToOverlayButton(frame: .zero)
        toFruits.asToFruits.addTarget(self, action: #selector(onToFruitsClick(_:)), for: .touchUpInside)
        wheels.addSubview(toFruits)
        _aligner.align(fruits: toFruits)
        
        overlay = TransparentView(frame: self.view.bounds)
        navigationController?.view.addSubview(overlay)
        
        selectionController = SelectionController()
        selectionController.delegate = self
        selection = TransparentView(frame: self.view.bounds)
        wheels.addSubview(selection)
        selectionController.view = selection
        selection.delegate = self
        
        unexpected = SWTranslatedOverlayController(ingredients: _ingredients.getAll(by: .unexpected), aligner: _aligner, scene: overlay)
        unexpected.delegate = self
        toUnexpected.overlay = unexpected
        
        dressing = SWTranslatedOverlayController(ingredients: _ingredients.getAll(by: .dressing), aligner: _aligner, scene: overlay)
        dressing.delegate = self
        toDressing.overlay = dressing
        
        fruits = SWTranslatedOverlayController(ingredients: _ingredients.getAll(by: .fruits), aligner: _aligner, scene: overlay)
        fruits.delegate = self
        toFruits.overlay = fruits
        
        spinner = UIPanGestureRecognizer(target: self, action: #selector(onScroll(_:)))
        spinner.delegate = self
        wheels.addGestureRecognizer(spinner)
        
        options = OptionsController()
        options.view = overlay
        options.delegate = self
        
        adding = false

        //navigation bar decoration
        do {
            navigationItem.titleView = UILabel.wheelTitle
            
//            let hamburger = UIBarButtonItem.hamburger
//            hamburger.target = self
//            hamburger.action = #selector(onHamburgerButtonClick(_:))
//            navigationItem.leftBarButtonItem = hamburger
            
            let filter = UIBarButtonItem.filter
            filter.target = self
            filter.action = #selector(onFilterButtonClick(_:))
            navigationItem.rightBarButtonItem = filter
        }
        
        
//        do {
//            input = UITextField(frame: CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 1000, height: 20)))
//            input.layer.borderColor = UIColor.black.cgColor
//            input.layer.borderWidth = 2
//            view.addSubview(input)
//
//            roll = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 120), size: CGSize(side: 20)))
//            roll.setTitleColor(UIColor.black, for: .normal)
//            roll.setTitle("*", for: .normal)
//            roll.addTarget(self, action: #selector(onDebug(_:)), for: .touchUpInside)
//            view.addSubview(roll)
//        }
        
        //tip
//        do {
//            tips = SWTipController()
//        }
        
//        guard let nav = navigationController else {
//            fatalError("wheel do not have navigation controller")
//        }
//        nav.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    @IBAction func onFilterButtonClick(_ sender: UIBarButtonItem) {
        print("onFilterButtonClick")
        perform(segue: segues.getWheelsToFilter())
    }
 
    @IBAction func onHamburgerButtonClick(_ sender: UIBarButtonItem) {
        print("onHamburgerButtonClick")
    }
    
    @IBAction func onDebug(_ sender: UIButton) {
//        guard let text = input.text, let number = NumberFormatter().number(from: text) else {
//            print("invalid cgfloat value")
//            return
//        }
//        let k = CGFloat(number.floatValue)
//        print(k)
//        rotate(by: CGFloat.pi * k, in: 1, afterwards: nil)
        
        
//        guard let texts = input.text?.split(separator: ";"), let x = NumberFormatter().number(from: String(texts.first!)), let y = NumberFormatter().number(from: String(texts.last!)) else {
//            print("invalid cgfloat value")
//            return
//        }
//        print("new point is \(CGPoint(x: CGFloat(x), y: CGFloat(y)))")
    }
    
    @IBAction func onToUnexpectedClick(_ sender: UIButton) {
        print("onToUnexpectedClick")
        overlayTransitionContext = .unexpected
        perform(segue: segues.getWheelsToOverlay())
//        unexpected.set(for: sender)
//        let open = { () in
//            self.unexpected.open()
//        }
//        let showend = { (_: Bool) -> Void in }
//        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: showend)
    }
    
    @IBAction func onToDressingClick(_ sender: UIButton) {
        print("onToDressingClick")
        overlayTransitionContext = .dressing
        perform(segue: segues.getWheelsToOverlay())
//        dressing.set(for: sender)
//        let open = { () in
//            self.dressing.open()
//        }
//        let showend = { (_: Bool) -> Void in }
//        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: showend)
    }

    @IBAction func onToFruitsClick(_ sender: UIButton) {
        print("onToFruitsClick")
        overlayTransitionContext = .fruits
        perform(segue: segues.getWheelsToOverlay())
//        fruits.set(for: sender)
//        let open = { () in
//            self.fruits.open()
//        }
//        let showend = { (_: Bool) -> Void in }
//        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: open, completion: showend)
    }
    
    @IBAction func onNextMenu(_ sender: Any) {

        if !adding {
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
                var focus: [Floatable] = [self.proteins.focused, self.veggies.focused, self.fats.focused, self.bases.focused]
                [self.toFruits, self.toDressing, self.toUnexpected].forEach({ (button: ToOverlayButton) in
                    if button.haveSelection {
                        focus.append(button)
                    }
                })
                self.add(focus)
                
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: shuffle, completion: select)
        }
    }
    
    private var scrollLastAngle: CGFloat!
    
    private var scrollLastTime: Date!
    
    private var scrollLastDeltaAngle: CGFloat!
    
    private var scrollAngleCollector: CGFloat!
    
    private var scrollTimeCollector: TimeInterval!
    
    @IBAction func onScroll(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            scrollLastAngle = getAngle(point: sender.location(in: self.view), center: current.center)
            scrollLastTime = Date()
            scrollLastDeltaAngle = 0
            scrollAngleCollector = 0
            scrollTimeCollector = 0
            scrollvelocity = 0
            _decelerating = false
        case .changed:
            let newAngle = getAngle(point: sender.location(in: self.view), center: current.center)
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
                
                if current.isLocked {
                    sender.isEnabled = false
                    sender.isEnabled = true
                    print("nope from changed")
                    shake(of: current, thoward: deltaAngle)
                    return
                }
                
                let follow = { () -> Void in
                    self.current.move(by: deltaAngle)
                }
                let updateSelection = { (_: Bool) -> Void in
                    if self.selectionController.state == .hidden {
                        self.openSelectionBar()
                    }
                    self.selectionController.upreplace(with: self.current.focused.asIngridient)
                }
                UIView.animate(withDuration: deltaTime, delay: 0, options: [], animations: follow, completion: updateSelection)
            }
            scrollLastAngle = newAngle
            scrollLastTime = newTime
            scrollLastDeltaAngle = deltaAngle
            scrollvelocity = deltaAngle / CGFloat(deltaTime)
        case .ended:
            if current.isLocked {
                sender.isEnabled = false
                sender.isEnabled = true
                print("nope from end")
                shake(of: current, thoward: scrollAngleCollector)
                return
            }
            else {
                deceleration(of: current, with: scrollvelocity)
            }
        case .cancelled:
            print("cancelled")
        default:
            print("\(sender.state)")
        }
    }
    
    // MARK: - Private Methods
    
    private func shake(of wheel: SWAbstractWheelController, thoward direction: CGFloat) {
        print("shake(of wheel: SWAbstractWheelController, thoward direction: \(direction)")
        let step = CGFloat.pi * 0.04 * (100 / wheel.radius)
        let direction: CGFloat = direction.sign == .minus ? -1 : 1
        let rate: CGFloat = 0.5
        self.adding = true
        let shakingUp = { () -> Void in
            wheel.move(by: step * direction)
        }
        let finish = { (_: Bool) -> Void in
            let shakingDown = { () -> Void in
                wheel.move(by: -step * 2 * direction)
            }
            let finish = { (_: Bool) -> Void in
                let finish = { (_: Bool) -> Void in
                    self.adding = false
                }
                UIView.animate(withDuration: TimeInterval(0.112 * rate), animations: shakingUp, completion: finish)
            }
            UIView.animate(withDuration: TimeInterval(0.225 * rate), animations: shakingDown, completion: finish)
        }
        UIView.animate(withDuration: TimeInterval(0.112 * rate), animations: shakingUp, completion: finish)
    }
    
    private func rotate(by angle: CGFloat, in time: TimeInterval, afterwards: ((_:Bool) -> Void)?) {
        print("rotate(by angle: \(angle), in time: \(time), afterwards: \(afterwards != nil ? "something" : "nothing")")
        
        let step: CGFloat = angle < 0 ? -0.5 : 0.5
        
        let rotation = {() -> Void in
            var full = angle
            let period = TimeInterval(step / angle)
            var time: TimeInterval = 0
            
            while abs(full) > abs(step) {
                UIView.addKeyframe(withRelativeStartTime: time, relativeDuration: period, animations: { self.current.move(by: step) })
                full -= step
                time += period
            }
            
            let duration = TimeInterval(full / angle)
            UIView.addKeyframe(withRelativeStartTime: time, relativeDuration: duration, animations: { self.current.move(by: full) })
        }
        UIView.animateKeyframes(withDuration: time, delay: 0, options: [], animations: rotation, completion: afterwards)
    }
    
    private var _decelerating: Bool!
    
    private func deceleration(of wheel: SWAbstractWheelController, with velocity: CGFloat) {
        print("deceleration(with velocity: \(velocity)")
        
        var path: CGFloat = 0
        if abs(velocity) > 0.25 {
            let step = CGFloat.pi * 2 / CGFloat(wheel.count)
            path = abs(velocity) * 0.5
            let steps = (path / step).rounded()
            path = abs(steps) < 1 ? step : step * steps
            path = velocity.sign == .minus ? -path : path
        }
        
        let normalization = { (isDone: Bool) -> Void in
            if isDone {
                let toSocket = { () -> Void in
                    wheel.move(to: self.current.index)
                }
                let updateSelection = { (_: Bool) -> Void in
                    if self.selectionController.state == .hidden {
                        self.openSelectionBar()
                    }
                    self.selectionController.upreplace(with: self.current.focused.asIngridient)
                }
                UIView.animate(withDuration: 0.1, delay: 0, options: [], animations: toSocket, completion: updateSelection)
            }
        }

        rotate(by: path, in: 0.5, afterwards: normalization)
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
                openSelectionBar()
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
                
                let copy = {
                    self.selectionController.copy(of: pin)
                }
                
                let afterCopy = { (_: Bool) -> Void in
                    let move = { () -> Void in
                        self.selectionController.moving(of: pin)
                    }
                    let finish = { (finished: Bool) -> Void in
                        self.selectionController.merging(of: pin)
                        let merge = { () -> Void in
                            self.selectionController.push(islast: pin.asIngridient == last)
                        }
                        let last = {(finished: Bool) -> Void in
                            if pin.asIngridient == last {
                                self.adding = false
                            }
                        }
                        UIView.animate(withDuration: 1 * speed, delay: 0 * speed, options: [.curveEaseOut], animations: merge, completion: last)
                    }
                    UIView.animate(withDuration: 5 * speed * count, delay: 0, options: [.curveEaseIn], animations: move, completion: finish)
                }
                
                UIView.animate(withDuration: 0, delay: delay * speed, options: [], animations: copy, completion: afterCopy)
                delay += 1.5
            }
        }
        else {
            adding = false
        }
    }
    
    func openSelectionBar() {
        selectionController.set()
        let shrink = { () in self.selectionController.shrink() }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [], animations: shrink, completion: nil)
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToWheels(segue: UIStoryboardSegue) {
        SWContext.root.resolve().getAll().forEach({ print("\($0.name) is \($0.checked)") })
        
        var ingredients: [SWIngredientKinds:[SWIngredient]] = [
            .base: [],
            .fat: [],
            .veggy: [],
            .protein: [],
            .fruits: [],
            .unexpected: [],
            .dressing: []
        ]
        _ingredients.getAll().forEach({ (ingredient) in
            var match = true
            _options.getAll().forEach({ (option) in
                if !option.checked {
                    return
                }
                _blockings.getAll().forEach({ (blocking) in
                    if option.id != blocking.optionId {
                        return
                    }
                    else if blocking.ingredientId != ingredient.id {
                        return
                    }
                    else {
                        match = false
                    }
                })
            })
            if match {
                if ingredients[ingredient.kind] != nil {
                    ingredients[ingredient.kind]!.append(ingredient)
                }
            }
        })
        bases.refill(with: ingredients[.base]!)
        bases.flush()
        fats.refill(with: ingredients[.fat]!)
        fats.flush()
        veggies.refill(with: ingredients[.veggy]!)
        veggies.flush()
        proteins.refill(with: ingredients[.protein]!)
        proteins.flush()
        fruits.flushIngredients(with: ingredients[.fruits]!)
        unexpected.flushIngredients(with: ingredients[.unexpected]!)
        dressing.flushIngredients(with: ingredients[.dressing]!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        // TODO: - pass assembler
        case segues.getWheelsToFilter().identifier?:
            let filter = segue.destination as? FilterViewController
            filter?.assembler = assembler.resolve()
//            filter?.ancestor = view.toImage()
//            filter?.ancestorNavigationBar = navigationController?.navigationBar.toImage()
        case segues.getWheelsToRecipy().identifier?:
            if let recipyViewController = (segue.destination as? RecipyViewController) {
                recipyViewController.assembler = assembler.resolve()
                recipyViewController.selection = []
                selected.forEach({
                    if let ingredient = _ingredients.get(by: $0.name) {
                        recipyViewController.selection.append(ingredient)
                    }
                })
            }
        case segues.getWheelsToOverlay().identifier?:
            print("to \(String(describing: overlayTransitionContext))")
            if let overlayViewController = segue.destination as? OverlayViewController {
                overlayViewController.assembler = assembler.resolve()
                overlayViewController.background = view.snapshotView(afterScreenUpdates: true)
                overlayViewController.kind = overlayTransitionContext!
                overlayViewController.background?.addSubview((navigationController?.view.snapshotView(afterScreenUpdates: true))!)
            }
        default:
            fatalError("Unrecognized segue")
        }
        
    }
    
}

