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
    
    var scrollGestureRecognizer: ScrollGestureRecognizer!
    
    // MARK: - Initialioze
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.radialMenu = RadialView(center: CGPoint(x: self.view.frame.width, y: self.view.frame.height / 2))
        self.view.addSubview(radialMenu)
        //self.view.addSubview(SpokeView(point: .zero, radius: 10, side: 50, background: UIColor.yellow, angle: 0))
        
        self.scrollGestureRecognizer = ScrollGestureRecognizer(target: self, action: #selector(self.onScroll(_:)))
        
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
        radialMenu.move()
    }
    
    @IBAction func onScroll(_ sender: UIPanGestureRecognizer) {
        //print(sender.state)
        switch sender.state {
        case .began:
            print("began")
        case .cancelled:
            print("cancelled")
        case .changed:
            print("changed")
            let point = sender.translation(in: self.view)
            let origin = self.radialMenu.frame.origin
            
            let dx = point.x - origin.x
            let dy = point.y - origin.y
            var angle = atan(abs(dy) / abs(dx))
            
            if dx > 0 &&  dy > 0 {
                //do nothing
            }
            else if dx < 0 &&  dy > 0 {
                angle = CGFloat.pi - angle
            }
            else if dx < 0 &&  dy < 0 {
                angle = CGFloat.pi + angle
            }
            else if dx > 0 &&  dy < 0 {
                angle = CGFloat.pi * 2 - angle
            }
            
            print(angle)
            
            if let prev = _prev {
                self.radialMenu.rotate(by: angle - prev)
            }
            _prev = angle

            print(sender.velocity(in: self.view))
        case .ended:
            print("ended")
            
            _prev = nil
            print(sender.velocity(in: self.view))
        case .failed:
            print("failed")
        case .possible:
            print("possible")
        }
    }
    
    
    
}

