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
            return SWRadiuses(wheel: view.bounds.width * 0.5, pin: 42 * 0.5, spoke: view.bounds.width * 0.5 - 42 * 0.5 - 10, pointer: view.bounds.width * 0.5 - 10 - 42 - 10 - 7)
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

    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func alignSubviews() {
        
        view.shapeAsLayerView()
        
        var prevKind: SWIngredientKinds?
        
        for i in 0..<spots.count {
            
            if let spot = spots[i] as? SWHiddenSpot {
                if prevKind == nil || (prevKind != spot.kinds.first) {
                    spot.alignView(to: self.center)
                    spots[i] = spot.open()
                }
//                spot.alignView(to: self.center)
//                spots[i] = spot.open(angle: current, radius: radius.spoke)//.fill(with: getRandomIngredient())
//                current += step + spacing
                
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
        
        for i in 0..<spots.count {
            
            let spot = spots[i]
            
            if spot is SWHiddenSpot {
                //skip
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
                //skip
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
                hidden.alignView(to: self.center)
            }
            else if let openned = spot as? SWOpenSpot {
                openned.move(angle: current + rotation, radius: radius.spoke)
            }
            else if let filled = spot as? SWFilledSpot {
                filled.move(angle: current + rotation, radius: radius.spoke)
            }
            else if let delimeter = spot as? SWDelimeterSpot {
//                delimeter.alignView(to: self.center)
                delimeter.move(angle: current + rotation, radius: radius.spoke)
            }
        })
        
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
    
    
}

extension SWSelectionWheelController: SWSelectionWheelProtocol {
    
    // MARK: - SWSelectionWheelProtocol Protocol Methods

    func push(_ ingredient: SWIngredient) {
        if let focused = getSpotAtFront() as? SWOpenSpot  {
            replace(focused, with: focused.fill(with: ingredient))
            if let hidden = spots.first(where: { ($0 as? SWHiddenSpot)?.kinds.contains(ingredient.kind) ?? false }) as? SWHiddenSpot {
                replace(hidden, with: hidden.open())
                self.rotateSubviews(by: 0)
            }
        }
    }
    
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
