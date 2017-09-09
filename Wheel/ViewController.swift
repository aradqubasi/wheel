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
    
    
    
    // MARK: - SubViews
    
    var radialMenu: RadialView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.radialMenu = RadialView(center: CGPoint(x: self.view.frame.width, y: self.view.frame.height / 2))
        self.view.addSubview(radialMenu)
        self.view.addSubview(SpokeView(point: .zero, radius: 10, side: 50, background: UIColor.yellow, angle: 0))
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
        radialMenu.right()
    }
    
    
    
}

