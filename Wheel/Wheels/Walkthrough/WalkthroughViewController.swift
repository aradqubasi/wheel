//
//  WalkthroughViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/08/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class WalkthroughViewController: SWViewController {
    
    // MARK: - Public Properties
    
    var assembler: SWWalkthroughAssembler!
    
    // MARK: - Private Properties
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        let background: UIView = assembler.resolve()
        view.addSubview(background)
        
        let shroud = UIView(frame: view.bounds)
        shroud.backgroundColor = UIColor.limedSpruceTransparent
        view.addSubview(shroud)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
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
