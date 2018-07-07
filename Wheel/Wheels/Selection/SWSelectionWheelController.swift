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
            return SWSizes(pin: CGSize(side: 42), delimeter: CGSize(width: 12, height: 42))
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
    
    private var leafs: [UIView] = []
    private var fats: [UIView] = []
    private var veggies: [UIView] = []
    private var proteins: [UIView] = []
    private var enhancers: [UIView] = []
    
    private var subviews: [UIButton] = []
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<32 {
            let button = UIButton()
            view.addSubview(button)
            subviews.append(button)
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
        
        let spacing = self.spacing / radius.wheel
        
        for i in 0..<32 {
//            let button = UIButton(frame: CGRect(origin: .zero, size: size.pin))
            let button = subviews[i]
            button.frame.size = size.pin
            button.center = self.center
            view.addSubview(button)
            let hiden = SWHiddenSpot(icon: button)
            let current = (step + spacing) * CGFloat(i)
            _ = hiden.open(angle: -CGFloat.pi, radius: radius.spoke, rotation: current)
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
