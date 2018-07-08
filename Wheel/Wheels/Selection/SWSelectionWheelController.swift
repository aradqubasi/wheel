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
        }
    }
    
    private var count: SWCounts = SWCounts(
        leafs: SWRange(min: 1, max: 1, current: 0),
        fats: SWRange(min: 1, max: 1, current: 0),
        veggies: SWRange(min: 2, max: 3, current: 0),
        proteins: SWRange(min: 1, max: 1, current: 0),
        enhancers: SWRange(min: 1, max: 2, current: 0)
    )
    
    private var leafs: [Any] = []
    private var leafsToFats: Any!
    private var fats: [Any] = []
    private var fatsToVeggies: Any!
    private var veggies: [Any] = []
    private var veggiesToProteins: Any!
    private var proteins: [Any] = []
    private var proteinsToEnhancers: Any!
    private var enhancers: [Any] = []

    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //leafs
        for _ in 0..<count.leafs.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button)
            leafs.append(spot)
        }
        //leafs | fats
        do {
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
            leafsToFats = SWDelimeterSpot(icon: delimeter)
        }
        //fats
        for _ in 0..<count.fats.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button)
            fats.append(spot)
        }
        //fats | veggies
        do {
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
            fatsToVeggies = SWDelimeterSpot(icon: delimeter)
        }
        //veggies
        for _ in 0..<count.veggies.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button)
            veggies.append(spot)
        }
        //veggies | proteins
        do {
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
            veggiesToProteins = SWDelimeterSpot(icon: delimeter)
        }
        //proteins
        for _ in 0..<count.proteins.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button)
            proteins.append(spot)
        }
        //proteins | enhancers
        do {
            let delimeter = UIImageView(image: #imageLiteral(resourceName: "wheelgui/delimeter"))
            view.addSubview(delimeter)
            proteinsToEnhancers = SWDelimeterSpot(icon: delimeter)
        }
        //enhancers
        for _ in 0..<count.enhancers.max {
            let button = UIButton()
            view.addSubview(button)
            let spot = SWHiddenSpot(icon: button)
            enhancers.append(spot)
        }
        
//        alignSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    func alignSubviews() {
        
        view.shapeAsLayerView()
        
        let step = radius.pin * 2 / radius.wheel
        
        let separator = size.delimeter.width * 0.5 / radius.wheel
        
        let spacing = self.spacing / radius.wheel
        
        var subviews: [Any] = []
        subviews.append(contentsOf: leafs)
        subviews.append(leafsToFats)
        subviews.append(contentsOf: fats)
        subviews.append(fatsToVeggies)
        subviews.append(contentsOf: veggies)
        subviews.append(veggiesToProteins)
        subviews.append(contentsOf: proteins)
        subviews.append(proteins)
        subviews.append(contentsOf: enhancers)
        
        var current: CGFloat = 0
        
        for i in 0..<subviews.count {
            
            if let spot = subviews[i] as? SWHiddenSpot {
                spot.alignView(to: self.center)
                _ = spot.open(angle: -CGFloat.pi, radius: radius.spoke, rotation: current)
                current += step + spacing
            }
            else if let delimeter = subviews[i] as? SWDelimeterSpot {
                delimeter.alignView(to: self.center)
                delimeter.move(angle: -CGFloat.pi, radius: radius.spoke, rotation: current)
                current += separator + spacing
            }
        }
    }

}
