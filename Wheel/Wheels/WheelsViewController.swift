//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class WheelsViewController: SWViewController, SWAbstractWheelControllerDelegate, UIGestureRecognizerDelegate, OptionsDelegate, SWTransparentViewDelegate
{
    
    // MARK: - Outlets
    
    // MARK: - Public Properties
    
    var assembler: SWWheelsAssembler!
    
    // MARK: - Private Properties
    
    private var filter: SWIngredientsFilter!
    
    private var _tipster: SWTipGenerator!
    
    private var _aligner: SWWheelsAligner!
    
    private var _ingredients: SWIngredientRepository!
    
    private var _blockings: SWBlockingRepository!
    
    private var _options: SWOptionRepository!
    
    private var _appState: SWAppStateRepository!
        
    var bases: SWAbstractWheelController!
    
    var fats: SWAbstractWheelController!
    
    var veggies: SWAbstractWheelController!
    
    var proteins: SWAbstractWheelController!
    
    var pointer: PointerController!
    
    var selected: [SWIngredient]!
    
    var options: OptionsController!
    
    var overlayTransitionContext: SWIngredientKinds?
    
    var selectionController: SWSelectionWheelProtocol!
    
    private var animationsHistory: [SWAnimationRecord] = []
    
    private var animations = Set<SWAnimationTypes>()
    
//    private var a: SWAnimationTypes = .;
    
    private let blockingAnimationsPerEvent: [SWAnimatableEvents : Set<SWAnimationTypes>] = [
        .onSelectionWheelSpotClick: SWAnimationTypes.All(),
        .onSelectionWheelSpinGesture: SWAnimationTypes.All(),
        .onWheelsCreateRandomSaladClick: SWAnimationTypes.All(),
        .onWheelMoveByPinClick : [
            .popingIngredientsAtSelectionWheel,
            .fetchingIngredientsIntoSelectionWheel,
            .movingIngredientCopiesToSelectionWheel,
            .movingAllWheels,
            .movingOneWheel
        ],
        .onAddIngredientByPinClick : [
            .popingIngredientsAtSelectionWheel,
            .fetchingIngredientsIntoSelectionWheel,
            .movingIngredientCopiesToSelectionWheel,
            .movingAllWheels
        ],
        .onChangeWheelsState: [
            .popingIngredientsAtSelectionWheel,
            .fetchingIngredientsIntoSelectionWheel,
            .movingIngredientCopiesToSelectionWheel,
            .movingAllWheels,
            .focusingWheel
        ],
        .onReplacingSelectionSpotByIngredientWheelMove: SWAnimationTypes.All()
    ]
    
    // MARK: - Subs
    
    var current: SWAbstractWheelController!
    
    var basesMark: UILabel!
    
    var fatsMark: UILabel!
    
    var veggiesMark: UILabel!
    
    var proteinsMark: UILabel!
    
    var rollButton: UIButton!
    
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
        
        if !self.couldAnimate(.onChangeWheelsState, sender: self) {
            return
        }
        
        self.onAnimationStart(.focusingWheel, sender: self)
        
        _decelerating = false
        
        let follow = { () -> Void in
            self.current = sender
            self.bases.state = state
            self.fats.state = state
            self.veggies.state = state
            self.proteins.state = state
            self.pointer.state = state
        }
        
        let showend = { (_: Bool) -> Void in
            self.onAnimationEnd(.focusingWheel, sender: self)
        }

        UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: follow, completion: showend)

        if let focused =  selectionController.getSelected().first(where: { $0 == sender.focused.asIngridient }) {
            selectionController.move(to: focused)
        }
        else {
            selectionController.moveToFirstOpen(of: sender.focused.asIngridient.kind)
        }
    }
    
    func onPinClick(_ sender: SWAbstractWheelController, of pin: PinView, at index: Int) -> Void {
        
        if !self.couldAnimate(.onWheelMoveByPinClick, sender: self) {
            return
        }
        
        if current.isLocked && current.focused.kind == pin.kind && current.index != index {
            shake(of: current, thoward: index > current.index ? 1 : -1)
        }
        else {
            self.onAnimationStart(.movingOneWheel, sender: self)
            let moveto = { () -> Void in
                sender.move(to: index)
            }
            let showend = { (_: Bool) -> Void in
                self.onAnimationEnd(.movingOneWheel, sender: self)
                if self.couldAnimate(.onAddIngredientByPinClick, sender: self) {
                    self.selectionController.push([pin])
                }
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
    
    // MARK: - UIGestureRegocnizerDelegate Methods
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !selectionController.contains(touch) && !options.opened
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
//                add([pin])
                selectionController.push([pin])
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
    
    // MARK: - Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _tipster = assembler.resolve()
        _ingredients = assembler.resolve()
        _blockings = assembler.resolve()
        _options = assembler.resolve()
        segues = assembler.resolve()
        _aligner = assembler.resolve()
        filter = assembler.resolve()
        _appState = assembler.resolve()
        
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

        do {
            let concreteSelectionController = SWSelectionWheelController()
            selectionController = concreteSelectionController
            concreteSelectionController.assembler = self.assembler.resolve(semaphor: self)
            concreteSelectionController.delegate = self
            let rectangle = CGRect(x: 0, y: 0, width: view.frame.width * 1.7, height: view.frame.width * 1.7)
            concreteSelectionController.view.frame = rectangle
            concreteSelectionController.view.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.height * 1.3)
            view.addSubview(concreteSelectionController.view)
            self.addChildViewController(concreteSelectionController)
            concreteSelectionController.didMove(toParentViewController: self)
            concreteSelectionController.alignSubviews()
        }
        
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
        
        do {
//            input = UITextField(frame: CGRect(origin: CGPoint(x: 0, y: 100), size: CGSize(width: 1000, height: 20)))
//            input.layer.borderColor = UIColor.black.cgColor
//            input.layer.borderWidth = 2
//            view.addSubview(input)

//            roll = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 120), size: CGSize(side: 20)))
//            roll.setTitleColor(UIColor.black, for: .normal)
//            roll.setTitle("*", for: .normal)
//            roll.addTarget(self, action: #selector(onDebug(_:)), for: .touchUpInside)
//            view.addSubview(roll)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if _appState.get().showWalkthrough {
            _appState.setShowWalkthrough(false)
            perform(segue: segues.getWheelsToWalkthrough())
        }
        
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
        self.animations.forEach({
            print("\($0)")
        })
        
//        perform(segue: segues.getWheelsToSubwheel())
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
        overlayTransitionContext = .unexpected
        perform(segue: segues.getWheelsToOverlay())
    }
    
    @IBAction func onToDressingClick(_ sender: UIButton) {
        overlayTransitionContext = .dressing
        perform(segue: segues.getWheelsToOverlay())
    }

    @IBAction func onToFruitsClick(_ sender: UIButton) {
        overlayTransitionContext = .fruits
        perform(segue: segues.getWheelsToOverlay())
    }
    
    @IBAction func onNextMenu(_ sender: Any) {

        if !self.couldAnimate(.onWheelsCreateRandomSaladClick, sender: self) {
            return
        }
        
        self.onAnimationStart(.movingAllWheels, sender: self)
        
        let base = getNew(of: .base, excluding: [])
        let fat = getNew(of: .fat, excluding: [])
        let veggy1 = getNew(of: .veggy, excluding: [])
        let veggy2 = getNew(of: .veggy, excluding: [veggy1.ingredient])
        let protein = getNew(of: .protein, excluding: [])
        
        let fruit = getNew(of: .fruits, excluding: [])
        let unexpected = getNew(of: .unexpected, excluding: [])
        let dressing = getNew(of: .dressing, excluding: [])
        let enhancer = [fruit, unexpected, dressing].random()!
        
        
        let shuffle1 = { () -> Void in
            base.move()
            fat.move()
            veggy1.move()
            protein.move()
        }
        
        let shuffle2 = { () -> Void in
            veggy2.move()
        }
        
        let select = { (_: Bool) -> Void in
            let focus: [Floatable] = [base.location, fat.location, veggy1.location, veggy2.location, protein.location, enhancer.location]
            self.selectionController.push(focus)
        }
        
        self.selectionController.clear()
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: shuffle1, completion: select)
        UIView.animate(withDuration: 0.5, delay: 1.5, options: [.curveEaseInOut], animations: shuffle2, completion: {
            (success: Bool) -> Void in
            self.onAnimationEnd(.movingAllWheels, sender: self)
        })
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
                    if self.couldAnimate(.onReplacingSelectionSpotByIngredientWheelMove, sender: self) {
                        self.selectionController.push(self.current.focused.asIngridient)
                    }
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
    
    private func setActiveState(to wheel: SWAbstractWheelController) -> Void {
        self.current = wheel
        self.bases.state = wheel.active
        self.fats.state = wheel.active
        self.veggies.state = wheel.active
        self.proteins.state = wheel.active
    }
    
    private func getWheel(of kind: SWIngredientKinds) -> SWAbstractWheelController? {
        switch kind {
        case .base:
            return self.bases
        case .fat:
            return self.fats
        case .veggy:
            return self.veggies
        case .protein:
            return self.proteins
        default:
            return nil
        }
    }
    
    private func getNew(of kind: SWIngredientKinds, excluding existing: [SWIngredient]) -> SWIngredientLocation {
        
        switch kind {
        case .base, .fat, .protein, .veggy:
            var wheel: SWAbstractWheelController!
            switch kind {
            case .base:
                wheel = bases
            case .fat:
                wheel = fats
            case .protein:
                wheel = proteins
            case .veggy:
                wheel = veggies
            default:
                fatalError("there is no wheel for kind \(kind)")
            }
            var random = wheel.count.random()
            for _ in 0..<wheel.count {
                if existing.first(where: { $0 == wheel.getIngredientAt(random) }) == nil {
                    break
                }
                random += 1
                if random == wheel.count {
                    random = 0
                }
            }
            return SWWheelIngredientLocation(ingredient: wheel.getIngredientAt(random)!, index: random, wheel: wheel, scene: view)
        case .dressing, .fruits, .unexpected:
            var button: UIButton!
            switch kind {
            case .dressing:
                button = self.toDressing
            case .fruits:
                button = self.toFruits
            case .unexpected:
                button = self.toUnexpected
            default:
                fatalError("there is no button for kind \(kind)")
            }
            let ingredients = filter.filterByOptionsAnd(by: kind)
            var random = ingredients.count.random()
            for _ in 0..<ingredients.count {
                if ingredients.first(where: { $0 == ingredients[random] }) == nil {
                    break
                }
                random += 1
                if random == ingredients.count {
                    random = 0
                }
            }
            return SWButtonIngredientLocation(ingredient: ingredients[random], button: button)
//        default:
//            fatalError("can not getNew(of:excluding:) for kind: \(kind)")
        }
    }
    
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
                    self.selectionController.push(self.current.focused.asIngridient)
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
        
        let filtered = selectionController.getSelected().filter({ (next) -> Bool in return ingredients[next.kind]!.first(where: { (n) -> Bool in return n == next } ) == nil })
        if filtered.count > 0 {
            selectionController.pop(filtered)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        // TODO: - pass assembler
        case segues.getWheelsToFilter().identifier?:
            let filter = segue.destination as? FilterViewController
            filter?.assembler = assembler.resolve()
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
                overlayViewController.prefocused = selectionController.getSelected().first(where: { $0.kind == self.overlayTransitionContext! })
            }
//        case segues.getWheelsToSubwheel().identifier?:
//            if let subwheel = segue.destination as? SubwheelViewController {
//                subwheel.assembler = assembler.resolve(using: self.view.snapshotView(afterScreenUpdates: true)!)
//            }
        case segues.getWheelsToWalkthrough().identifier?:
            print("WheelsToWalkthrough")
            if let walkthrough = segue.destination as? WalkthroughViewController {
                let midright = SWAreaOfInterest(center: self.rollButton.center, size: self.rollButton.frame.size)
                let topright = SWAreaOfInterest(center: CGPoint(x: view.frame.width - 37 * 0.5 - 8, y: 22 + 8), size: CGSize(width: 37, height: 44))
                let middle = SWAreaOfInterest(center: fats.focused.superview!.convert(fats.focused.center, to: view), size: fats.focused.frame.size)
                let edge = SWAreaOfInterest(center: toFruits.center, size: toUnexpected.frame.size)
                walkthrough.assembler = assembler.resolve(from: self, areas: SWAreasOfInterest(selectionWheel: selectionController.getWholeArea(), rollButton: midright, filtersButton: topright, cookButton: selectionController.getCookArea(), enhancer: edge, wheelIngredient: middle))
            }
        default:
            fatalError("Unrecognized segue")
        }
        
    }

}

