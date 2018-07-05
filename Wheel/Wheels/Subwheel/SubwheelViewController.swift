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
        self.addChildViewController(selection)
        selection.view.frame = CGRect(x: 0, y: view.frame.height - view.frame.width * 0.5, width: view.frame.width, height: view.frame.width)
        view.addSubview(selection.view)
        selection.didMove(toParentViewController: self)
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
