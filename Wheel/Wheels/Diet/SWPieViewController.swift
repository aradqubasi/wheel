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
    
    var settingsVm: SWDietSettingsViewModel?
    
    var assembler: SWPieAssembler!
    
    var radius: CGFloat!
    
    // MARK: - Dependencies
    
    // MARK: - Subviews
    
    private var shareDrawer: Timer!
    
    private var captionDrawer: Timer!
    
    var spinner: UIPanGestureRecognizer!
    
    private var prev: (
        place: CGPoint,
        time: Date,
        nutrient: (code: Int, name: String),
        angles: (
            base: CGFloat,
            fats: SWAngularRange,
            proteins: SWAngularRange,
            carbohydrates: SWAngularRange))?
    
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
        min: 0.05,
        center: CGPoint.zero,
        inner: (
            view: UIView(),
            radius: CGFloat(0),//CGFloat(130),
            fats: (
                layer: CAShapeLayer(),
//                color: UIColor.curiousBlue
                color: UIColor.yellowgreen
            ),
            proteins: (
                layer: CAShapeLayer(),
//                color: UIColor.coral
                color: UIColor.kournikova
            ),
            carbohydrates: (
                layer: CAShapeLayer(),
//                color: UIColor.amaranth
                color: UIColor.froly
            )
        ),
        outer: (
            view: UIView(),
            radius: CGFloat(0),//CGFloat(150),
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
            fats: SWAngularRange(start: CGFloat(0), end: CGFloat.pi * 2),
            proteins: SWAngularRange(start: CGFloat(0), end: CGFloat.pi * 2),
            carbohydrates: SWAngularRange(start: CGFloat(0), end: CGFloat.pi * 2)
        ),
        marks: (
            view: UIView(),
            radius: CGFloat(0),//CGFloat(100),
            fats: (
                wrapper: UIView(),
                target: (
                    value: Double(0),
                    angle: CGFloat(0)
                ),
                current: (
                    value: Double(0),
                    angle: CGFloat(0)
                ),
                label: UILabel(),
                caption: (
                    chars: [UILabel()],
                    wrapper: UIView()
                )
            ),
            proteins: (
                wrapper: UIView(),
                target: (
                    value: Double(0),
                    angle: CGFloat(0)
                ),
                current: (
                    value: Double(0),
                    angle: CGFloat(0)
                ),
                label: UILabel(),
                caption: (
                    chars: [UILabel()],
                    wrapper: UIView()
                )
            ),
            carbohydrates: (
                wrapper: UIView(),
                target: (
                    value: Double(0),
                    angle: CGFloat(0)
                ),
                current: (
                    value: Double(0),
                    angle: CGFloat(0)
                ),
                label: UILabel(),
                caption: (
                    chars: [UILabel()],
                    wrapper: UIView()
                )
            )
        )
    )
    
    // MARK: - Access Properties
    
    private var subviews: [UIView] {
        get {
            return [
                self.chart.outer.view,
                self.chart.inner.view,
                self.chart.marks.view,
                self.chart.marks.fats.caption.wrapper,
                self.chart.marks.proteins.caption.wrapper,
                self.chart.marks.carbohydrates.caption.wrapper
            ]
        }
    }
    
    private var labels: [(wrapper: UIView, label: UILabel)] {
        get {
            return [
                (wrapper: self.chart.marks.fats.wrapper, label: self.chart.marks.fats.label),
                (wrapper: self.chart.marks.proteins.wrapper, label: self.chart.marks.proteins.label),
                (wrapper: self.chart.marks.carbohydrates.wrapper, label: self.chart.marks.carbohydrates.label)
            ]
        }
    }
    
    private var captions: [(nutrient: (code: Int, name: String), wrapper: UIView, get: () -> [UILabel], set: ([UILabel]) -> Void, values: (current: (value: Double, angle: CGFloat), target: (value: Double, angle: CGFloat)))] {
        get {
            return [
                (nutrient: self.nutrients.fats, wrapper: self.chart.marks.fats.caption.wrapper, get: { () -> [UILabel] in return self.chart.marks.fats.caption.chars }, set: { (_ chars: [UILabel]) in self.chart.marks.fats.caption.chars = chars }, values: (current: self.chart.marks.fats.current, target: self.chart.marks.fats.target)),
                (nutrient: self.nutrients.proteins, wrapper: self.chart.marks.proteins.caption.wrapper, get: { () -> [UILabel] in return self.chart.marks.proteins.caption.chars }, set: { (_ chars: [UILabel]) in self.chart.marks.proteins.caption.chars = chars }, values: (current: self.chart.marks.proteins.current, target: self.chart.marks.proteins.target)),
                (nutrient: self.nutrients.carbohydrates, wrapper: self.chart.marks.carbohydrates.caption.wrapper, get: { () -> [UILabel] in return self.chart.marks.carbohydrates.caption.chars }, set: { (_ chars: [UILabel]) in self.chart.marks.carbohydrates.caption.chars = chars }, values: (current: self.chart.marks.carbohydrates.current, target: self.chart.marks.carbohydrates.target))
            ]
        }
    }
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        self.chart.marks.radius = self.radius - 50
        self.chart.outer.radius = self.radius
        self.chart.inner.radius = self.radius - 20
        
        let outer = [
            self.chart.outer.fats,
            self.chart.outer.proteins,
            self.chart.outer.carbohydrates
        ]
        let inner = [
            self.chart.inner.fats,
            self.chart.inner.proteins,
            self.chart.inner.carbohydrates
        ]
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
            inner.forEach({
                self.chart.inner.view.layer.addSublayer($0.layer)
            })
            outer.forEach({
                self.chart.outer.view.layer.addSublayer($0.layer)
            })
            self.subviews.forEach({
                self.view.addSubview($0)
            })
            self.labels.forEach({
                self.chart.marks.view.addSubview($0.wrapper)
                $0.wrapper.addSubview($0.label)
            })
            self.captions.forEach({
                self.view.addSubview($0.wrapper)
                var labels: [UILabel] = []
                for char in $0.nutrient.name.reversed() {
                    let char = NSAttributedString(string: String(char)).whitify().avenirLightify(14)
                    let label = UILabel(frame: CGRect(origin: .zero, size: char.size()))
                    label.attributedText = char
                    $0.wrapper.addSubview(label)
                    labels.append(label)
                }
                $0.set(labels)
            })
        }
        
        //gesture recognizer
        do {
            self.spinner = UIPanGestureRecognizer(target: self, action: #selector(onSpin(sender:)))
            self.view.addGestureRecognizer(self.spinner)
        }
        
        //debug
//        do {
//            let button = UIButton(frame: CGRect(origin: CGPoint(x: 20, y: 60), size: CGSize(side: 30)))
//            button.setTitle("*", for: .normal)
//            button.addTarget(self, action: #selector(onDebug(sender:)), for: .touchUpInside)
//            self.view.addSubview(button)
//        }
    }
    
    func alignSubviews() {
        print("alignSubviews")
        do {
            self.subviews.forEach({
                $0.frame = self.view.bounds
                $0.center = self.view.getBoundsCenter()
            })
        }
        
        do {
            self.labels.forEach({
                $0.wrapper.frame = CGRect(origin: .zero, size: NSAttributedString(string: "88%").avenirLightify(17).whitify().size())
                $0.wrapper.center = self.view.getBoundsCenter()
                $0.label.center = $0.wrapper.getBoundsCenter()
            })
        }
        
        do {
            self.captions.forEach({
                let chars = $0.get()
                $0.wrapper.frame = self.view.bounds
                for char in chars {
                    char.center = $0.wrapper.getBoundsCenter()
                }
            })
        }
        
        //angles
        do {
            if let settingsVm = self.settingsVm {
                self.chart.angles.fats = SWAngularRange(start: settingsVm.fatsStartAngle, end: settingsVm.fatsEndAngle)
                self.chart.angles.proteins = SWAngularRange(start: settingsVm.proteinStartAngle, end: settingsVm.proteinEndAngle)
                self.chart.angles.carbohydrates = SWAngularRange(start: settingsVm.carbohydratesStartAngle, end: settingsVm.carbohydratesEndAngle)
            }
            else {
                let calculated = self.convertToAngles(base: 0, shares: (
                    fats: self.settings.fatsDailyShare,
                    proteins: self.settings.proteinsDailyShare,
                    carbohydrates: self.settings.carbohydratesDailyShare
                ))
                self.chart.angles.fats = calculated.fats
                self.chart.angles.proteins = calculated.proteins
                self.chart.angles.carbohydrates = calculated.carbohydrates
                let settingsVm = SWDietSettingsViewModel(id: self.settings.id, fatsStartAngle: self.chart.angles.fats.start, fatsEndAngle: self.chart.angles.fats.end, proteinStartAngle: self.chart.angles.proteins.start, proteinEndAngle: self.chart.angles.proteins.end, carbohydratesStartAngle: self.chart.angles.carbohydrates.start, carbohydratesEndAngle: self.chart.angles.carbohydrates.end)
                self.settingsVm = settingsVm
            }
        }
        
        //draw
        do {
            self.chart.center = self.view.getBoundsCenter()
            self.drawChart()

            drawShares()
            
            drawCaption()
            
        }
        
        do {
//            let animation = CABasicAnimation(keyPath: "path")
//            animation.fromValue = 0.0
//            animation.toValue = 1.0
//            animation.duration = 2.5
//            inner.add(animation, forKey: "drawLineAnimation")
        }
    }
    
    // MARK: - Finalize
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.shareDrawer?.invalidate()
        self.captionDrawer?.invalidate()
    }
    
    // MARK: - Animation Methods
    
    func hide() {
        self.subviews.forEach({
            $0.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
            $0.alpha = 0
        })
    }
    
    func appear() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
            self.subviews.forEach({
                $0.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                $0.alpha = 1
            })
        }, completion: {
            (complete: Bool) -> Void in
            
            self.shareDrawer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {
                _ in
                self.drawShares()
            })
            
            self.captionDrawer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {
                _ in
                self.drawCaption()
            })
            
        })
    }
    
    // MARK: - Actions
    
    private var counter = 1
    
    @IBAction private func onDebug(sender: Any) {
        self.hide()
        if counter % 2 == 0 {
            self.appear()
        }
        else {
            self.appear()
        }
        counter += 1
    }
    
    @IBAction private func onSpin(sender: UIPanGestureRecognizer) {
//        print("\(Date())")
        switch sender.state {
        case .began:
            self.prev = (
                place: sender.location(in: self.view),
                time: Date(),
                nutrient: self.getNutrientBy(point: sender.location(in: self.view)),
                angles: self.chart.angles
            )
        case .changed:
            var next = (
                place: sender.location(in: self.view),
                time: Date(),
                nutrient: self.getNutrientBy(point: sender.location(in: self.view)),
                angles: self.chart.angles
            )
            
            let edge = self.getClosestEdge(to: next.place)
//            print("\(Date()) \(edge.from.name) | \(edge.to.name)")

            if let prev = self.prev {
                
                let delta = getAngleBetweenPoints(prev.place, next.place, self.chart.center)
                
                do {
                    let claims = [(
                            from: self.nutrients.fats,
                            to: self.nutrients.carbohydrates,
                            perform: {
                                (_ delta: CGFloat) -> Void in
                                self.chart.angles.fats = SWAngularRange(start: self.chart.angles.fats.start, end: self.chart.angles.fats.end + delta)
                                self.chart.angles.carbohydrates = SWAngularRange(start: self.chart.angles.carbohydrates.start + delta, end: self.chart.angles.carbohydrates.end)
                            }
                        ), (
                            from: self.nutrients.carbohydrates,
                            to: self.nutrients.proteins,
                            perform: {
                                (_ delta: CGFloat) -> Void in
                                self.chart.angles.carbohydrates = SWAngularRange(start: self.chart.angles.carbohydrates.start, end: self.chart.angles.carbohydrates.end + delta)
                                self.chart.angles.proteins = SWAngularRange(start: self.chart.angles.proteins.start + delta, end: self.chart.angles.proteins.end)
                            }
                        ), (
                            from: self.nutrients.proteins,
                            to: self.nutrients.fats,
                            perform: {
                                (_ delta: CGFloat) -> Void in
                                self.chart.angles.proteins = SWAngularRange(start: self.chart.angles.proteins.start, end: self.chart.angles.proteins.end + delta)
//                                self.chart.angles.proteins.end += delta
                                self.chart.angles.fats = SWAngularRange(start: self.chart.angles.fats.start + delta, end: self.chart.angles.fats.end)
//                                self.chart.angles.fats.start += delta
                            }
                        )
                    ]
                    guard let claim = claims.first(where: {
                        return $0.from.code == edge.from.code && $0.to.code == edge.to.code || $0.from.code == edge.to.code && $0.to.code == edge.from.code
                    }) else {
                        fatalError("Cannot find claim for edge \(edge) among claims \(claims)")
                    }
                    claim.perform(delta.angle)
                    let nextShares = self.convertToShares(angles: [self.chart.angles.fats, self.chart.angles.proteins, self.chart.angles.carbohydrates])
                    if [nextShares[0], nextShares[1], nextShares[2]].contains(where: { $0 < self.chart.min }) {
                        next.angles = prev.angles
                    }
                    else {
                        next.angles = self.chart.angles
                    }
                    self.chart.angles = next.angles
                    self.drawChart()
                    
                    //save
                    do {
                        if var settingsVm = self.settingsVm {
                            settingsVm.fatsStartAngle = self.chart.angles.fats.start
                            settingsVm.fatsEndAngle = self.chart.angles.fats.end
                            settingsVm.proteinStartAngle = self.chart.angles.proteins.start
                            settingsVm.proteinEndAngle = self.chart.angles.proteins.end
                            settingsVm.carbohydratesStartAngle = self.chart.angles.carbohydrates.start
                            settingsVm.carbohydratesEndAngle = self.chart.angles.carbohydrates.end
                            self.settingsVm = settingsVm
                        }
                        let shares = self.convertToShares(angles: [self.chart.angles.fats, self.chart.angles.proteins, self.chart.angles.carbohydrates])
                        self.settings.fatsDailyShare = shares[0]
                        self.settings.proteinsDailyShare = shares[1]
                        self.settings.carbohydratesDailyShare = shares[2]
                    }
                    
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
    
    private func convertToAngles(base: CGFloat, shares: (fats: Double, proteins: Double, carbohydrates: Double)) -> (base: CGFloat, fats: SWAngularRange, proteins: SWAngularRange, carbohydrates: SWAngularRange) {
        let result = (
            base: base,
            fats: SWAngularRange(start: base, end: base + CGFloat.pi * 2 * CGFloat(shares.fats)),
            proteins: SWAngularRange(start: base + CGFloat.pi * 2 * CGFloat(shares.fats + shares.carbohydrates), end: base + CGFloat.pi * 2 * CGFloat(shares.fats + shares.carbohydrates + shares.proteins)),
            carbohydrates: SWAngularRange(start: base + CGFloat.pi * 2 * CGFloat(shares.fats), end: base + CGFloat.pi * 2 * CGFloat(shares.fats + shares.carbohydrates))
        )
        return result
    }
    
    private func convertToShares(angles: [SWAngularRange]) -> [Double] {
        return angles.map({ Double(($0.end - $0.start) / (CGFloat.pi * 2)) })
    }
    
    private func drawSection(_ angles: SWAngularRange, _ radius: CGFloat, _ center: CGPoint) -> UIBezierPath {
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
        
        let shares = self.convertToShares(angles: [self.chart.angles.fats, self.chart.angles.proteins, self.chart.angles.carbohydrates])
        let marks = [(
            share: shares[0],
            mark: self.chart.marks.fats,
            angles: self.chart.angles.fats,
            radius: self.chart.marks.radius,
            set: {
                (_ share: Double, _ angle: CGFloat) in
                self.chart.marks.fats.target.value = share
                self.chart.marks.fats.target.angle = angle
                
        }), (
            share: shares[1],
            mark: self.chart.marks.proteins,
            angles: self.chart.angles.proteins,
            radius: self.chart.marks.radius,
            set: {
                (_ share: Double, _ angle: CGFloat) in
                self.chart.marks.proteins.target.value = share
                self.chart.marks.proteins.target.angle = angle
                
        }), (
            share: shares[2],
            mark: self.chart.marks.carbohydrates,
            angles: self.chart.angles.carbohydrates,
            radius: self.chart.marks.radius,
            set: {
                (_ share: Double, _ angle: CGFloat) in
                self.chart.marks.carbohydrates.target.value = share
                self.chart.marks.carbohydrates.target.angle = angle
        })]
        
        marks.forEach({
            let angle = self.getMiddleOf($0.angles)
            $0.set($0.share, angle)
            $0.mark.wrapper.transform = CGAffineTransform.identity.translatedBy(x: $0.radius * cos(angle), y: $0.radius * sin(angle))
//            $0.mark.caption.wrapper.transform = CGAffineTransform.identity.rotated(by: angle)
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
    
    private func getAngleAtCircle(with center: CGPoint, for point: CGPoint) -> CGFloat {
        let angle = getAngleBetweenPoints(
            CGPoint(x: center.x + CGFloat(100), y: center.y),
            point,
            center
            ).angle
        return angle
    }
    
    private func normalize(angle: CGFloat) -> CGFloat {
        var normalized = angle
        while abs(normalized) > CGFloat.pi * 2 {
            normalized = (abs(normalized) - CGFloat.pi * 2) * (normalized.sign == .minus ? -1 : 1)
        }
        normalized = normalized < 0 ? CGFloat.pi * 2 - abs(normalized) : normalized
        return normalized
    }
    
    private func getMiddleOf(_ range: SWAngularRange) -> CGFloat {
        let start = self.normalize(angle: range.start)
        var end = self.normalize(angle: range.end)
        if end < start {
            end += CGFloat.pi * 2
        }
        return (start + end) * 0.5
    }
    
    private func getClosestEdge(to point: CGPoint) -> (from: (code: Int, name: String), to: (code: Int, name: String)) {
        let angle = self.getAngleAtCircle(with: self.chart.center, for: point)
        let edges = [(
                edge: (from: self.nutrients.fats, to: self.nutrients.carbohydrates),
                range: SWAngularRange(start: self.getMiddleOf(self.chart.angles.fats), end: self.getMiddleOf(self.chart.angles.carbohydrates))
            ), (
                edge: (from: self.nutrients.carbohydrates, to: self.nutrients.proteins),
                range: SWAngularRange(start: self.getMiddleOf(self.chart.angles.carbohydrates), end: self.getMiddleOf(self.chart.angles.proteins))
            ), (
                edge: (from: self.nutrients.proteins, to: self.nutrients.fats),
                range: SWAngularRange(start: self.getMiddleOf(self.chart.angles.proteins), end: self.getMiddleOf(self.chart.angles.fats))
            )
        ]
        
        guard let edge = edges.first(where: {
            if self.isInRange(angle, $0.range) {
                return true
            }
            else {
                return false
            }
        })?.edge else {
            fatalError("Cannot find edge for point \(point)")
        }
        return edge
    }
    
    private func isInRange(_ angle: CGFloat, _ range: SWAngularRange) -> Bool {
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
        let current = getAngleAtCircle(with: self.chart.center, for: point)
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
    
    private func getPiString(_ angle: CGFloat) -> String {
        return String(format: "%.3f", Double(angle / CGFloat.pi))
    }
    
    private func getCircularPositions(of shapes: [CGSize], at radius: CGFloat) -> [CGFloat] {
        let spacing: CGFloat = 1 / radius
        var angle: CGFloat = -spacing
        var positions: [CGFloat] = []
        for shape in shapes {
            angle += spacing
            let halfprofile = shape.width / radius * 0.5
            angle += halfprofile
            positions.append(angle)
            angle += halfprofile
        }
        let offset = angle * 0.5 + CGFloat.pi * 0.5
        positions = positions.map({ $0 - offset })
        return positions
    }
    
    private func alignCaption(_ caption: (nutrient: (code: Int, name: String), wrapper: UIView, get: () -> [UILabel], set: ([UILabel]) -> Void, values: (current: (value: Double, angle: CGFloat), target: (value: Double, angle: CGFloat))), _ radius: CGFloat) {
        let chars = caption.get()
        chars
            .zip(with: getCircularPositions(of: chars.map({ $0.attributedText!.size() }), at: radius), as: {
                (char: UILabel, angle: CGFloat) -> (char: UILabel, angle: CGFloat) in
                return (char, angle)
            })
            .forEach({
                $0.char.transform = CGAffineTransform.identity.rotated(by: $0.angle).translatedBy(x: 0, y: radius)
            })
    }
    
    private func drawShares() {
        let marks = [
            (get: {
                () -> (wrapper: UIView, target: (value: Double, angle: CGFloat), current: (value: Double, angle: CGFloat), label: UILabel, caption: (chars: [UILabel], wrapper: UIView)) in
                self.chart.marks.fats
            }, set: {
                (_ value: Double) -> Void in
                self.chart.marks.fats.current = (value: value, angle: self.chart.marks.fats.current.angle)
            }),
            (get: {
                () -> (wrapper: UIView, target: (value: Double, angle: CGFloat), current: (value: Double, angle: CGFloat), label: UILabel, caption: (chars: [UILabel], wrapper: UIView)) in
                self.chart.marks.proteins
            }, set: {
                (_ value: Double) -> Void in
                self.chart.marks.proteins.current = (value: value, angle: self.chart.marks.proteins.current.angle)
            }),
            (get: {
                () -> (wrapper: UIView, target: (value: Double, angle: CGFloat), current: (value: Double, angle: CGFloat), label: UILabel, caption: (chars: [UILabel], wrapper: UIView)) in
                self.chart.marks.carbohydrates
            }, set: {
                (_ value: Double) -> Void in
                self.chart.marks.carbohydrates.current = (value: value, angle: self.chart.marks.carbohydrates.current.angle)
            })
        ]
        var leftover: Int = 0
        marks.forEach({
            let formatted = Int($0.get().target.value * 100)
            leftover += formatted
            $0.set(Double(formatted))
        })
        var sorted = marks.sorted(by: {
            (prev, next) -> Bool in
            return (prev.get().target.value - Double(Int(prev.get().target.value))) > (next.get().target.value - Double(Int(next.get().target.value)))
        })
        if leftover != 100 {
            for _ in 0..<100 - leftover {
                let closest = sorted.first!
                closest.set(closest.get().current.value + 1.0)
                sorted = sorted.filter({ $0.get().label != closest.get().label })
            }
        }
        marks.forEach({
            let new = $0.get().current.value
            let text = NSAttributedString(string: String(Int(new)) + "%").avenirLightify(17).whitify()
            $0.get().label.frame.size = text.size()
            $0.get().label.attributedText = text
            $0.get().label.center = $0.get().wrapper.getBoundsCenter()
        })
    }
    
    private func drawCaption() {
        let base = (self.chart.outer.radius + self.chart.inner.radius) * 0.5
        let overflow = self.chart.outer.radius * 1.5 - self.chart.inner.radius * 0.5
        var criticals: [Double] = []
        let captions = self.captions
        for caption in captions {
            let positions = self
                .getCircularPositions(
                    of: caption.get().map({ $0.bounds.size }),
                    at: base)
            let critical = Double((positions.last! - positions.first!) / (CGFloat.pi * 2))
            criticals.append(critical)
        }
        let angles = [
            self.chart.angles.fats,
            self.chart.angles.proteins,
            self.chart.angles.carbohydrates
        ]
        for i in 0..<captions.count {
            let caption = captions[i]
            let critical = criticals[i]
            var adjusted: CGFloat = 0
            if caption.values.target.value <= critical {
                let prev = i == 0 ? captions.count - 1 : i - 1
                let next = i == captions.count - 1 ? 0 : i + 1
                let positions = self.getCircularPositions(of: caption.get().map({ $0.bounds.size }), at: base)
                let width = (positions.max() ?? 0) - (positions.min() ?? 0)
                if captions[prev].values.target.value <= criticals[prev] {
                    adjusted = self.getMiddleOf(SWAngularRange(start: angles[i].end - width, end: angles[i].end))
                }
                else if captions[next].values.target.value <= criticals[next] {
                    adjusted = self.getMiddleOf(SWAngularRange(start: angles[i].start, end: angles[i].start + width))
                }
                else {
                    adjusted = caption.values.target.angle
                }
            }
            else {
                adjusted = caption.values.target.angle
            }
            caption.wrapper.transform = CGAffineTransform.identity.rotated(by: adjusted)
            UIView.animate(withDuration: 0.1, animations: {
                if caption.values.target.value <= critical {
                    self.alignCaption(caption, overflow)
                    caption.get().forEach({
                        $0.attributedText =  $0.attributedText?.dovegraytify()
                    })
                }
                else {
                    self.alignCaption(caption, base)
                    caption.get().forEach({
                        $0.attributedText =  $0.attributedText?.whitify()
                    })
                }
            })
        }
    }
}