extension WheelsViewController: SWSelectionWheelDelegate {
    
    // MARK: - SWSelectionWheelDelegate
    
    func onKindSwitched(from prev: SWIngredientKinds, to next: SWIngredientKinds) {
        if next == .base || next == .fat || next == .protein || next == .veggy {
            let follow = { () -> Void in
                let new = WState.map(next)
                switch new {
                case .bases:
                    self.current = self.bases
                case .fats:
                    self.current = self.fats
                case .proteins:
                    self.current = self.proteins
                case .veggies:
                    self.current = self.veggies
                }
                self.bases.state = new
                self.fats.state = new
                self.veggies.state = new
                self.proteins.state = new
                self.pointer.state = new
            }
            
            let showend = { (_: Bool) -> Void in }
            
            UIView.animate(withDuration: 0.225, delay: 0, options: [], animations: follow, completion: showend)
        }
    }
    
    func onCook() {
//        selected = selectionController.selected
        selected = selectionController.getSelected()
        perform(segue: segues.getWheelsToRecipy())
    }
    
    func onTriggerRandomIngredient(of kind: [SWIngredientKinds]) {
        if let kind = kind.random() {
            let location = getNew(of: kind, excluding: selectionController.getSelected())
            self.onAnimationStart(.movingOneWheel, sender: self)
            UIView.animate(withDuration: 0.225, animations: {
                location.move()
            }, completion: {
                (success) -> Void in
                self.onAnimationEnd(.movingOneWheel, sender: self)
                self.selectionController.push([location.location])
                UIView.animate(withDuration: 0.225, animations: {
                    self.setActiveState(to: self.getWheel(of: kind) ?? self.current)
                })
            })
        }
    }
    
}

extension WheelsViewController: SWAnimationSemaphor {
    
    
    func couldAnimate(_ event: SWAnimatableEvents, sender: Any) -> Bool {
        let current = animations.reduce("", { (current, next) -> String in
            return "\(current) \(next)"
        })
        print("\(current)")
        guard let blockings = self.blockingAnimationsPerEvent[event] else {
            fatalError("no blockings for couldAnimate(:sender:)")
        }
        return blockings.reduce(true, {
            (result, next) -> Bool in
            return result && !animations.contains(next)
        })
    }
    
    func onAnimationStart(_ type: SWAnimationTypes, sender: Any) {
        let new = SWAnimationRecord(of: type)
        animationsHistory.append(new)
        animations.insert(type)
    }
    
    func onAnimationEnd(_ type: SWAnimationTypes, sender: Any) {
        animationsHistory.reversed().first(where: { $0.type == type })?.endTime = Date()
        animations.remove(type)
    }
    
}

