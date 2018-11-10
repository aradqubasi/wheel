//
//  DietViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class DietViewController: SWTransitioningViewController {
    
    var assembler: SWDietAssembler!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.segues = assembler.resolve()
        
        do {
            navigationItem.titleView = UILabel.dietTitle
            let back = UIBarButtonItem.back
            navigationItem.leftBarButtonItem = back
            back.action = #selector(onBackClick(sender:))
            back.target = self
        }
        
        do {
            self.swiper = SWDismissHistoryGestureRecognizer()
            self.view.addGestureRecognizer(self.swiper)
            self.swiper.addTarget(self, action: #selector(onSwipe(sender:)))
        }
        
        do {
            let proportions = (carbs: CGFloat(0.6), fats: CGFloat(0.2), proteins: CGFloat(0.2))
            
            let convert = {
                (_ proportion: (carbs: CGFloat, fats: CGFloat, proteins: CGFloat)) -> (fat: CGPoint, carbs: CGPoint, protein: CGPoint) in
                let base = CGFloat(0)
                let fat = CGPoint(x: base, y: CGFloat.pi * 2 * proportion.fats)
                let carbs = CGPoint(x: fat.y, y: CGFloat.pi * 2 * (1 - proportion.proteins))
                let protein = CGPoint(x: carbs.y, y: CGFloat.pi * 2)
                return (fat, carbs, protein)
            }

            let r = CGFloat(80)
            let R = CGFloat(100)
            
            let o = self.view.getBoundsCenter()
            
            let fats = (
                inner: (
                    path: UIBezierPath(),
                    angles: convert(proportions).fat,
                    radius: r,
                    center: o,
                    color: UIColor.yellowgreen
                ),
                outer: (
                    path: UIBezierPath(),
                    angles: convert(proportions).fat,
                    radius: R,
                    center: o,
                    color: UIColor.atlantis
                )
            )
            
            let proteins = (
                inner: (
                    path: UIBezierPath(),
                    angles: convert(proportions).protein,
                    radius: r,
                    center: o,
                    color: UIColor.kournikova
                ),
                outer: (
                    path: UIBezierPath(),
                    angles: convert(proportions).protein,
                    radius: R,
                    center: o,
                    color: UIColor.buttercup
                )
            )
            
            let carbs = (
                inner: (
                    path: UIBezierPath(),
                    angles: convert(proportions).carbs,
                    radius: r,
                    center: o,
                    color: UIColor.froly
                ),
                outer: (
                    path: UIBezierPath(),
                    angles: convert(proportions).carbs,
                    radius: R,
                    center: o,
                    color: UIColor.burntSienna
                )
            )
            
            let section = {
                (_ path: UIBezierPath, _ angles: CGPoint, _ radius: CGFloat, _ center: CGPoint) -> Void in
                path.move(to: center)
                path.addArc(withCenter: center, radius: radius, startAngle: angles.x, endAngle: angles.y, clockwise: angles.y > angles.x)
                path.addLine(to: center)
                path.close()
            }
            
            let fill = {
                (_ layer: CAShapeLayer, _ color: UIColor) -> Void in
                layer.fillColor = color.cgColor
            }
            
            let combine = {
                (
                    drawing: (_ path: UIBezierPath, _ angles: CGPoint, _ radius: CGFloat, _ center: CGPoint) -> Void,
                    painting: (_ layer: CAShapeLayer, _ color: UIColor) -> Void,
                    figure: (path: UIBezierPath, angles: CGPoint, radius: CGFloat, center: CGPoint, color: UIColor)
                ) -> CAShapeLayer in
                let sublayer = CAShapeLayer()
                drawing(figure.path, figure.angles, figure.radius, figure.center)
                sublayer.path = figure.path.cgPath
                painting(sublayer, figure.color)
                return sublayer
            }
            
            
            self.view.layer.addSublayer(combine(section, fill, fats.outer))
            self.view.layer.addSublayer(combine(section, fill, proteins.outer))
            self.view.layer.addSublayer(combine(section, fill, carbs.outer))
            
            self.view.layer.addSublayer(combine(section, fill, fats.inner))
            self.view.layer.addSublayer(combine(section, fill, proteins.inner))
            self.view.layer.addSublayer(combine(section, fill, carbs.inner))
        }
    }
    
}
