//
//  SWPieViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 11/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWPieViewController: UIViewController {
    
    // MARK: - Injection
    
    var settings: SWDietSettings!
    
    var assembler: SWPieAssembler!
    
    // MARK: - Dependencies
    
    // MARK: - Subviews
    
    var chart = (
        center: CGPoint.zero,
        inner: (
            radius: CGFloat(80),
            fats: (
                layer: CAShapeLayer(),
                color: UIColor.yellowgreen
            ),
            proteins: (
                layer: CAShapeLayer(),
                color: UIColor.kournikova
            ),
            carbohydrates: (
                layer: CAShapeLayer(),
                color: UIColor.froly
            )
        ),
        outer: (
            radius: CGFloat(100),
            fats: (
                layer: CAShapeLayer(),
                color: UIColor.atlantis
            ),
            proteins: (
                layer: CAShapeLayer(),
                color: UIColor.buttercup
            ),
            carbohydrates: (
                layer: CAShapeLayer(),
                color: UIColor.burntSienna
            )
        ),
        angles: (
            base: CGFloat(0),
            fats: (
                start: CGFloat(0),
                end: CGFloat.pi * 2
            ),
            proteins: (
                start: CGFloat(0),
                end: CGFloat.pi * 2
            ),
            carbohydrates: (
                start: CGFloat(0),
                end: CGFloat.pi * 2
            )
        )
    )
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layers = [
            self.chart.outer.fats,
            self.chart.outer.proteins,
            self.chart.outer.carbohydrates,
            self.chart.inner.fats,
            self.chart.inner.proteins,
            self.chart.inner.carbohydrates
        ]
        //painting
        do {
            layers.forEach({
                $0.layer.fillColor = $0.color.cgColor
            })
        }
        
        //attach
        do {
            layers.forEach({
                self.view.layer.addSublayer($0.layer)
            })
        }
    }
    
    func alignSubviews() {

        
        //angles
        do {
            let calculated = self.convertToAngles(base: 0, shares: (
                fats: self.settings.fatsDailyShare,
                proteins: self.settings.proteinsDailyShare,
                carbohydrates: self.settings.carbohydratesDailyShare
            ))
            self.chart.angles.fats = calculated.fats
            self.chart.angles.proteins = calculated.proteins
            self.chart.angles.carbohydrates = calculated.carbohydrates
        }
        
        //draw
        do {
            self.chart.center = self.view.getBoundsCenter()
            let layers = [
                (layer: self.chart.inner.fats.layer, angles: self.chart.angles.fats, radius: self.chart.inner.radius, center: self.chart.center),
                (layer: self.chart.inner.proteins.layer, angles: self.chart.angles.proteins, radius: self.chart.inner.radius, center: self.chart.center),
                (layer: self.chart.inner.carbohydrates.layer, angles: self.chart.angles.carbohydrates, radius: self.chart.inner.radius, center: self.chart.center),
                (layer: self.chart.outer.fats.layer, angles: self.chart.angles.fats, radius: self.chart.outer.radius, center: self.chart.center),
                (layer: self.chart.outer.proteins.layer, angles: self.chart.angles.proteins, radius: self.chart.outer.radius, center: self.chart.center),
                (layer: self.chart.outer.carbohydrates.layer, angles: self.chart.angles.carbohydrates, radius: self.chart.outer.radius, center: self.chart.center)
            ]
            layers.forEach({
                $0.layer.path = self.drawSection($0.angles, $0.radius, $0.center).cgPath
            })
        }
        
        do {
            
//            let animation = CABasicAnimation(keyPath: "path")
//            animation.fromValue = 0.0
//            animation.toValue = 1.0
//            animation.duration = 2.5
//            inner.add(animation, forKey: "drawLineAnimation")
        }
    }
    
    // MARK: - Private Methods
    
    private func convertToAngles(base: CGFloat, shares: (fats: Double, proteins: Double, carbohydrates: Double)) -> (base: CGFloat, fats: (start: CGFloat, end: CGFloat), proteins: (start: CGFloat, end: CGFloat), carbohydrates: (start: CGFloat, end: CGFloat)) {
        let result = (
            base: base,
            fats: (start: base, end: base + CGFloat.pi * 2 * CGFloat(shares.fats)),
            proteins: (start: base + CGFloat.pi * 2 * CGFloat(shares.fats + shares.carbohydrates), end: base + CGFloat.pi * 2 * CGFloat(shares.fats + shares.carbohydrates + shares.proteins)),
            carbohydrates: (start: base + CGFloat.pi * 2 * CGFloat(shares.fats), end: base + CGFloat.pi * 2 * CGFloat(shares.fats + shares.carbohydrates))
        )
        return result
    }
    
    private func convertToShares(angles: (base: CGFloat, fats: (start: CGFloat, end: CGFloat), proteins: (start: CGFloat, end: CGFloat), carbohydrates: (start: CGFloat, end: CGFloat))) -> (fats: Double, proteins: Double, carbohydrates: Double) {
        let result = (
            fats: Double((angles.fats.end - angles.fats.start) / CGFloat.pi),
            proteins: Double((angles.proteins.end - angles.proteins.start) / CGFloat.pi),
            carbohydrates: Double((angles.carbohydrates.end - angles.carbohydrates.start) / CGFloat.pi)
        )
        return result
    }
    
    private func drawSection(_ angles: (start: CGFloat, end: CGFloat), _ radius: CGFloat, _ center: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: angles.start, endAngle: angles.end, clockwise: true)
        path.addLine(to: center)
        path.close()
        return path
    }

}
