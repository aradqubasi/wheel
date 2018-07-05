//
//  SWSelectionWheelController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SWSelectionWheelController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let radius = min(view.frame.width, view.frame.height) * 0.5
        let wheel = UIView(frame: CGRect(center: CGPoint(x: radius, y: radius), side: radius * 2))
        wheel.backgroundColor = .red
        wheel.layer.cornerRadius = radius
        view.addSubview(wheel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
