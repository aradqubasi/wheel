//
//  RadialView.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class RadialView: UIView {
    
    // MARK: - Public Properties
    
    var delegate: RadialViewDelegate?
    
    // MARK: - Basic Geometric Properties
    
    var wheelSateliteRadius: CGFloat
    {
        get {
            return 15
        }
    }
    
    var wheelRadius: CGFloat
    {
        get {
            return 150
        }
    }
    
    var spacing: CGFloat {
        get {
            return 15
        }
    }
    
    // MARK: - Calculatable Geometric Properties
    
    var sateliteCentersAngularDistance: CGFloat {
        get {
            return (2 * self.wheelSateliteRadius + self.spacing) / self.wheelRadius
        }
    }
    
    var sateliteAngularSpacing: CGFloat {
        get {
            return self.spacing / self.wheelRadius
        }
    }
    
    var sateliteAngularSize: CGFloat {
        get {
            return 2 * self.wheelSateliteRadius / self.wheelRadius
        }
    }
    
    var startAngle: CGFloat {
        get {
            return bottomAngle + sateliteAngularSpacing + sateliteAngularSize * 0.5
        }
    }
    
    var bottomAngle: CGFloat {
        return -CGFloat.pi * 0.5
    }
    
    var topAngle: CGFloat {
        return CGFloat.pi * 0.5
    }
    
    // MARK: - Private Properties
    
    private var spokes: [UIView] = []
    
    private var currentAngle: CGFloat = 0
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // MARK: - Initialization
    
    init(point: CGPoint) {
        super.init(frame: .zero)
        //prepare frame
        let color = UIColor.blue
        //tweak
        let r: CGFloat = self.wheelRadius
        let sqrt2 = CGFloat(sqrt(2))
        let spokeOrigin = CGPoint(x: r * (sqrt2 - 1.0), y: r * (sqrt2 - 1.0))
        let deltaAngle = (2 * self.wheelSateliteRadius + self.spacing) / self.wheelRadius
        print(deltaAngle)
        let spokeCount =  Int(2 * CGFloat.pi / deltaAngle)
        print(spokeCount)
        self.frame.origin = point
        self.frame.size = CGSize(width: r * sqrt2 * 2, height: r * sqrt2 * 2)
        
        //self.bounds.origin = CGPoint(x: r * sqrt2, y: r * sqrt2)
        //self.bounds.size = CGSize(width: r * 2, height: r * 2)
        
        self.backgroundColor = color
        //self.layer.cornerRadius = self.frame.width * 0.5
        //
        
        /*
        let spokeView = getSquareView(point: spokeOrigin, side: r * 2, background: UIColor.clear)
        self.addSubview(spokeView)
        spokeView.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 0.25)
        let r2 = self.wheelSateliteRadius
        let spokeItem = getCircleView(point: CGPoint(x: 0, y: r - r2), radius: r2, background: UIColor.yellow)
        spokeView.addSubview(spokeItem)
        */
        var angle: CGFloat = 0//self.startAngle
        for _ in 0..<spokeCount {
            let spokeView = getSpokeView(point: spokeOrigin, radius: self.wheelSateliteRadius, side: self.wheelRadius * 2, background: UIColor.red, angle: angle)
            //spokeView.transform = CGAffineTransform(rotationAngle: angle)
            self.addSubview(spokeView)
            spokes.append(spokeView)
            angle += deltaAngle
        }
        //spokeView.transform = CGAffineTransform.identity.rotated(by: CGFloat(M_PI) * 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func onSomething() {
        /*
        for spoke in spokes {
            spoke.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
        }
 */
        displayAsHalfWheel()
    }
    
    func onAnimatedSomething() {
        /*
        UIView.animate(withDuration: 0.225, animations: {
            () in
            self.displayAsHalfWheel()
        })
        */
        self.currentAngle -= self.sateliteCentersAngularDistance
        UIView.animate(withDuration: 0.225, animations: {
            () in
            var angle: CGFloat = self.startAngle + self.currentAngle
            for spoke in self.spokes {
                spoke.transform = CGAffineTransform(rotationAngle: angle)
                print(angle)
                if angle > self.bottomAngle && angle < self.topAngle {
                    spoke.subviews[0].backgroundColor = UIColor.red
                }
                else {
                    spoke.subviews[0].backgroundColor = UIColor.orange
                }
                angle += self.sateliteCentersAngularDistance
            }
        })
    }
    
    // MARK: - Private Methods
    
    private func displayAsHalfWheel() {
        var angle: CGFloat = self.startAngle + self.currentAngle
        for spoke in self.spokes {
            spoke.transform = CGAffineTransform(rotationAngle: angle)
            if angle > self.bottomAngle && angle < self.topAngle {
                spoke.subviews[0].backgroundColor = UIColor.red
            }
            else {
                spoke.subviews[0].backgroundColor = UIColor.orange
            }
            angle += self.sateliteCentersAngularDistance
        }
    }
    
    // MARK: - Placeholders
    
    func getCircleView(point: CGPoint, radius: CGFloat, background: UIColor) -> UIView {
        let circle = UIView(frame: CGRect(origin: point, size: CGSize(width: radius * 2, height: radius * 2)))
        circle.layer.cornerRadius = radius
        circle.backgroundColor = background
        return circle
    }
    
    func getSquareView(point: CGPoint, side: CGFloat, background: UIColor) -> UIView {
        let square = UIView(frame: CGRect(origin: point, size: CGSize(width: side, height: side)))
        square.backgroundColor = background
        return square
    }
    
    func getSpokeView(point: CGPoint, radius: CGFloat, side: CGFloat, background: UIColor, angle: CGFloat) -> UIView {
        let spokeView = getSquareView(point: point, side: side, background: UIColor.clear)
        let spokeItem = getCircleView(point: CGPoint(x: 0, y: side * 0.5 - radius), radius: radius, background: background)
        spokeView.addSubview(spokeItem)
        spokeView.transform = CGAffineTransform(rotationAngle: angle)
        return spokeView
    }
    
}
