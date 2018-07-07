//
//  SubwheelViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SubwheelViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var assembler: SWSubwheelAssembler!
    
    // MARK: - Private Properties
    
    private var selection: SWSelectionWheelController!
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(assembler.resolve())
        
        selection = SWSelectionWheelController()
        let rectangle = CGRect(x: 0, y: 0, width: view.frame.width * 1.7, height: view.frame.width * 1.7)
        selection.view.frame = rectangle
        selection.view.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.height * 1.3)
        view.addSubview(selection.view)
        self.addChildViewController(selection)
        selection.didMove(toParentViewController: self)
        selection.alignSubviews()
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
