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
            return SWRadiuses(wheel: view.bounds.width * 0.5, pin: 42 * 0.5, spoke: view.bounds.width * 0.5 - 42 * 0.5 - 10)
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
//            return CGPoint(x: view.bounds.width * 0.5, y: view.bounds.height * 0)
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
    
//    private var spots: [Any] {
//        get {
//            var spots: [Any] = []
//            spots.append(contentsOf: leafs)
//            spots.append(leafsToFats)
//            spots.append(contentsOf: fats)
//            spots.append(fatsToVeggies)
//            spots.append(contentsOf: veggies)
//            spots.append(veggiesToProteins)
//            spots.append(contentsOf: proteins)
//            spots.append(proteins)
//            spots.append(contentsOf: enhancers)
//            return spots
//        }
//    }
    
    private var spots: [SWSelectionSpot] = []
    
//    private var leafs: [Any] = []
//    private var leafsToFats: Any!
//    private var fats: [Any] = []
//    private var fatsToVeggies: Any!
//    private var veggies: [Any] = []
//    private var veggiesToProteins: Any!
//    private var proteins: [Any] = []
//    private var proteinsToEnhancers: Any!
//    private var enhancers: [Any] = []
    
    private var spiner: UIPanGestureRecognizer!
    
    private var prev: SWSpinerStats?

    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //leafs
        for _ in 0..<count.leafs.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, for: [.base])
            spots.append(spot)
        }
        //leafs | fats
        do {
//            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
//            leafsToFats = SWDelimeterSpot(icon: delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //fats
        for _ in 0..<count.fats.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, for: [.fat])
//            fats.append(spot)
            spots.append(spot)
        }
        //fats | veggies
        do {
//            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
//            fatsToVeggies = SWDelimeterSpot(icon: delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //veggies
        for _ in 0..<count.veggies.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, for: [.veggy])
//            veggies.append(spot)
            spots.append(spot)
        }
        //veggies | proteins
        do {
//            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
//            veggiesToProteins = SWDelimeterSpot(icon: delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //proteins
        for _ in 0..<count.proteins.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, for: [.protein])
//            proteins.append(spot)
            spots.append(spot)
        }
        //proteins | enhancers
        do {
//            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
//            proteinsToEnhancers = SWDelimeterSpot(icon: delimeter)
            spots.append(SWDelimeterSpot(icon: delimeter))
        }
        //enhancers
        for _ in 0..<count.enhancers.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button, for: [.fruits, .dressing, .unexpected])
//            enhancers.append(spot)
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
                UIView.animate(withDuration: time, animations: {
                    self.rotateSubviews(by: delta)
                })
            }
            prev = next
        default:
            prev = nil
        }
    }
    
    func alignSubviews() {
        
        view.shapeAsLayerView()
        
        let step = radius.pin * 2 / radius.wheel
        
        let separator = size.delimeter.height / radius.wheel
        
        let spacing = self.spacing / radius.wheel

        var current: CGFloat = 0
        
        for i in 0..<spots.count {
            
            if let spot = spots[i] as? SWHiddenSpot {
                spot.alignView(to: self.center)
                spots[i] = spot.open(angle: current + front, radius: radius.spoke).fill(with: getRandomIngredient())
                current += step + spacing
            }
            else if let delimeter = spots[i] as? SWDelimeterSpot {
                delimeter.alignView(to: self.center)
                delimeter.move(angle: current + front, radius: radius.spoke)
                current += separator + spacing
            }
        }
    }
    
    /** forEachSpot(do action: (spot: SWSelectionSpot, angle: CGFloat, index: Int) -> Void) */
    private func forEachSpot(do action: (_ spot: SWSelectionSpot,_ angle: CGFloat,_ index: Int) -> Void) {
        
        let step = radius.pin * 2 / radius.wheel
        
        let separator = size.delimeter.width / radius.wheel
        
        let spacing = self.spacing / radius.wheel
        
        var current: CGFloat = 0
        
        for i in 0..<spots.count {
            
            let spot = spots[i]
            
            action(spot, current, i)
            
            if spot is SWHiddenSpot {
                current += step + spacing
            }
            else if spot is SWOpenSpot {
                current += step + spacing
            }
            else if spot is SWFilledSpot {
                current += step + spacing
            }
            else if spot is SWDelimeterSpot {
                current += separator + spacing
            }
        }
    }
    
    func rotateSubviews(by delta: CGFloat) {
        rotation += delta
        rotation = max(getMaxRotation(), min(getMaxRotation(), rotation))
        
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
                delimeter.alignView(to: self.center)
                delimeter.move(angle: current + rotation, radius: radius.spoke)
            }
        })
        
    }
    
    func getMinRotation() -> CGFloat {
        var angles: [CGFloat] = []
        forEachSpot(do: {
            (spot: SWSelectionSpot, current: CGFloat, index: Int) -> Void in
            angles.append(front - current)
        })
        return angles.min() ?? 0
    }
    
    func getMaxRotation() -> CGFloat {
        var angles: [CGFloat] = []
        forEachSpot(do: {
            (spot: SWSelectionSpot, current: CGFloat, index: Int) -> Void in
            angles.append(front - current)
        })
        return angles.max() ?? 0
    }
    
//    func getClosestSpot(to angle: CGFloat) -> [CGFloat] {
//
//    }
    
    func getRandomIngredient() -> SWIngredient {
        return (SWInmemoryIngredientRepository()).getAll().random()!
    }

}
