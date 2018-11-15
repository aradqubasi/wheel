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
    
    var spinner: UIPanGestureRecognizer!
    
    private var prev: (place: CGPoint, time: Date, nutrient: (code: Int, name: String))?
    
    private let nutrients = (
        fats: (
            code: 1,
            name: "fats"
        ),
        proteins: (
            code: 2,
            name: "proteins"
        ),
        carbohydrates: (
            code: 3,
            name: "carbohydrates"
        )
    )

    private var chart = (
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
        
        //gesture recognizer
        do {
            self.spinner = UIPanGestureRecognizer(target: self, action: #selector(onSpin(sender:)))
            self.view.addGestureRecognizer(self.spinner)
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
            self.drawChart()
        }
        
        do {
            
//            let animation = CABasicAnimation(keyPath: "path")
//            animation.fromValue = 0.0
//            animation.toValue = 1.0
//            animation.duration = 2.5
//            inner.add(animation, forKey: "drawLineAnimation")
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func onSpin(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            self.prev = (
                place: sender.location(in: self.view),
                time: Date(),
                nutrient: self.getNutrientBy(point: sender.location(in: self.view))
            )
        case .changed:
            var next = (
                place: sender.location(in: self.view),
                time: Date(),
                nutrient: self.getNutrientBy(point: sender.location(in: self.view))
            )
            if let prev = self.prev {
                
                let delta = getAngleBetweenPoints(prev.place, next.place, self.chart.center)
                let time = next.time.timeIntervalSince(prev.time)
                
                do {
                    if prev.nutrient.code != next.nutrient.code {
                        //claim
                        if prev.nutrient == nutrients.fats {
                            if delta.angle < 0 {
                                self.chart.angles.fats.start += delta.angle
                            }
                            else {
                                self.chart.angles.fats.end += delta.angle
                            }
                        }
                        else if prev.nutrient == nutrients.proteins {
                            if delta.angle < 0 {
                                self.chart.angles.proteins.start += delta.angle
                            }
                            else {
                                self.chart.angles.proteins.end += delta.angle
                            }
                        }
                        else if prev.nutrient == nutrients.carbohydrates {
                            if delta.angle < 0 {
                                self.chart.angles.carbohydrates.start += delta.angle
                            }
                            else {
                                self.chart.angles.carbohydrates.end += delta.angle
                            }
                        }
                        //release
                        if next.nutrient == nutrients.fats {
                            if delta.angle > 0 {
                                self.chart.angles.fats.start += delta.angle
                            }
                            else {
                                self.chart.angles.fats.end += delta.angle
                            }
                        }
                        else if next.nutrient == nutrients.proteins {
                            if delta.angle > 0 {
                                self.chart.angles.proteins.start += delta.angle
                            }
                            else {
                                self.chart.angles.proteins.end += delta.angle
                            }
                        }
                        else if next.nutrient == nutrients.carbohydrates {
                            if delta.angle > 0 {
                                self.chart.angles.carbohydrates.start += delta.angle
                            }
                            else {
                                self.chart.angles.carbohydrates.end += delta.angle
                            }
                        }
                        next.nutrient = prev.nutrient
                    }
                    
                    
                    
                    
                    self.drawChart()
                }
            }
            self.prev = next

        case .ended, .cancelled:
            self.prev = nil
        default:
            print("default")
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
    
    private func drawChart() {
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
    
    private func getAngleBetweenPoints(_ a: CGPoint, _ b: CGPoint, _ center: CGPoint) -> (angle: CGFloat, clockwise: Bool) {
        let u = CGPoint(x: a.x - center.x, y: a.y - center.y)
        let v = CGPoint(x: b.x - center.x, y: b.y - center.y)
        return getAngleBetweenVectors(u, v)
    }

    private func getAngleBetweenVectors(_ u: CGPoint, _ v: CGPoint) -> (angle: CGFloat, clockwise: Bool) {
        let ulength = (u.x.square() + u.y.square()).squareRoot()
        let vlength = (v.x.square() + v.y.square()).squareRoot()
        let cos = (u.x * v.x + u.y * v.y) / (ulength * vlength)
        let direction = (u.x * v.y - u.y * v.x).sign == .plus
        let delta = acos(min(cos, 1.0)) * (direction ? CGFloat(1.0) : CGFloat(-1.0))
        return (angle: delta, clockwise: direction)
    }
    
    private func normalize(angle: CGFloat) -> CGFloat {
        var normalized = angle
        while abs(normalized) > CGFloat.pi * 2 {
            normalized = (abs(normalized) - CGFloat.pi * 2) * (normalized.sign == .minus ? -1 : 1)
        }
        normalized = normalized < 0 ? CGFloat.pi * 2 - abs(normalized) : normalized
        return normalized
    }
    
    private func isInRange(_ angle: CGFloat, _ range: (start: CGFloat, end: CGFloat)) -> Bool {
        let angle = self.normalize(angle: angle)
        let start = self.normalize(angle: range.start)
        let end = self.normalize(angle: range.end)
        if start < end {
            return angle >= start && angle < end
        }
        else if start > end {
            return angle >= start || angle < end
        }
        else {
            return angle == start
        }
    }
    
    private func getNutrientBy(point: CGPoint) -> (code: Int, name: String) {
        let current = getAngleBetweenPoints(
            CGPoint(x: self.chart.center.x + CGFloat(100), y: self.chart.center.y),
            point,
            self.chart.center
            ).angle
        let checklist = [(
            nutrient: self.nutrients.fats,
            range: self.chart.angles.fats
            ), (
                nutrient: self.nutrients.proteins,
                range: self.chart.angles.proteins
            ), (
                nutrient: self.nutrients.carbohydrates,
                range: self.chart.angles.carbohydrates
            )
        ]
        var nutrient: (code: Int, name: String)?
        for check in checklist {
            if self.isInRange(current, check.range) {
                nutrient = check.nutrient
                break
            }
        }
        guard let result = nutrient else {
            fatalError("Could not determine nutrient")
        }
        return result
    }
//
//    private func claim(delta: CGFloat, by range: (start: CGFloat, end: CGFloat)) -> (start: CGFloat, end: CGFloat) {
//        return ()
//    }
}
