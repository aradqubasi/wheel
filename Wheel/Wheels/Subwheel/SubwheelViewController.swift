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
//        selection.view.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.height * 0.5)
        view.addSubview(selection.view)
        self.addChildViewController(selection)
        selection.didMove(toParentViewController: self)
        selection.alignSubviews()
        
        let blueButton = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 200), size: CGSize(side: 60)))
        blueButton.addTarget(self, action: #selector(onBlueButtonClick(_:)), for: .touchUpInside)
        blueButton.layer.cornerRadius = 30
        blueButton.backgroundColor = .blue
        view.addSubview(blueButton)
//        blueButton.set
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods
    
    @IBAction func onBlueButtonClick(_ sender: Any) {
        let ingredients = SWInmemoryIngredientRepository()
        if let allowed = selection.getFocusedKind().first {
            UIView.animate(withDuration: 0.225, animations: { self.selection.push(ingredients.getAll(by: allowed).random()!) })
            
        }
        //).random()!)
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
