//
//  RecipyViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class RecipyViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var assembler: SWRecipyAssembler!
    
    var selection: [SWIngredient]!
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()

        selection?.forEach({ print($0.name) })
        
        navigationItem.titleView = UILabel.getRecipyTitle(assembler.resolve().getName(for: selection))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.back
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        
        performSegue(withIdentifier: assembler.resolve().getRecipyToWheels(), sender: self)
        
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
