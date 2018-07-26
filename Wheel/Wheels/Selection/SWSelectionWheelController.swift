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
            let spot = SWHiddenSpot(icon: button, for: [.base])
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
            let spot = SWHiddenSpot(icon: button, for: [.fat])
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
            let spot = SWHiddenSpot(icon: button, for: [.veggy])
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
            let spot = SWHiddenSpot(icon: button, for: [.protein])
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
            let spot = SWHiddenSpot(icon: button, for: [.fruits, .dressing, .unexpected])
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
        self.view.addSubview(label)
        label.center = self.center
        label.alpha = 0
        label.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -radius.label)
        return label
    }
    
    func alignSubviews() {
        
        view.shapeAsLayerView()
        
        var prevKind: SWIngredientKinds?
        
        for i in 0..<spots.count {
            
            if let spot = spots[i] as? SWHiddenSpot {
                spot.alignView(to: self.center)
                if prevKind == nil || (prevKind != spot.kinds.first) {
                    spots[i] = spot.open(as: getLabel())
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
    
//    private func forEachSpot(do action: (_ spot: SWSelectionSpot,_ angle: CGFloat,_ index: Int) -> Void) {
//
//        let step = radius.pin * 2 / radius.wheel
//
//        let separator = size.delimeter.width / radius.wheel
//
//        let spacing = self.spacing / radius.wheel
//
//        var current: CGFloat = 0
//
//        for i in 0..<spots.count {
//
//            let spot = spots[i]
//
//            if spot is SWHiddenSpot {
//                //skip
//            }
//            else if spot is SWOpenSpot {
//                current += (step + spacing) * 0.5
//            }
//            else if spot is SWFilledSpot {
//                current += (step + spacing) * 0.5
//            }
//            else if spot is SWDelimeterSpot {
//                current += (separator + spacing) * 0.5
//            }
//
//            action(spot, current, i)
//
//            if spot is SWHiddenSpot {
//                //skip
//            }
//            else if spot is SWOpenSpot {
//                current += (step + spacing) * 0.5
//            }
//            else if spot is SWFilledSpot {
//                current += (step + spacing) * 0.5
//            }
//            else if spot is SWDelimeterSpot {
//                current += (separator + spacing) * 0.5
//            }
//        }
//    }
    
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
    
    func getRotateSubviewsSteps(rotation delta: CGFloat, steps: Int) -> [Int:[() -> Void]] {
        let rotation = max(getMinRotation(), min(getMaxRotation(), delta + self.rotation))
        
        var rotateSteps: [Int:[() -> Void]] = [:]
        
        forEachSpot(do: {
            (spot: SWSelectionSpot, current: CGFloat, index: Int) -> Void in
//            if let hidden = spot as? SWHiddenSpot {
//                hidden.move(angle: current + rotation, radius: radius.spoke)
//            }
//            else if let openned = spot as? SWOpenSpot {
//                openned.move(angle: current + rotation, radius: radius.spoke)
//                openned.label.alpha = getLabelAlpha(for: openned)
//            }
//            else if let filled = spot as? SWFilledSpot {
//                filled.move(angle: current + rotation, radius: radius.spoke)
//                filled.label.alpha = getLabelAlpha(for: filled)
//            }
//            else if let delimeter = spot as? SWDelimeterSpot {
//                delimeter.move(angle: current + rotation, radius: radius.spoke)
//            }
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
     var start: Date!
}

extension SWSelectionWheelController: SWSelectionWheelProtocol {
    
    // MARK: - SWSelectionWheelProtocol Protocol Methods
    
    func open(for kind: SWIngredientKinds) {
        if let hidden = spots.first(where: { ($0 as? SWHiddenSpot)?.kinds.contains(kind) ?? false }) as? SWHiddenSpot {
            replace(hidden, with: hidden.open(as: getLabel()))
            self.rotateSubviews(by: 0)
        }
    }
    
    func preopen(for kind: SWIngredientKinds) {
        if let hidden = spots.first(where: { ($0 as? SWHiddenSpot)?.kinds.contains(kind) ?? false }) as? SWHiddenSpot {
            replace(hidden, with: hidden.open(as: getLabel()))
        }
    }
    
    func postopen() {
        self.rotateSubviews(by: 0)
    }
    
    func insert(_ ingredient: SWIngredient) {
        if let focused = getSpotAtFront() as? SWOpenSpot  {
            replace(focused, with: focused.fill(with: ingredient))
        }
        self.rotateSubviews(by: 0)
    }

    func push(_ ingredient: SWIngredient) {
        if let focused = getSpotAtFront() as? SWOpenSpot  {
            replace(focused, with: focused.fill(with: ingredient))
            if let hidden = spots.first(where: { ($0 as? SWHiddenSpot)?.kinds.contains(ingredient.kind) ?? false }) as? SWHiddenSpot {
                replace(hidden, with: hidden.open(as: getLabel()))
                self.rotateSubviews(by: 0)
            }
        }
    }

    func push(_ floatable: Floatable) {
        let ingredient = floatable.asIngridient
        let initial = floatable.convert(.zero, to: view)
        let floatable = UIImageView(image: ingredient.image)
        floatable.frame.origin = initial
        view.addSubview(floatable)
        
        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [.beginFromCurrentState], animations: {
            let delta = self.getDeltaToFirstOf(ingredient.kind)
            for i in 0..<25 {
                UIView.addKeyframe(withRelativeStartTime: 0.01 * TimeInterval(i), relativeDuration: 0.04, animations: { self.rotateSubviews(by: delta * 0.04) })
            }
        }, completion: nil)
//        UIView.animate(withDuration: 0.25, animations: {
//            self.moveToFirstOf(ingredient.kind)
//        })
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            floatable.transform = CGAffineTransform.identity.translatedBy(x: self.center.x - floatable.center.x, y: self.center.y - floatable.center.y + -self.radius.spoke)
        }, completion: {
            (success) -> Void in
            floatable.removeFromSuperview()
            UIView.animate(withDuration: 0.25, animations: {
                self.push(ingredient)
            })
//            UIView.animate(withDuration: 0.25, animations: {
//                self.push(ingredient)
//            }, completion: {
//                (success) -> Void in
//                UIView.animate(withDuration: 0.25, animations: {
//                    self.moveToFirstOf(<#T##kind: SWIngredientKinds##SWIngredientKinds#>)
//                })
//            })
        })
//        UIView.animate(withDuration: 0.75, animations: {
//            floatable.transform = CGAffineTransform.identity.translatedBy(x: self.center.x - floatable.center.x, y: self.center.y - floatable.center.y + -self.radius.spoke)
//        }, completion: {
//            (success) -> Void in
//            floatable.removeFromSuperview()
//
//        })
    }
    
   
    
    func push(_ floatables: [Floatable]) {
        start = Date()
        pushTheVeggy(floatables, isfirst: true)
        pushTheWheel(floatables, isfirst: true)
    }
    
    private func pushTheVeggy(_ floatables: [Floatable], isfirst: Bool) {
        print("veggy circle start #\(floatables.count) \(Date().timeIntervalSince(start))")
        let first = floatables.sorted(by: {
            (prev, next) -> Bool in
            let prev = prev.asIngridient.kind
            let next = next.asIngridient.kind
            let rank: [SWIngredientKinds:Int] = [
                .fruits : 0,
                .dressing : 0,
                .unexpected : 0,
                .protein: 1,
                .veggy: 2,
                .fat: 3,
                .base: 4
            ]
            return rank[prev] ?? 0 >= rank[next] ?? 0
            //        }).reversed().first!
        }).first!
        
//        var images: [UII] = []
//        for floatable in floatables {
//            let
//        }
//
        let ingredient = first.asIngridient
        let initial = first.convert(.zero, to: view)
        let floatable = UIImageView(image: ingredient.image)
        floatable.frame.origin = initial
        view.addSubview(floatable)
        
        let three = CGPoint(x: self.center.x - floatable.center.x, y: self.center.y - floatable.center.y + -self.radius.spoke)

        UIView.animate(withDuration: 0.75, animations: {
            floatable.transform = CGAffineTransform.identity.translatedBy(x: three.x, y: three.y)
//            self.unseen.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi * 0.666)
        }, completion: {
            (success) -> Void in
            floatable.removeFromSuperview()
            print("veggy circle end #\(floatables.count) \(Date().timeIntervalSince(self.start))")
        })
        
        let shrouded = UIView(frame: CGRect(origin: .zero, size: CGSize(side: 10)))
        view.addSubview(shrouded)
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            shrouded.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi * 0.333)
        }, completion: {
            (success) -> Void in
            shrouded.removeFromSuperview()
            let remainings = floatables.filter({ $0.asIngridient != ingredient })
            if remainings.count != 0 {
                self.pushTheVeggy(remainings, isfirst: false)
            }
        })
        
//        UIView.animate(withDuration: 0.25, animations: {
//            self.unseen.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi * 0.666)
//        }, completion: {
//            (success) -> Void in
//            let remainings = floatables.filter({ $0.asIngridient != ingredient })
//            if remainings.count != 0 {
//                self.pushTheVeggy(remainings, isfirst: false)
//            }
//        })
    }
    
    private func pushTheWheel(_ floatables: [Floatable], isfirst: Bool) {
        print("wheel circle start #\(floatables.count) \(Date().timeIntervalSince(start))")
        let first = floatables.sorted(by: {
            (prev, next) -> Bool in
            let prev = prev.asIngridient.kind
            let next = next.asIngridient.kind
            let rank: [SWIngredientKinds:Int] = [
                .fruits : 0,
                .dressing : 0,
                .unexpected : 0,
                .protein: 1,
                .veggy: 2,
                .fat: 3,
                .base: 4
            ]
            return rank[prev] ?? 0 >= rank[next] ?? 0
            //        }).reversed().first!
        }).first!
        
        let ingredient = first.asIngridient
        let initial = first.convert(.zero, to: view)
        
        let unseen = UIView()
        view.addSubview(unseen)
        UIView.animateKeyframes(withDuration: isfirst ? 0.5 : 0.25, delay: 0, options: [], animations: {
            let delta = self.getDeltaToFirstOf(ingredient.kind)
            for i in 0..<25 {
                UIView.addKeyframe(withRelativeStartTime: 0.04 * TimeInterval(i), relativeDuration: 0.04, animations: { self.rotateSubviews(by: delta * 0.04) })
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
//                        self.invisible.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi * 0.333)
                        unseen.transform = CGAffineTransform.identity.rotated(by: 0.1 * CGFloat(i))
                    })
                }
            }, completion: {
                (success) -> Void in
                unseen.removeFromSuperview()
                print("wheel circle end #\(floatables.count) \(Date().timeIntervalSince(self.start))")
                self.insert(ingredient)
                let remainings = floatables.filter({ $0.asIngridient != ingredient })
                if remainings.count != 0 {
                    self.pushTheWheel(remainings, isfirst: false)
                }
            })
        })
    }
    
