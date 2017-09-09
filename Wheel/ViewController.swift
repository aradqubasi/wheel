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
        self.radialMenu = RadialView(point: CGPoint(x: 0, y: 0))
        self.view.addSubview(radialMenu)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func onButtonClick(_ sender: Any) {
        //radialMenu.onSomething()
        radialMenu.onAnimatedSomething()
    }
    
}

