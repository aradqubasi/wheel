//
//  SWSliderViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 28/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWSliderViewController: UIViewController {
    
    var range: (min: Double, max: Double) = (0.2, 1)
    
    var slider: UIPanGestureRecognizer!
    
    var progress: Double = 0
    
    var delegate: SWSliderViewDelegate?
    
    private var timer: Timer!
    
    private var column: UIView!
    
    private var filler: CAShapeLayer!
    
    private var mask: CAShapeLayer!
    
    private var background: CAShapeLayer!
    
    private var prev: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.progress = 0
        
        do {
            self.slider = UIPanGestureRecognizer()
            self.view.addGestureRecognizer(self.slider)
            self.slider.addTarget(self, action: #selector(onSlide(sender:)))
        }
        
        do {
            self.column = UIView()
            self.view.addSubview(self.column)
        }
        
        do {
            self.background = CAShapeLayer()
            self.column.layer.addSublayer(self.background)
            
            self.mask = CAShapeLayer()
            self.column.layer.addSublayer(self.mask)
            
            self.filler = CAShapeLayer()
            self.column.layer.addSublayer(self.filler)
        }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        timer?.invalidate()
        
    }
    
    func alignSubviews() {
        
        do {
            self.column.frame = self.view.bounds
//            self.view.backgroundColor = .red
//            self.column.layer.cornerRadius = self.column.bounds.width * 0.2
//            self.column.layer.masksToBounds = true
            
        }
        
        do {
            self.mask.path = self.drawRoundedRectangle(corner: self.column.bounds.width * 0.2, size: CGSize(width: self.column.bounds.width, height: self.column.bounds.height)).cgPath
        }
        
        do {
            let mask = CAShapeLayer()
            mask.path = self.drawRoundedRectangle(corner: self.column.bounds.width * 0.2, size: CGSize(width: self.column.bounds.width, height: self.column.bounds.height)).cgPath
            self.view.layer.addSublayer(mask)
            
            let height = self.column.bounds.height
            let width = self.column.bounds.width
            let square = UIBezierPath()
            square.move(to: .zero)
            square.addLine(to: CGPoint(x: 0, y: height))
            square.addLine(to: CGPoint(x: width, y: height))
            square.addLine(to: CGPoint(x: width, y: 0))
            square.addLine(to: .zero)
            square.close()
            self.background.path = square.cgPath
            self.background.fillColor = UIColor.limedSpruceTransparent.cgColor
            self.background.mask = mask
        }
        
        do {
            self.filler.fillColor = UIColor.azureradiance.cgColor
            self.filler.mask = self.mask
        }
        
        do {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {
                _ in

            })
        }
        
        self.drawFiller()
    }
    
    private func drawFiller() {
        let width = self.column.bounds.width
        let height = self.column.bounds.height
        let progress = 1 - CGFloat(self.progress)
        
        let path = UIBezierPath()

        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width, y: height * progress))
        path.addLine(to: CGPoint(x: 0, y: height * progress))

        path.close()
        
        self.filler.path = path.cgPath
        
        self.filler.fillColor = self.delegate?.getColor(for: self.progress).cgColor
    }
    
    @IBAction private func onSlide(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            self.prev = sender.location(in: self.column)
        case .changed:
            let next = sender.location(in: self.column)
            if let prev = self.prev {
                let delta = prev.y - next.y
                self.progress += Double(delta / self.column.bounds.height)
                self.progress = min(max(self.progress, self.range.min), self.range.max)
                print("progress \(self.progress)")
                self.delegate?.onUpdate(of: self.progress)
                self.drawFiller()
            }
            self.prev = next
        case .ended:
            self.prev = nil
        default:
            print("unhandled state \(sender.state)")
        }
    }

    private func drawRoundedRectangle(corner radius: CGFloat, size: CGSize) -> UIBezierPath {
        let corner = radius
        let height = size.height
        let width = size.width
        let path = UIBezierPath()
        path.move(to: CGPoint(x: corner, y: 0))
        path.addArc(withCenter: CGPoint(x: corner, y: corner), radius: corner, startAngle: CGFloat.pi * 1.5, endAngle: CGFloat.pi, clockwise: false)
        path.addLine(to: CGPoint(x: 0, y: height - corner))
        path.addArc(withCenter: CGPoint(x: corner, y: height - corner), radius: corner, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 0.5, clockwise: false)
        path.addLine(to: CGPoint(x: width - corner, y: height))
        path.addArc(withCenter: CGPoint(x: width - corner, y: height - corner), radius: corner, startAngle: CGFloat.pi * 0.5, endAngle: CGFloat.pi, clockwise: false)
        path.addLine(to: CGPoint(x: width, y: height - corner))
        path.addArc(withCenter: CGPoint(x: width - corner, y: corner), radius: corner, startAngle: 0, endAngle: CGFloat.pi * 1.5, clockwise: false)
        path.addLine(to: CGPoint(x: corner, y: 0))
        path.close()
        return path
    }
}
