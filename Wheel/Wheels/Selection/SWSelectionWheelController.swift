//
//  SWSelectionWheelController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWSelectionWheelController: UIViewController {
    
    // MARK: - Private Classes
    
    private struct SWSpinerStats {
        let point: CGPoint
        let time: Date
    }
    
    private struct SWRadiuses {
        let wheel: CGFloat
        let pin: CGFloat
        let spoke: CGFloat
        let pointer: CGFloat
        let label: CGFloat
        let button: CGFloat
    }
    
    private struct SWSizes {
        let pin: CGSize
        let delimeter: CGSize
    }
    
    private struct SWRange {
        let min: Int
        let max: Int
        var current: Int
    }
    
    private struct SWCounts {
        let leafs: SWRange
        let fats: SWRange
        let veggies: SWRange
        let proteins: SWRange
        let enhancers: SWRange
    }
    
    // MARK: - Public Properties
    
    var delegate: SWSelectionWheelDelegate?
    
    var assembler: SWSelectionWheelAssembler!
    
    // MARK: - Private Properties
    
    private let rollTimeOfFirstOfManyIngredients: TimeInterval = 0.5
    
    private let rollTimeOfFollowingOfManyIngredients: TimeInterval = 0.25
    
    private let rollTimeOfOneIngredient: TimeInterval = 0
    
    private var radius: SWRadiuses {
        get {
            return SWRadiuses(wheel: view.bounds.width * 0.5, pin: 42 * 0.5, spoke: view.bounds.width * 0.5 - 42 * 0.5 - 10, pointer: view.bounds.width * 0.5 - 10 - 42 - 10 - 14 * 0.5, label: view.bounds.width * 0.5 - 10 - 42 - 10 - 14 - 10 - 14 * 0.5, button: view.bounds.width * 0.5 + 48 * 0.5 - 15)
        }
    }
    
    private var spacing: CGFloat {
        get {
            return 30
        }
    }
    
    private var size: SWSizes {
        get {
            return SWSizes(pin: CGSize(side: 42), delimeter: CGSize(width: 8, height: 30))
        }
    }
    
    private var center: CGPoint {
        get {
            return CGPoint(x: view.bounds.width * 0.5, y: view.bounds.height * 0.5)
        }
    }
    
    private var front: CGFloat {
        get {
            return CGFloat.top
        }
    }
    
    private var count: SWCounts = SWCounts(
        leafs: SWRange(min: 1, max: 1, current: 0),
        fats: SWRange(min: 1, max: 1, current: 0),
        veggies: SWRange(min: 2, max: 3, current: 0),
        proteins: SWRange(min: 1, max: 1, current: 0),
        enhancers: SWRange(min: 1, max: 2, current: 0)
    )
    
    private var spots: [SWSelectionSpot] = []
    
    private var spiner: UIPanGestureRecognizer!
    
    private var prev: SWSpinerStats?
    
    private var pointer: UIImageView!
    
    private var cook: SWCookingButton!
    
    private var tipController: SWTipController!
    
    private var tipGenerator: SWTipGenerator!
    
    private var prevFocusedKinds: SWIngredientKinds = .base

    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipController = assembler.resolve()
        tipController.orientation = .center
        
        tipGenerator = assembler.resolve()
        tipGenerator.leafs = count.leafs.min
        tipGenerator.veggies = count.veggies.min
        tipGenerator.fats = count.fats.min
        tipGenerator.proteins = count.proteins.min
        tipGenerator.enhancers = count.enhancers.min
        
        //pointer
        do {
            self.pointer = UIImageView(image: #imageLiteral(resourceName: "wheelgui/fingertop"))
            view.addSubview(pointer)
        }
        
        //leafs
        for _ in 0..<count.leafs.max {
//            let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 42)))
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, label: getLabel(), for: [.base])
            spots.append(spot)
        }
        //leafs | fats
        do {
//            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            let delimeter = UIView.selectionDelimeter
            view.addSubview(delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //fats
        for _ in 0..<count.fats.max {
            let button = UIButton()
            button.addTarget(self, action: #selector(onSpotClick(sender:)), for: .touchUpInside)
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, label: getLabel(), for: [.fat])
            spots.append(spot)
        }
        //fats | veggies
        do {
//            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            let delimeter = UIView.selectionDelimeter
            view.addSubview(delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //veggies
        for _ in 0..<count.veggies.max {
            let button = UIButton()
            button.addTarget(self, action: #selector(onSpotClick(sender:)), for: .touchUpInside)
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, label: getLabel(), for: [.veggy])
            spots.append(spot)
        }
        //veggies | proteins
        do {
//            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            let delimeter = UIView.selectionDelimeter
            view.addSubview(delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //proteins
        for _ in 0..<count.proteins.max {
            let button = UIButton()
            button.addTarget(self, action: #selector(onSpotClick(sender:)), for: .touchUpInside)
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, label: getLabel(), for: [.protein])
            spots.append(spot)
        }
        //proteins | enhancers
        do {
//            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            let delimeter = UIView.selectionDelimeter
            view.addSubview(delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //enhancers
        for _ in 0..<count.enhancers.max {
            let button = UIButton()
            button.addTarget(self, action: #selector(onSpotClick(sender:)), for: .touchUpInside)
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, label: getLabel(), for: [.fruits, .dressing, .unexpected])
            spots.append(spot)
        }
        
        //cook button
        do {
            cook = SWDisabledCookingButton.getInitialButton(into: view)
            cook.delegate = self
        }
        
        //gestures
        do {
            spiner = UIPanGestureRecognizer(target: self, action: #selector(onSpin(sender:)))
            view.addGestureRecognizer(spiner)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alignSubviews() {
        
        view.shapeAsSelectionWheelBackground()
        
        do {
            var prevKind: SWIngredientKinds?
            
            for i in 0..<spots.count {
                
                if let spot = spots[i] as? SWHiddenSpot {
                    spot.alignView(to: self.center, moveLabelUpBy: radius.label)
                    if prevKind == nil || (prevKind != spot.kinds.first) {
                        //                    spots[i] = spot.open(as: getLabel())
                        spots[i] = spot.open()
                    }
                    prevKind = spot.kinds.first
                }
                else if let delimeter = spots[i] as? SWDelimeterSpot {
                    delimeter.alignView(to: self.center)
                }
            }
        }
        
        do {
            pointer.center = self.center
            pointer.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -radius.pointer)
        }
        
        do {
            cook.container.center = self.center
            cook.container.transform = CGAffineTransform.identity.translatedBy(x: radius.button * cos(CGFloat.pi * -0.360), y: radius.button * sin(CGFloat.pi * -0.360))
        }
        
        rotateSubviews(by: 0)
    }
    
    // MARK: - Private Methods
    
    private var rotation: CGFloat = -CGFloat.pi
    
    @IBAction private func onSpin(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            prev = SWSpinerStats(point: sender.location(in: view), time: Date())
        case .changed:
            let next = SWSpinerStats(point: sender.location(in: view), time: Date())
            if let prev = self.prev {
                let ux = prev.point.x - center.x
                let uy = prev.point.y - center.y
                let ulength = (ux.square() + uy.square()).squareRoot()
                let vx = next.point.x - center.x
                let vy = next.point.y - center.y
                let vlength = (vx.square() + vy.square()).squareRoot()
                let cos = (ux * vx + uy * vy) / (ulength * vlength)
                let direction: CGFloat = (ux * vy - uy * vx).sign == .minus ? -1.0 : 1.0
                let delta = acos(min(cos, 1.0)) * direction
                
                let time = next.time.timeIntervalSince(prev.time)
                UIView.animate(withDuration: time, delay: 0, options: [.beginFromCurrentState], animations: { self.rotateSubviews(by: delta) }, completion: nil)
            }
            prev = next
            if let spot = getSpotAtFront() {
                if let next = spot.kinds.first, next != prevFocusedKinds {
                    delegate?.onKindSwitched(from: prevFocusedKinds, to: next)
                    prevFocusedKinds = next
                }
            }
        case .cancelled, .ended:
            UIView.animateKeyframes(withDuration: 0.225, delay: 0, options: [.beginFromCurrentState], animations: {
                let steps: Int = 10
                let step: Double = 1.0 / Double(steps)

                let dAngle: CGFloat = self.getDeltaToClosest() * CGFloat(step)
                print("getDeltaToClosest : \(self.getDeltaToClosest())")
                for i in 0..<steps {
                    UIView.addKeyframe(withRelativeStartTime: step * Double(i), relativeDuration: step, animations: { self.rotateSubviews(by: dAngle) })
                }
            }, completion: nil)
        default:
            prev = nil
        }
    }
    
    private func getLabel() -> UILabel {
        let label = UILabel.selectionWheelLabel
        self.view.addSubview(label)
        return label
    }
    
    /** forEachSpot(do action: (spot: SWSelectionSpot, angle: CGFloat, index: Int) -> Void) */
    private func forEachSpot(do action: (_ spot: SWSelectionSpot,_ angle: CGFloat,_ index: Int) -> Void) {
        
        let step = radius.pin * 2 / radius.wheel
        
        let separator = size.delimeter.width / radius.wheel
        
        let spacing = self.spacing / radius.wheel
        
        var current: CGFloat = 0
        
        var prevSpotKind: SWIngredientKinds = .dressing
        var skipAngleIncrease = false
//        var forceAngleIncrease = false

        for i in 0..<spots.count {
            
            let spot = spots[i]
            
            if skipAngleIncrease {
                if spot is SWDelimeterSpot {
                    current += (separator + spacing) * 0.5
                }
                
                action(spot, current, i)
                skipAngleIncrease = false
                
                if spot is SWDelimeterSpot {
                    current += (separator + spacing) * 0.5
                }
            }
            else {
                if spot is SWHiddenSpot {
                    //align to next non hidden spot of the same type
                    if prevSpotKind != spot.kinds.first {
                        current += (step + spacing) * 0.5
                    }
                }
                else if spot is SWOpenSpot {
                    current += (step + spacing) * 0.5
                }
                else if spot is SWFilledSpot {
                    current += (step + spacing) * 0.5
                }
                else if spot is SWDelimeterSpot {
                    current += (separator + spacing) * 0.5
                }
                
                action(spot, current, i)
                
                if spot is SWHiddenSpot {
                    //align to next non hidden spot of the same type
                    if prevSpotKind != spot.kinds.first {
                        current += (step + spacing) * 0.5
                        skipAngleIncrease = true
                    }
                    prevSpotKind = spot.kinds.first!
                }
                else if spot is SWOpenSpot {
                    current += (step + spacing) * 0.5
                    prevSpotKind = spot.kinds.first!
                }
                else if spot is SWFilledSpot {
                    current += (step + spacing) * 0.5
                    prevSpotKind = spot.kinds.first!
                }
                else if spot is SWDelimeterSpot {
                    current += (separator + spacing) * 0.5
                }
            }
        }
    }
    
    private func getSpotAngles() -> [CGFloat] {
        var angles: [CGFloat] = []
        forEachSpot(do: {
            (spot: SWSelectionSpot, current: CGFloat, index: Int) -> Void in
            if !(spot is SWDelimeterSpot) && !(spot is SWHiddenSpot) {
                angles.append(current)
            }
        })
        return angles
    }
    
    private func rotateSubviews(by delta: CGFloat) {
        rotation += delta
        rotation = max(getMinRotation(), min(getMaxRotation(), rotation))
        
        forEachSpot(do: {
            (spot: SWSelectionSpot, current: CGFloat, index: Int) -> Void in
            if let hidden = spot as? SWHiddenSpot {
                hidden.move(angle: current + rotation, radius: radius.spoke)
            }
            else if let openned = spot as? SWOpenSpot {
                openned.move(angle: current + rotation, radius: radius.spoke)
                openned.label.alpha = getLabelAlpha(for: openned)
            }
            else if let filled = spot as? SWFilledSpot {
                filled.move(angle: current + rotation, radius: radius.spoke)
                filled.label.alpha = getLabelAlpha(for: filled)
            }
            else if let delimeter = spot as? SWDelimeterSpot {
                delimeter.move(angle: current + rotation, radius: radius.spoke)
            }
        })
        
    }
    
    private func getRotateSubviewsSteps(rotation delta: CGFloat, steps: Int) -> [Int:[() -> Void]] {
        let rotation = max(getMinRotation(), min(getMaxRotation(), delta + self.rotation))
        
        var rotateSteps: [Int:[() -> Void]] = [:]
        
        forEachSpot(do: {
            (spot: SWSelectionSpot, current: CGFloat, index: Int) -> Void in
            let distance = (current + rotation) - spot.angle
            for index in 0..<steps {
                if rotateSteps[index] == nil {
                    rotateSteps[index] = []
                }
                let subRadius = self.radius.spoke
                let subRotation = distance / CGFloat(steps) * CGFloat(index) + spot.angle
                rotateSteps[index]?.append {
                    spot.move(angle: subRotation, radius: subRadius)
                    if let opened = spot as? SWOpenSpot {
                        opened.label.alpha = self.getLabelAlpha(for: opened)
                    }
                    if let filled = spot as? SWFilledSpot {
                        filled.label.alpha = self.getLabelAlpha(for: filled)
                    }
                }
            }
        })
        
        return rotateSteps
    }
    
    private func getMinRotation() -> CGFloat {
        return getSpotAngles().map({ front - $0 }).min() ?? 0
    }
    
    private func getMaxRotation() -> CGFloat {
        return getSpotAngles().map({ front - $0 }).max() ?? 0
    }
    
    private func getSpotAtFront() -> SWSelectionSpot? {
        var min = CGFloat.infinity
        var focused: SWSelectionSpot?
        forEachSpot(do: {
            (spot: SWSelectionSpot, current: CGFloat, index: Int) -> Void in
            
            let delta = front - (current + rotation)
            if spot is SWHiddenSpot {
                //skip
            }
            else if spot is SWOpenSpot && abs(min) >= abs(delta) {
                min = delta
                focused = spot
            }
            else if spot is SWFilledSpot && abs(min) >= abs(delta) {
                min = delta
                focused = spot
            }
            else if spot is SWDelimeterSpot {
                //skip
            }
        })
        return focused
    }

    private func replace(_ original: SWSelectionSpot, with new: SWSelectionSpot) {
        for i in 0..<spots.count {
            if spots[i].icon === new.icon {
                spots[i] = new
                break
            }
        }
    }
    
    private func turn(_ original: SWSelectionSpot, with new: SWSelectionSpot) {
        for i in 0..<spots.count {
            if spots[i].icon === original.icon {
                for j in 0..<spots.count {
                    if spots[j].icon === new.icon {
                        spots[i] = new
                        spots[j] = original
                        break
                    }
                }
                break
            }
        }
    }
    
    private func getRandomIngredient() -> SWIngredient {
        return (SWInmemoryIngredientRepository()).getAll().random()!
    }
    
    private func getLabelAlpha(for target: SWSelectionSpot) -> CGFloat {
        var prev: CGFloat?
        var base: CGFloat!
        var next: CGFloat?
        self.forEachSpot(do: {
            (spot, angle, index) -> Void in
            if spot is SWOpenSpot || spot is SWFilledSpot {
                if target.icon === spot.icon {
                    base = angle
                 }
                else {
                    if base == nil {
                        prev = angle
                    }
                    if base != nil && next == nil {
                        next = angle
                    }
                }
            }
        })
        let center = front - base
        let right = front - (prev ?? -CGFloat.infinity)
        let left = front - (next ?? CGFloat.infinity)
        var visibility = radius.pin / radius.spoke
        if rotation < center {
            visibility = abs(center - left) * 0.75
        }
        else if rotation > center {
            visibility = abs(center - right) * 0.75
        }
        else {
            return 1
        }
        let alpha = 1.0 - abs(center - rotation) / visibility
        return alpha
    }
    
    private func getDeltaToFirstOpenOf(_ kind: SWIngredientKinds) -> CGFloat? {
        let target = spots.first(where: {
            return ($0 as? SWOpenSpot)?.kinds.contains(kind) ?? false
        })
        if let target = target {
            var targetAngle: CGFloat?
            forEachSpot(do: {
                (spot, angle, index) -> Void in
                if spot.icon === target.icon {
                    targetAngle = angle
                }
            })
            if let targetAngle = targetAngle {
                return front - targetAngle - rotation
            }
        }
        return nil
    }
    
    private func getDeltaToFirstOf(_ kind: SWIngredientKinds) -> CGFloat {
        let target = spots.first(where: {
            return ($0 as? SWOpenSpot)?.kinds.contains(kind) ?? false || ($0 as? SWFilledSpot)?.kinds.contains(kind) ?? false
        })
        if let target = target {
            var targetAngle: CGFloat?
            forEachSpot(do: {
                (spot, angle, index) -> Void in
                if spot.icon === target.icon {
                    targetAngle = angle
                }
            })
            if let targetAngle = targetAngle {
                return front - targetAngle - rotation
//                rotateSubviews(by: delta)
                
            }
        }
        return 0
    }
    
    func getDeltaToClosest() -> CGFloat {
        var angles: [CGFloat] = []
        forEachSpot(do: {
            (spot, angle, index) -> Void in
            if spot is SWOpenSpot || spot is SWFilledSpot {
                angles.append(front - angle - rotation)
            }
        })
        return angles.reduce(CGFloat.infinity, { abs($0) > abs($1) ? $1 : $0 })
    }
    
    private func getRank(of ingredient: SWIngredient) -> Int {
        if ingredient.kind == .fruits {
            return 0
        }
        else if ingredient.kind == .dressing {
            return 0
        }
        else if ingredient.kind == .unexpected {
            return 0
        }
        else if ingredient.kind == .protein {
            return 1
        }
        else if ingredient.kind == .veggy {
            return 2
        }
        else if ingredient.kind == .fat {
            return 3
        }
        else if ingredient.kind == .base {
            return 4
        }
        return 0
    }
    
    private func sortAndFilter(_ ingredients: [SWIngredient]) -> [SWIngredient] {
        var enhancers = count.enhancers.max
        var leafs = count.leafs.max
        var fats = count.fats.max
        var proteins = count.proteins.max
        var veggies = count.veggies.max
        for spot in spots {
            if let filled = spot as? SWFilledSpot {
                if filled.kinds.first == .base {
                    leafs = leafs - 1
                }
                else if filled.kinds.first == .fat {
                    fats = fats - 1
                }
                else if filled.kinds.first == .veggy {
                    veggies = veggies - 1
                }
                else if filled.kinds.first == .protein {
                    proteins = proteins - 1
                }
                else {
                    enhancers = enhancers - 1
                }
            }
        }
        let result = ingredients.filter({
            if $0.kind == .base  {
                leafs = leafs - 1
                return leafs >= 0
            }
            else if $0.kind == .fat {
                fats = fats - 1
                return fats >= 0
            }
            else if $0.kind == .veggy  {
                veggies = veggies - 1
                return veggies >= 0
            }
            else if $0.kind == .protein {
                proteins = proteins - 1
                return proteins >= 0
            }
            else {
                enhancers = enhancers - 1
                return enhancers >= 0
            }
        }).sorted(by: {
            (prev, next) -> Bool in
            return getRank(of: prev) >= getRank(of: next)
        })
        return result
    }
    
    private func sortAndFilter(_ floatables: [Floatable]) -> [Floatable] {
        var result: [Floatable] = []
        sortAndFilter(floatables.map({
            return $0.asIngridient
        })).forEach({
            (ingredient) in
            result.append(floatables.first(where: {
                (next) -> Bool in
                return next.asIngridient == ingredient
            })!)
        })
        return result
    }
    
    private func preopen(for kind: SWIngredientKinds) -> Bool {
        if let hidden = spots.first(where: { ($0 as? SWHiddenSpot)?.kinds.contains(kind) ?? false }) as? SWHiddenSpot {
            let openned = hidden.open()
            replace(hidden, with: openned)
            return true
        }
        else {
            return false
        }
    }
    
    private func insert(_ ingredient: SWIngredient) {
        if let focused = getSpotAtFront() as? SWOpenSpot  {
            replace(focused, with: focused.fill(with: ingredient))
        }
        self.rotateSubviews(by: 0)
    }
    
    private func pushTheVeggy(_ floatables: [Floatable], isfirst: Bool) {
        //        print("veggy circle start #\(floatables.count) \(Date().timeIntervalSince(start))")
        let sorted = sortAndFilter(floatables)
        if sorted.count == 0 {
            return
        }
        let first = sorted.first!
        
        let ingredient = first.asIngridient
        let initial = first.convert(.zero, to: view)
        let floatable = UIImageView(image: ingredient.image)
        floatable.frame.origin = initial
        view.addSubview(floatable)
        
        let three = CGPoint(x: self.center.x - floatable.center.x, y: self.center.y - floatable.center.y + -self.radius.spoke)
        
        UIView.animate(withDuration: 0.85, delay: 0, options: [.curveEaseInOut], animations: {
            floatable.transform = CGAffineTransform.identity.translatedBy(x: three.x, y: three.y)
        }, completion: {
            (success) -> Void in
            floatable.removeFromSuperview()
            //            print("veggy circle end #\(sorted.count) \(Date().timeIntervalSince(self.start))")
        })
        
        
        let shrouded = UIView(frame: CGRect(origin: .zero, size: CGSize(side: 10)))
        view.addSubview(shrouded)
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            shrouded.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi * 0.333)
        }, completion: {
            (success) -> Void in
            shrouded.removeFromSuperview()
            let remainings = sorted.filter({ $0.asIngridient != ingredient })
            if remainings.count != 0 {
                self.pushTheVeggy(remainings, isfirst: false)
            }
        })
        
    }
    
    private func pushTheWheel(_ ingredients: [SWIngredient], rollTime: TimeInterval, shouldSkipOpening: Bool) {
        let sorted = sortAndFilter(ingredients)
        //        print("wheel circle start #\(sorted.count) \(Date().timeIntervalSince(start))")
        if sorted.count == 0 {
            return
        }
        let first = sorted.first!
        
        let ingredient = first
        
        let delta = self.getDeltaToFirstOpenOf(ingredient.kind)
        
        if delta == nil {
            return
        }
        
        let unseen = UIView()
        view.addSubview(unseen)
        UIView.animateKeyframes(withDuration: rollTime, delay: 0, options: [], animations: {
            for i in 0..<25 {
                UIView.addKeyframe(withRelativeStartTime: 0.04 * TimeInterval(i), relativeDuration: 0.04, animations: { self.rotateSubviews(by: delta! * 0.04) })
                unseen.transform = CGAffineTransform.identity.rotated(by: 0.1 * CGFloat(i))
            }
        }, completion: {
            (success) -> Void in
            let willOpenHidden = self.preopen(for: ingredient.kind)
            UIView.animateKeyframes(withDuration: (willOpenHidden && shouldSkipOpening) || !shouldSkipOpening ? 0.25 : 0, delay: 0, options: [], animations: {
                (self.getSpotAtFront() as? SWOpenSpot)?.dissolve()
                let steps = self.getRotateSubviewsSteps(rotation: 0, steps: 25)
                for i in 0..<25 {
                    UIView.addKeyframe(withRelativeStartTime: 0.04 * TimeInterval(i), relativeDuration: 0.04, animations: {
                        let subStepAnimations = steps[i]!
                        for j in 0..<subStepAnimations.count {
                            let subStepAnimation = subStepAnimations[j]
                            subStepAnimation()
                        }
                        unseen.transform = CGAffineTransform.identity.rotated(by: 0.1 * CGFloat(i))
                    })
                }
            }, completion: {
                (success) -> Void in
                unseen.removeFromSuperview()
                self.insert(ingredient)
                let remainings = sorted.filter({ $0 != ingredient })
                do {
                    UIView.animate(withDuration: 0.225) {
                        self.setCookingButtonState()
                    }
                }
                if remainings.count != 0 {
                    self.pushTheWheel(remainings, rollTime: self.rollTimeOfFollowingOfManyIngredients, shouldSkipOpening: shouldSkipOpening)
                }
            })
        })
    }
    
    private func setCookingButtonState() {
        var leafs: Int = 0
        var fats = 0
        var veggies = 0
        var proteins = 0
        var enhancers = 0
        for spot in spots {
            if !(spot is SWFilledSpot) {
                continue
            }
            if spot.kinds.first == .base {
                leafs += 1
            }
            else if spot.kinds.first == .fat {
                fats += 1
            }
            else if spot.kinds.first == .veggy {
                veggies += 1
            }
            else if spot.kinds.first == .protein {
                proteins += 1
            }
            else {
                enhancers += 1
            }
        }
        if leafs >= count.leafs.min && fats >= count.fats.min && veggies >= count.veggies.min && proteins >= count.proteins.min && enhancers >= count.enhancers.min {
            cook = (cook as? SWDisabledCookingButton)?.enable() ?? cook
        }
        else {
            cook = (cook as? SWEnabledCookingButton)?.disable() ?? cook
        }
    }
    
    private func popVeggies(_ ingredients: [SWIngredient]) {
        let ingredient = ingredients.first!
        do {
            self.tipController.unanimate()
            UIView.animate(withDuration: 0.225) {
                self.tipController.fade()
            }
        }
        let popped = spots.first(where: {
            if let filled = $0 as? SWFilledSpot {
                return filled.ingredient == ingredient
            }
            else {
                return false
            }
        })
        let related = spots.filter({ (spot) -> Bool in return spot.kinds.first(where: { (kind) -> Bool in return kind == ingredient.kind }) != nil })
        let firstOpenned = related.first(where: { $0 is SWOpenSpot })
        if let popped = popped as? SWFilledSpot {
            if related.count == 1 {
                replace(popped, with: popped.close())
                do {
                    UIView.animate(withDuration: 0.225) {
                        self.setCookingButtonState()
                    }
                }
                let remainings = ingredients.filter({ $0 != ingredient })
                if remainings.count != 0 {
                    self.popVeggies(remainings)
                }
            }
            else if related.count >= 1 {
                var poppedPositionFound = false
                for i in 0..<related.count {
                    if poppedPositionFound {
                        turn(popped, with: related[i])
                    }
                    if related[i].icon == popped.icon && !poppedPositionFound {
                        poppedPositionFound = true
                    }
                }
                replace(popped, with: firstOpenned != nil ? popped.close().hide() : popped.close())
                do {
                    UIView.animate(withDuration: 0.225) {
                        self.setCookingButtonState()
                    }
                }
                do {
                    let unseen = UIView()
                    UIView.animateKeyframes(withDuration: ingredients.count == 1 ? 0.25 : 0, delay: 0, options: [], animations: {
                        self.view.addSubview(unseen)
                        let steps = self.getRotateSubviewsSteps(rotation: 0, steps: 25)
                        for i in 0..<25 {
                            UIView.addKeyframe(withRelativeStartTime: 0.04 * TimeInterval(i), relativeDuration: 0.04, animations: {
                                let subStepAnimations = steps[i]!
                                for j in 0..<subStepAnimations.count {
                                    let subStepAnimation = subStepAnimations[j]
                                    subStepAnimation()
                                }
                                unseen.transform = CGAffineTransform.identity.rotated(by: 0.1 * CGFloat(i))
                            })
                        }
                    }, completion: {
                        (success: Bool) -> Void in
                        unseen.removeFromSuperview()
                        let remainings = ingredients.filter({ $0 != ingredient })
                        if remainings.count != 0 {
                            self.popVeggies(remainings)
                        }
                    })
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func onCookClick(sender: UIButton) -> Void {
        delegate?.onCook()
    }
    
    @IBAction private func onFoodClick(sender: FloatingSelectedView) {
//        delegate?.onRemove(of: sender, in: self)
    }
    
    @IBAction private func onSpotClick(sender: UIButton) {
        if let first = spots.first(where: { $0.icon == sender }) {
            if let filled = first as? SWFilledSpot {
                self.pop(filled.ingredient)
            }
            else if let open = first as? SWOpenSpot {
                self.delegate?.onTriggerRandomIngredient(of: open.kinds)
            }
        }
    }
}

extension SWSelectionWheelController: SWSelectionWheelProtocol {
    
    // MARK: - SWSelectionWheelProtocol Protocol Methods

    func push(_ ingredient: SWIngredient) {
        do {
            self.tipController.unanimate()
            UIView.animate(withDuration: 0.225) {
                self.tipController.fade()
            }
        }
        if getSpotAtFront() is SWOpenSpot {
            pushTheWheel([ingredient], rollTime: self.rollTimeOfOneIngredient, shouldSkipOpening: true)
        }
    }
    
    func push(_ floatables: [Floatable]) {
        do {
            self.tipController.unanimate()
            UIView.animate(withDuration: 0.225) {
                self.tipController.fade()
            }
        }
        pushTheVeggy(floatables, isfirst: true)
        pushTheWheel(floatables.map( { return $0.asIngridient } ), rollTime: self.rollTimeOfFirstOfManyIngredients, shouldSkipOpening: false)
    }
 
    func pop(_ ingredient: SWIngredient) {
        popVeggies([ingredient])
    }
    
    func getFocusedKind() -> [SWIngredientKinds] {
        var result: [SWIngredientKinds] = []
        if let focused = getSpotAtFront() as? SWOpenSpot {
            result.append(contentsOf: focused.kinds)
        }
        else if let focused = getSpotAtFront() as? SWFilledSpot {
            result.append(contentsOf: focused.kinds)
        }
        return result
    }
    
    func getFocusedIngredient() -> SWIngredient? {
        if let focused = getSpotAtFront() as? SWFilledSpot  {
            return focused.ingredient
        }
        return nil
    }
    
    func hideTip() {
        tipController.fade()
    }
    
    func clear() {
        let selected = getSelected()
        if selected.count > 0 {
            popVeggies(selected)
        }
    }
    
    func contains(_ touch: UITouch) -> Bool {
        return view.bounds.contains(touch.location(in: view))
    }
    
    func getSelected() -> [SWIngredient] {
        return spots.map({ $0 as? SWFilledSpot }).filter({ $0 != nil }).map({ $0!.ingredient })
    }
}

extension SWSelectionWheelController {
    
    func getStatus() -> Bool {
        return cook is SWEnabledCookingButton
    }
    
    func setStatus(_ enable: Bool) {
        if enable {
            cook = (cook as? SWDisabledCookingButton)?.enable() ?? cook
        }
        else {
            cook = (cook as? SWEnabledCookingButton)?.disable() ?? cook
        }
    }
}

extension SWSelectionWheelController: SWCookingButtonDelegate {
    
    func onCook(_ sender: SWCookingButton) {
        if sender is SWEnabledCookingButton {
            print("onCook(SWEnabledCookingButton)")
            delegate?.onCook()
        }
        if sender is SWDisabledCookingButton {
            let tip = tipGenerator.getTip(for: self.spots.filter({ return $0 is SWFilledSpot }).map({ return ($0 as! SWFilledSpot).ingredient }))
            
            let anchor = CGPoint(x: self.center.x, y: self.center.y - radius.wheel)
            tipController.show(tip: tip, at: anchor, in: view)
            
            tipController.shrink()
            let grow = { () -> Void in self.tipController.grow() }
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: grow, completion: nil)
            
            let fade = { () -> Void in self.tipController.fade() }
            UIView.animate(withDuration: 0.5, delay: 4, options: [.curveEaseOut], animations: fade, completion: nil)
        }
    }
    
}
