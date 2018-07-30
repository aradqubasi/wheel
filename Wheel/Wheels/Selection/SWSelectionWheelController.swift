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
    
    // MARK: - SWSpot
    
    
    
    // MARK: - Private Properties
    
    private var radius: SWRadiuses {
        get {
            return SWRadiuses(wheel: view.bounds.width * 0.5, pin: 42 * 0.5, spoke: view.bounds.width * 0.5 - 42 * 0.5 - 10, pointer: view.bounds.width * 0.5 - 10 - 42 - 10 - 14 * 0.5, label: view.bounds.width * 0.5 - 10 - 42 - 10 - 14 - 10 - 14 * 0.5)
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
    
    private var labels: [UILabel] = []
    
    private var invisible: UIView!
    
    private var unseen: UIView!

    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        do {
//            let line = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 1000)))
//            line.backgroundColor = .red
//            view.addSubview(line)
//            line.center = self.center
//        }
        
        do {
            invisible = UIView()
            view.addSubview(invisible)
            
            unseen = UIView(frame: CGRect(origin: .zero, size: CGSize(side: 10)))
            view.addSubview(unseen)
        }
        
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
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //fats
        for _ in 0..<count.fats.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, label: getLabel(), for: [.fat])
            spots.append(spot)
        }
        //fats | veggies
        do {
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //veggies
        for _ in 0..<count.veggies.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, label: getLabel(), for: [.veggy])
            spots.append(spot)
        }
        //veggies | proteins
        do {
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //proteins
        for _ in 0..<count.proteins.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, label: getLabel(), for: [.protein])
            spots.append(spot)
        }
        //proteins | enhancers
        do {
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //enhancers
        for _ in 0..<count.enhancers.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, label: getLabel(), for: [.fruits, .dressing, .unexpected])
            spots.append(spot)
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
    
    // MARK: - Private Methods
    
    var rotation: CGFloat = -CGFloat.pi
    
    @IBAction func onSpin(sender: UIPanGestureRecognizer) {
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
        case .cancelled, .ended:
            UIView.animateKeyframes(withDuration: 0.225, delay: 0, options: [.beginFromCurrentState], animations: {
                let steps: Int = 12
                let forward: Int = 10
                let backward: Int = 2
                let dTime: TimeInterval = TimeInterval(1 / steps)
                let dAngle: CGFloat = self.getDeltaToClosestSpot() / CGFloat(forward)
                for i in 0..<forward {
                    UIView.addKeyframe(withRelativeStartTime: dTime * TimeInterval(i), relativeDuration: dTime, animations: { self.rotateSubviews(by: dAngle) })
                }
                for i in 0..<backward {
                    UIView.addKeyframe(withRelativeStartTime: dTime * TimeInterval(i), relativeDuration: dTime, animations: { self.rotateSubviews(by: -dAngle) })
                }
            }, completion: nil)
        default:
            prev = nil
        }
    }
    
    func getLabel() -> UILabel {
        let label = UILabel.selectionWheelLabel
//        label.backgroundColor = .red
        self.view.addSubview(label)
//        label.center = self.center
//        label.alpha = 0
//        label.frame = CGRect(origin: CGPoint(x: -112.5, y: 0), size: CGSize(width: 600, height: 14))
//        label.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -radius.label)
        return label
    }
    
    func alignSubviews() {
        
        view.shapeAsLayerView()
        
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
        
        pointer.center = self.center
        pointer.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -radius.pointer)
        
        rotateSubviews(by: 0)
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
    
    func getSpotAngles() -> [CGFloat] {
        var angles: [CGFloat] = []
        forEachSpot(do: {
            (spot: SWSelectionSpot, current: CGFloat, index: Int) -> Void in
            if !(spot is SWDelimeterSpot) && !(spot is SWHiddenSpot) {
                angles.append(current)
            }
        })
        return angles
    }
    
    func rotateSubviews(by delta: CGFloat) {
        rotation += delta
        rotation = max(getMinRotation(), min(getMaxRotation(), rotation))
        
        forEachSpot(do: {
            (spot: SWSelectionSpot, current: CGFloat, index: Int) -> Void in
            if let hidden = spot as? SWHiddenSpot {
                hidden.move(angle: current + rotation, radius: radius.spoke)
//                print("SWHiddenSpot \(hidden.label.alpha) \(hidden.label.frame) \(hidden.label.text ?? "")")
            }
            else if let openned = spot as? SWOpenSpot {
                openned.move(angle: current + rotation, radius: radius.spoke)
                openned.label.alpha = getLabelAlpha(for: openned)
//                print("SWOpenSpot \(openned.label.alpha) \(openned.label.frame) \(openned.label.text ?? "")")
            }
            else if let filled = spot as? SWFilledSpot {
                filled.move(angle: current + rotation, radius: radius.spoke)
                filled.label.alpha = getLabelAlpha(for: filled)
//                print("SWFilledSpot \(filled.label.alpha) \(filled.label.frame) \(filled.label.text ?? "")")
            }
            else if let delimeter = spot as? SWDelimeterSpot {
                delimeter.move(angle: current + rotation, radius: radius.spoke)
            }
        })
        
    }
    
    func getRotateSubviewsSteps(rotation delta: CGFloat, steps: Int) -> [Int:[() -> Void]] {
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
                }
            }
        })
        
        return rotateSteps
    }
    
    func getMinRotation() -> CGFloat {
        return getSpotAngles().map({ front - $0 }).min() ?? 0
    }
    
    func getMaxRotation() -> CGFloat {
        return getSpotAngles().map({ front - $0 }).max() ?? 0
    }
    
    func getDeltaToClosestSpot() -> CGFloat {
        return getSpotAngles().map({
            return front - ($0 + rotation)
        }).reduce(CGFloat.infinity, {
            (result: CGFloat, next: CGFloat) -> CGFloat in
            return abs(result) > abs(next) ? next : result
        })
    }
    
    func getSpotAtFront() -> SWSelectionSpot? {
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

    func replace(_ original: SWSelectionSpot, with new: SWSelectionSpot) {
        for i in 0..<spots.count {
            if spots[i].icon === new.icon {
                spots[i] = new
                break
            }
        }
    }
    
    func turn(_ original: SWSelectionSpot, with new: SWSelectionSpot) {
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
    
    func getRandomIngredient() -> SWIngredient {
        return (SWInmemoryIngredientRepository()).getAll().random()!
    }
    
    func getLabelAlpha(for target: SWSelectionSpot) -> CGFloat {
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
    
    func getDeltaToFirstOpenOf(_ kind: SWIngredientKinds) -> CGFloat? {
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
    
    func getDeltaToFirstOf(_ kind: SWIngredientKinds) -> CGFloat {
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
    
     var start: Date!
}

extension SWSelectionWheelController: SWSelectionWheelProtocol {
    
    // MARK: - SWSelectionWheelProtocol Protocol Methods
    
 
    func preopen(for kind: SWIngredientKinds) {
        if let hidden = spots.first(where: { ($0 as? SWHiddenSpot)?.kinds.contains(kind) ?? false }) as? SWHiddenSpot {
//            replace(hidden, with: hidden.open(as: getLabel()))
            replace(hidden, with: hidden.open())
        }
    }

    
    func insert(_ ingredient: SWIngredient) {
        if let focused = getSpotAtFront() as? SWOpenSpot  {
            replace(focused, with: focused.fill(with: ingredient))
        }
        self.rotateSubviews(by: 0)
    }

    
    func push(_ ingredient: SWIngredient) {
        start = Date()
        if getSpotAtFront() is SWOpenSpot {
            pushTheWheel([ingredient], isfirst: false)
        }
    }

    func push(_ floatable: Floatable) {
        
        push([floatable])
    }
    
   
    
    func push(_ floatables: [Floatable]) {
        start = Date()
        pushTheVeggy(floatables, isfirst: true)
        pushTheWheel(floatables.map( { return $0.asIngridient } ), isfirst: true)
    }
    
    private func pushTheVeggy(_ floatables: [Floatable], isfirst: Bool) {
        print("veggy circle start #\(floatables.count) \(Date().timeIntervalSince(start))")
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

        UIView.animate(withDuration: 0.75, delay: 0, options: [.curveEaseInOut], animations: {
            floatable.transform = CGAffineTransform.identity.translatedBy(x: three.x, y: three.y)
        }, completion: {
            (success) -> Void in
            floatable.removeFromSuperview()
            print("veggy circle end #\(sorted.count) \(Date().timeIntervalSince(self.start))")
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
    
    private func pushTheWheel(_ ingredients: [SWIngredient], isfirst: Bool) {
        let sorted = sortAndFilter(ingredients)
        print("wheel circle start #\(sorted.count) \(Date().timeIntervalSince(start))")
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
        UIView.animateKeyframes(withDuration: isfirst ? 0.5 : 0.25, delay: 0, options: [], animations: {
            for i in 0..<25 {
                UIView.addKeyframe(withRelativeStartTime: 0.04 * TimeInterval(i), relativeDuration: 0.04, animations: { self.rotateSubviews(by: delta! * 0.04) })
                unseen.transform = CGAffineTransform.identity.rotated(by: 0.1 * CGFloat(i))
            }
        }, completion: {
            (success) -> Void in
            self.preopen(for: ingredient.kind)
            
            UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
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
                print("wheel circle end #\(sorted.count) \(Date().timeIntervalSince(self.start))")
                self.insert(ingredient)
                let remainings = sorted.filter({ $0 != ingredient })
                if remainings.count != 0 {
                    self.pushTheWheel(remainings, isfirst: false)
                }
            })
        })
    }
    
    
    func pop(_ ingredient: SWIngredient) {
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
        let firstHidden = related.first(where: { $0 is SWHiddenSpot })
        let lastFilled = related.first(where: { $0 is SWFilledSpot && $0.icon != popped?.icon })
        if let popped = popped as? SWFilledSpot {
            if related.count == 1 {
                replace(popped, with: popped.close())
            }
            else if related.count >= 1 && firstOpenned != nil {
                var poppedPositionFound = false
                for i in 0..<related.count {
                    if poppedPositionFound {
                        turn(popped, with: related[i])
                    }
                    if related[i].icon == popped.icon && !poppedPositionFound {
                        poppedPositionFound = true
                    }
                }
                replace(popped, with: popped.close().hide())
                rotateSubviews(by: 0)
            }
            else if related.count >= 1 && firstOpenned == nil {
                var poppedPositionFound = false
                for i in 0..<related.count {
                    if poppedPositionFound {
                        turn(popped, with: related[i])
                    }
                    if related[i].icon == popped.icon && !poppedPositionFound {
                        poppedPositionFound = true
                    }
                }
                replace(popped, with: popped.close())
                rotateSubviews(by: 0)
            }
        }
        for spot in spots {
            if let label = (spot as? SWLabeledSelectionSpot)?.label {
                print("\(label.text ?? "empty") \(label.alpha)")
            }
        }
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

}