//    func push(_ floatables: [Floatable]) {
//        let first = floatables.sorted(by: {
//            (prev, next) -> Bool in
//            let prev = prev.asIngridient.kind
//            let next = next.asIngridient.kind
//            let rank: [SWIngredientKinds:Int] = [
//                .fruits : 0,
//                .dressing : 0,
//                .unexpected : 0,
//                .protein: 1,
//                .veggy: 2,
//                .fat: 3,
//                .base: 4
//            ]
//            return rank[prev] ?? 0 >= rank[next] ?? 0
////        }).reversed().first!
//        }).first!
//
//        let ingredient = first.asIngridient
//        let initial = first.convert(.zero, to: view)
//        let floatable = UIImageView(image: ingredient.image)
//        floatable.frame.origin = initial
//        view.addSubview(floatable)
//
//        let three = CGPoint(x: self.center.x - floatable.center.x, y: self.center.y - floatable.center.y + -self.radius.spoke)
//
//        UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
//            let delta = self.getDeltaToFirstOf(ingredient.kind)
//            for i in 0..<25 {
//                UIView.addKeyframe(withRelativeStartTime: 0.01 * TimeInterval(i), relativeDuration: 0.04, animations: { self.rotateSubviews(by: delta * 0.04) })
//            }
//        }, completion: {
//            (success) -> Void in
//            self.preopen(for: ingredient.kind)
//
//            UIView.animateKeyframes(withDuration: 0.25, delay: 0, options: [], animations: {
//                let steps = self.getRotateSubviewsSteps(rotation: 0, steps: 25)
//                for i in 0..<25 {
//                    UIView.addKeyframe(withRelativeStartTime: 0.01 * TimeInterval(i), relativeDuration: 0.04, animations: {
//                        let subStepAnimations = steps[i]!
//                        for j in 0..<subStepAnimations.count {
//                            let subStepAnimation = subStepAnimations[j]
//                            subStepAnimation()
//                        }
//                        self.invisible.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi * 0.333)
//                    })
//                }
//            }, completion: {
//                (success) -> Void in
//
//            })
//
//            UIView.animate(withDuration: 0.25, delay: 0.25, options: [], animations: {
//                self.invisible.transform = CGAffineTransform.identity.rotated(by: CGFloat.pi * 0.666)
//            }, completion: {
//                (success) -> Void in
//                floatable.removeFromSuperview()
//                self.insert(ingredient)
//                let remainings = floatables.filter({ $0.asIngridient != ingredient })
//                if remainings.count != 0 {
//                    self.push(remainings)
//                }
//            })
//        })
//        UIView.animate(withDuration: 0.75, animations: { floatable.transform = CGAffineTransform.identity.translatedBy(x: three.x, y: three.y) })
//    }
    
    
    func pop(_ ingredient: SWIngredient) {
        
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

}
