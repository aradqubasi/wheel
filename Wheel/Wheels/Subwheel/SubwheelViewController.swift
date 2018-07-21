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
    
    var floatings: [Floatable] = []

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
        
        let ingredients = SWInmemoryIngredientRepository()
        
        let protein = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 66, y: 312.5), size: CGSize(width: 42, height: 42)))
        protein.ingredient = ingredients.getAll(by: .protein).random()!
        view.addSubview(protein)
        floatings.append(protein)
        let veggy = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 127, y: 312.5), size: CGSize(width: 42, height: 42)))
        veggy.ingredient = ingredients.getAll(by: .veggy).random()!
        view.addSubview(veggy)
        floatings.append(veggy)
        let fats = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 188, y: 312.5), size: CGSize(width: 42, height: 42)))
        fats.ingredient = ingredients.getAll(by: .fat).random()!
        view.addSubview(fats)
        floatings.append(fats)
        let base = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 249, y: 312.5), size: CGSize(width: 42, height: 42)))
        base.ingredient = ingredients.getAll(by: .base).random()!
        view.addSubview(base)
        floatings.append(base)
        let unexpected = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 79.5, y: 80), size: CGSize(width: 42, height: 42)))
        unexpected.ingredient = ingredients.getAll(by: .unexpected).random()!
        view.addSubview(unexpected)
        floatings.append(unexpected)
//        let dressing = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 159.5, y: 80), size: CGSize(width: 42, height: 42)))
//        dressing.ingredient = ingredients.getAll(by: .dressing).random()!
//        view.addSubview(dressing)
//        floatings.append(dressing)
//        let fruits = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 239.5, y: 80), size: CGSize(width: 42, height: 42)))
//        fruits.ingredient = ingredients.getAll(by: .fruits).random()!
//        view.addSubview(fruits)
//        floatings.append(fruits)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action Methods
    
    class SWFakeFloatable: UIView, Floatable {
        var asIngridient: SWIngredient {
            get {
                return ingredient
            }
        }
        var ingredient: SWIngredient!
    }
    
    @IBAction func onBlueButtonClick(_ sender: Any) {
//        let ingredients = SWInmemoryIngredientRepository()
//        if let allowed = selection.getFocusedKind().first {
//            UIView.animate(withDuration: 0.225, animations: { self.selection.push(ingredients.getAll(by: allowed).random()!) })
//
//        }
        
//        selection.push(floatings.random()!)
        selection.push(floatings)
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
