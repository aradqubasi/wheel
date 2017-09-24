//
//  ViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    // MARK: - Public Properties
    
    // MARK: - Private Properties
    
    var _prev: CGFloat?
    
    // MARK: - Subs
    
    var radialMenu: RadialView!
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.radialMenu = RadialView(center: CGPoint(x: self.view.frame.width, y: self.view.frame.height / 2))
        self.radialMenu = RadialView(center: CGPoint(x: 0, y: self.view.frame.height / 2))
        self.view.addSubview(radialMenu)
        //self.view.addSubview(SpokeView(point: .zero, radius: 10, side: 50, background: UIColor.yellow, angle: 0))
        //self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTap(_:)))
        //self.scrollGestureRecognizer = ScrollGestureRecognizer(target: self, action: #selector(self.onScroll(_:)))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func onButtonClick(_ sender: Any) {
        radialMenu.addSpoke()
    }
    
    @IBAction func onLeftButtonClick(_ sender: Any) {
        radialMenu.left()
    }
    
    @IBAction func onRightButtonClick(_ sender: Any) {
        //radialMenu.right()
        radialMenu.push(1000)
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        print("its a tap")
    }
    
    @IBAction func onClick(_ sender: ClickGestureRecognizer) {
//        switch sender.state {
//            
//        }
        print("onclick \(sender.state.rawValue)")
    }
    
    
    
    @IBAction func onScroll(_ sender: UIPanGestureRecognizer) {
        //print(sender.state)
        switch sender.state {
        case .began:
            print("began")
            radialMenu.beginFollow(at: getAngle(point: sender.location(in: self.view), center: radialMenu.center))
        case .cancelled:
            print("cancelled")
        case .changed:
            print("changed")
            radialMenu.continueFollow(at: getAngle(point: sender.location(in: self.view), center: radialMenu.center))
            //print(sender.velocity(in: self.view))
        case .ended:
            print("ended")
            radialMenu.endFollow()
            //_prev = nil
            //print(sender.velocity(in: self.view))
        case .failed:
            print("failed")
        case .possible:
            print("possible")
        }
    }
    
    // MARK: - Private Methods
    
    private func getAngle(point: CGPoint, center: CGPoint) -> CGFloat {
        //let point = sender.location(in: self.view)
        //let center = self.radialMenu.center
        
        let dx = point.x - center.x
        let dy = point.y - center.y
        var angle = atan(abs(dy) / abs(dx))
        
        //print(point)
        //print(CGPoint(x: origin.x + self.radialMenu.frame.width / 2.0, y: origin.y + self.radialMenu.frame.height / 2.0))
        //print(CGPoint(x: dx, y: dy))
        
        if dx > 0 &&  dy > 0 {
            //do nothing
        }
        else if dx < 0 &&  dy > 0 {
            angle = CGFloat.pi - angle
            //angle = CGFloat.pi * 2 - angle
        }
        else if dx < 0 &&  dy < 0 {
            angle = CGFloat.pi + angle
        }
        else if dx > 0 &&  dy < 0 {
            angle = CGFloat.pi * 2 - angle
        }
        
        //print(angle)
        
        return angle
        //if let prev = _prev {
        //    self.radialMenu.rotate(by: angle - prev)
        //}
        //_prev = angle
    }
    
}

