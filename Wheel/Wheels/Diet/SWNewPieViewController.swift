//
//  SWNewPieViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 01/12/2018.
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
    
    private var prev: CGPoint?
    
    private var chart: SWPieChart!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        self.chart = SWPieChart(
            min: 0.05,
            center: self.view.getBoundsCenter(),
            innerWrapper: UIView(),
            outerWrapper: UIView(),
            marksWrapper: UIView(),
            captionsWrapper: UIView(),
            innerRadius: self.radius - 20,
            outerRadius: self.radius,
            marksRadius: self.radius - 50,
            sections: [
                SWPieSection(
                   innerLayer: CAShapeLayer(),
                   innerColor: UIColor.wildblueyonder,
                   outerLayer: CAShapeLayer(),
                   outerColor: UIColor.wildblueyonder,
                   range: SWAngularRange(start: 0, end: CGFloat.pi * 2),
                   legend: SWPieLegend(code: 1, name: "fats"),
                   markWrapper: UIView(),
                   markLabel: UILabel(),
                   captionWrapper: UIView(),
                   captionChars: [],
                   share: 0,
                   markAngle: 0
                ),
                SWPieSection(
                    innerLayer: CAShapeLayer(),
                    innerColor: UIColor.lavenderpurple,
                    outerLayer: CAShapeLayer(),
                    outerColor: UIColor.lavenderpurple,
                    range: SWAngularRange(start: 0, end: CGFloat.pi * 2),
                    legend: SWPieLegend(code: 2, name: "proteins"),
                    markWrapper: UIView(),
                    markLabel: UILabel(),
                    captionWrapper: UIView(),
                    captionChars: [],
                    share: 0,
                    markAngle: 0
                ),
                SWPieSection(
                    innerLayer: CAShapeLayer(),
                    innerColor: UIColor.turkishrose,
                    outerLayer: CAShapeLayer(),
                    outerColor: UIColor.turkishrose,
                    range: SWAngularRange(start: 0, end: CGFloat.pi * 2),
                    legend: SWPieLegend(code: 3, name: "carbohydrates"),
                    markWrapper: UIView(),
                    markLabel: UILabel(),
                    captionWrapper: UIView(),
                    captionChars: [],
                    share: 0,
                    markAngle: 0
                )
            ])

        self.chart.sections.forEach({
            
            self.chart.outerWrapper.layer.addSublayer($0.outerLayer)
            $0.outerLayer.fillColor = $0.outerColor.cgColor
            
            self.chart.innerWrapper.layer.addSublayer($0.innerLayer)
            $0.innerLayer.fillColor = $0.innerColor.cgColor
            
            self.chart.marksWrapper.addSubview($0.markWrapper)
            $0.markWrapper.addSubview($0.markLabel)
            
            self.chart.captionsWrapper.addSubview($0.captionWrapper)
            $0.captionChars.removeAll()
            for char in $0.legend.name.reversed() {
                let char = NSAttributedString(string: String(char)).whitify().avenirLightify(14)
                let label = UILabel(frame: CGRect(origin: .zero, size: char.size()))
                label.attributedText = char
                $0.captionWrapper.addSubview(label)
                $0.captionChars.append(label)
            }
        })

        self.view.addSubview(self.chart.outerWrapper)
        self.view.addSubview(self.chart.innerWrapper)
        self.view.addSubview(self.chart.marksWrapper)
        self.view.addSubview(self.chart.captionsWrapper)

        //gesture recognizer
        do {
            self.spinner = UIPanGestureRecognizer(target: self, action: #selector(onSpin(sender:)))
            self.view.addGestureRecognizer(self.spinner)
        }

    }
    
    func alignSubviews() {
        print("alignSubviews")
        
        self.chart.innerWrapper.frame = self.view.bounds
        self.chart.outerWrapper.frame = self.view.bounds
        self.chart.marksWrapper.frame = self.view.bounds
        self.chart.captionsWrapper.frame = self.view.bounds
        
        self.chart.sections.forEach({
            (section) in
            //mark
            do {
                section.markWrapper.frame.size = NSAttributedString(string: "88%").avenirLightify(17).whitify().size()
                section.markWrapper.center = self.chart.marksWrapper.getBoundsCenter()
                section.markLabel.center = section.markWrapper.getBoundsCenter()
            }
            
            //caption
            do {
                section.captionWrapper.frame = self.chart.captionsWrapper.bounds
                for char in section.captionChars {
                    char.center = section.captionWrapper.getBoundsCenter()
                }
            }
        })
        
        //angles
        do {
            if let settingsVm = self.settingsVm {
                self.chart.sections[0].range = SWAngularRange(start: settingsVm.fatsStartAngle, end: settingsVm.fatsEndAngle)
                self.chart.sections[1].range = SWAngularRange(start: settingsVm.proteinStartAngle, end: settingsVm.proteinEndAngle)
                self.chart.sections[2].range = SWAngularRange(start: settingsVm.carbohydratesStartAngle, end: settingsVm.carbohydratesEndAngle)
            }
            else {
                let calculated = self.convertToAngles(shares: [
                    self.settings.fatsDailyShare,
                    self.settings.proteinsDailyShare,
                    self.settings.carbohydratesDailyShare
                ])
                self.chart.sections[0].range = calculated[0]
                self.chart.sections[1].range = calculated[1]
                self.chart.sections[2].range = calculated[2]
                let settingsVm = SWDietSettingsViewModel(
                    id: self.settings.id,
                    fatsStartAngle: self.chart.sections[0].range.start,
                    fatsEndAngle: self.chart.sections[0].range.end,
                    proteinStartAngle: self.chart.sections[1].range.start,
                    proteinEndAngle: self.chart.sections[1].range.end,
                    carbohydratesStartAngle: self.chart.sections[2].range.start,
                    carbohydratesEndAngle: self.chart.sections[2].range.end)
                self.settingsVm = settingsVm
            }
            
            self.chart.sections.forEach({
                $0.markAngle = self.getMiddleOf($0.range)
            })
        }
        
        //shares
        do {
            self.chart.sections[0].share = settings.fatsDailyShare
            self.chart.sections[1].share = settings.proteinsDailyShare
            self.chart.sections[2].share = settings.carbohydratesDailyShare
        }
        
        //draw
        do {
            self.chart.center = self.view.getBoundsCenter()
            self.drawChart()
            self.drawShares()
            self.drawCaption()
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
        
        self.chart.innerWrapper.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        self.chart.innerWrapper.alpha = 0
        
        self.chart.outerWrapper.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        self.chart.outerWrapper.alpha = 0
        
        self.chart.marksWrapper.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        self.chart.marksWrapper.alpha = 0
        
        self.chart.captionsWrapper.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
        self.chart.captionsWrapper.alpha = 0
        
    }
    
    func appear() {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
            
            self.chart.innerWrapper.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            self.chart.innerWrapper.alpha = 1
            
            self.chart.outerWrapper.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            self.chart.outerWrapper.alpha = 1
            
            self.chart.marksWrapper.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            self.chart.marksWrapper.alpha = 1
            
            self.chart.captionsWrapper.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            self.chart.captionsWrapper.alpha = 1
            
        }, completion: {
            (complete: Bool) -> Void in
            
            self.shareDrawer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {
                _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.drawShares()
                })
                
            })
            
            self.captionDrawer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {
                _ in
                UIView.animate(withDuration: 0.1, animations: {
                    self.drawCaption()
                })
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
            self.prev = sender.location(in: self.view)
        case .changed:
            let next = sender.location(in: self.view)
            
            let edge = self.getClosestEdge(to: next)
            
            if let prev = self.prev {
                let prevAngles = self.chart.sections.map({ $0.range })
                
                let delta = getAngleBetweenPoints(prev, next, self.chart.center)
                
                do {
                    edge.first.range = SWAngularRange(start: edge.first.range.start, end: edge.first.range.end + delta)
                    edge.second.range = SWAngularRange(start: edge.second.range.start + delta, end: edge.second.range.end)
                    
                    
                    let nextShares = self.convertToShares(angles: self.chart.sections.map({ $0.range }))
                    if nextShares.contains(where: { $0 < self.chart.min }) {
                        for i in 0..<self.chart.sections.count {
                            self.chart.sections[i].range = prevAngles[i]
                        }
                    }
                    else {
                        for i in 0..<self.chart.sections.count {
                            self.chart.sections[i].share = nextShares[i]
                        }
                    }
                    
                    self.chart.sections.forEach({
                        $0.markAngle = self.getMiddleOf($0.range)
                    })
                    
                    self.drawChart()
                    
                    //save
                    do {
                        if var settingsVm = self.settingsVm {
                            settingsVm.fatsStartAngle = self.chart.sections[0].range.start
                            settingsVm.fatsEndAngle = self.chart.sections[0].range.end
                            settingsVm.proteinStartAngle = self.chart.sections[1].range.start
                            settingsVm.proteinEndAngle = self.chart.sections[1].range.end
                            settingsVm.carbohydratesStartAngle = self.chart.sections[2].range.start
                            settingsVm.carbohydratesEndAngle = self.chart.sections[2].range.end
                            self.settingsVm = settingsVm
                        }
                        let shares = self.convertToShares(angles: self.chart.sections.map({ $0.range }))
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
    
    private func convertToAngles(shares: [Double]) -> [SWAngularRange] {
        var base: CGFloat = 0
        let result = shares
            .map({
                (share) -> SWAngularRange in
                let range = SWAngularRange(start: base, end: base + CGFloat.pi * 2 * CGFloat(share))
                base = range.end
                return range
            })
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
        self.chart.sections.forEach({
            $0.innerLayer.path = self.drawSection($0.range, self.chart.innerRadius, self.chart.center).cgPath
            $0.outerLayer.path = self.drawSection($0.range, self.chart.outerRadius, self.chart.center).cgPath
            
            $0.markWrapper.transform = CGAffineTransform.identity.translatedBy(x: self.chart.marksRadius * cos($0.markAngle), y: self.chart.marksRadius * sin($0.markAngle))
        })
    }
    
    private func getAngleBetweenPoints(_ a: CGPoint, _ b: CGPoint, _ center: CGPoint) -> CGFloat {
        let u = CGPoint(x: a.x - center.x, y: a.y - center.y)
        let v = CGPoint(x: b.x - center.x, y: b.y - center.y)
        return getAngleBetweenVectors(u, v).angle
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
            )
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
    
    private func getClosestEdge(to point: CGPoint) -> SWPieEdge {
        let angle = self.getAngleAtCircle(with: self.chart.center, for: point)
        for i in 0..<self.chart.sections.count {
            let current = self.chart.sections[i]
            let next = self.chart.sections[i == self.chart.sections.count - 1 ? 0 : i + 1]
            let range = SWAngularRange(start: self.getMiddleOf(current.range), end: self.getMiddleOf(next.range))
            if self.isInRange(angle, range) {
                return SWPieEdge(first: current, second: next)
            }
        }
        fatalError("Cannot find edge for point \(point)")
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
    
    private func alignCaption(of section: SWPieSection, at radius: CGFloat) {
        section
            .captionChars
            .zip(with: getCircularPositions(of: section.captionChars.map({ $0.bounds.size }), at: radius), as: {
                (char: UILabel, angle: CGFloat) -> (char: UILabel, angle: CGFloat) in
                return (char, angle)
            })
            .forEach({
                $0.char.transform = CGAffineTransform.identity.rotated(by: $0.angle).translatedBy(x: 0, y: radius)
            })
    }
    
    private func drawShares() {
        
        var formatees: [SWPieLegend:Int] = [:]
        var leftover: Int = 0
        self.chart.sections.forEach({
            let formatted = Int($0.share * 100)
            leftover += formatted
            formatees[$0.legend] = formatted
        })
        
        var sorted = self.chart.sections.sorted(by: {
            (prev, next) -> Bool in
            return prev.share - floor(prev.share) > next.share - floor(next.share)
        })
        
        if leftover != 100 {
            for _ in 0..<100 - leftover {
                let closest = sorted.first!
                formatees[closest.legend] = formatees[closest.legend]! + 1
                sorted = sorted.filter({ $0.legend != closest.legend })
            }
        }
        self.chart.sections.forEach({
            let new = formatees[$0.legend]!
            let text = NSAttributedString(string: String(Int(new)) + "%").avenirLightify(17).whitify()
            $0.markLabel.frame.size = text.size()
            $0.markLabel.attributedText = text
            $0.markLabel.center = $0.markWrapper.getBoundsCenter()
        })
    }
    
    private func drawCaption() {
        let base = (self.chart.outerRadius + self.chart.innerRadius) * 0.5
        let overflow = self.chart.outerRadius * 1.5 - self.chart.innerRadius * 0.5
        var criticals: [Double] = []
        
        for section in self.chart.sections {
            let positions = self
                .getCircularPositions(
                    of: section.captionChars.map({ $0.bounds.size }),
                    at: base)
            let critical = Double((positions.last! - positions.first!) / (CGFloat.pi * 2))
            criticals.append(critical)
        }
        
        for i in 0..<self.chart.sections.count {
            let section = self.chart.sections[i]
            let critical = criticals[i]
            var adjusted: CGFloat = 0
            if  section.share <= critical {
                let prev = i == 0 ? self.chart.sections.count - 1 : i - 1
                let next = i == self.chart.sections.count - 1 ? 0 : i + 1
                let positions = self.getCircularPositions(of: section.captionChars.map({ $0.bounds.size }), at: base)
                let width = (positions.max() ?? 0) - (positions.min() ?? 0)
                if self.chart.sections[prev].share <= criticals[prev] {
                    adjusted = self.getMiddleOf(SWAngularRange(start: section.range.start, end: section.range.start + width))
                }
                else if self.chart.sections[next].share <= criticals[next] {
                    adjusted = self.getMiddleOf(SWAngularRange(start: section.range.end - width, end: section.range.end))
                }
                else {
                    adjusted = section.markAngle
                }
            }
            else {
                adjusted = section.markAngle
            }
            section.captionWrapper.transform = CGAffineTransform.identity.rotated(by: adjusted)
            
            if section.share <= critical {
                self.alignCaption(of: section, at: overflow)
            }
            else {
                self.alignCaption(of: section, at: base)
            }
            
        }
    }
}

