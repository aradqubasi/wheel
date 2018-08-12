//
//  SubwheelViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 05/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class SubwheelViewController: UIViewController {
    
//    // MARK: - Public Properties
//
//    var assembler: SWSubwheelAssembler!
//
//    // MARK: - Private Properties
//
//    private var animating: Bool = false
//
//    private var selection: SWSelectionWheelController!
//
//    private var abstractSelection: SWSelectionWheelProtocol {
//        get {
//            return selection
//        }
//    }
//
//    // MARK: - Initialization
//
//    var floatings: [Floatable] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.addSubview(assembler.resolve())
//
//        selection = SWSelectionWheelController()
//        selection.assembler = self.assembler.resolve(semaphor: self)
//        selection.delegate = self
//        let rectangle = CGRect(x: 0, y: 0, width: view.frame.width * 1.7, height: view.frame.width * 1.7)
//        selection.view.frame = rectangle
//        selection.view.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.height * 1.3)
////        selection.view.center = CGPoint(x: view.frame.width * 0.5, y: view.frame.height * 0.5)
//        view.addSubview(selection.view)
//        self.addChildViewController(selection)
//        selection.didMove(toParentViewController: self)
//        selection.alignSubviews()
//
//        let blueButton = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 200), size: CGSize(side: 30)))
//        blueButton.addTarget(self, action: #selector(onBlueButtonClick(_:)), for: .touchUpInside)
//        blueButton.layer.cornerRadius = 15
//        blueButton.backgroundColor = .blue
//        view.addSubview(blueButton)
//
//        let redButton = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 230 + 5), size: CGSize(side: 30)))
//        redButton.addTarget(self, action: #selector(onRedButtonClick(_:)), for: .touchUpInside)
//        redButton.layer.cornerRadius = 15
//        redButton.backgroundColor = .red
//        view.addSubview(redButton)
//
//        let greenButton = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 200 + 5 + 30 + 5 + 30), size: CGSize(side: 30)))
//        greenButton.addTarget(self, action: #selector(onGreenButtonClick(_:)), for: .touchUpInside)
//        greenButton.layer.cornerRadius = 15
//        greenButton.backgroundColor = .green
//        view.addSubview(greenButton)
//
//        let orangeButton = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 200 + 5 + 30 + 5 + 30 + 5 + 30), size: CGSize(side: 30)))
//        orangeButton.addTarget(self, action: #selector(onOrangeButtonClick(_:)), for: .touchUpInside)
//        orangeButton.layer.cornerRadius = 15
//        orangeButton.backgroundColor = .orange
//        view.addSubview(orangeButton)
//
//        let ingredients = SWInmemoryIngredientRepository()
//
//        let protein = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 66, y: 312.5), size: CGSize(width: 42, height: 42)))
//        protein.ingredient = ingredients.getAll(by: .protein).random()!
//        view.addSubview(protein)
//        floatings.append(protein)
//        let veggy1 = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 127, y: 312.5), size: CGSize(width: 42, height: 42)))
//        veggy1.ingredient = ingredients.getAll(by: .veggy).random()!
//        view.addSubview(veggy1)
//        floatings.append(veggy1)
//        let veggy2 = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 127, y: 312.5), size: CGSize(width: 42, height: 42)))
//        veggy2.ingredient = ingredients.getAll(by: .veggy).random()!
//        view.addSubview(veggy2)
//        floatings.append(veggy2)
//        let fats = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 188, y: 312.5), size: CGSize(width: 42, height: 42)))
//        fats.ingredient = ingredients.getAll(by: .fat).random()!
//        view.addSubview(fats)
//        floatings.append(fats)
//        let base = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 249, y: 312.5), size: CGSize(width: 42, height: 42)))
//        base.ingredient = ingredients.getAll(by: .base).random()!
//        view.addSubview(base)
//        floatings.append(base)
//        let unexpected = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 79.5, y: 80), size: CGSize(width: 42, height: 42)))
//        unexpected.ingredient = ingredients.getAll(by: .unexpected).random()!
//        view.addSubview(unexpected)
//        floatings.append(unexpected)
////        let dressing = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 159.5, y: 80), size: CGSize(width: 42, height: 42)))
////        dressing.ingredient = ingredients.getAll(by: .dressing).random()!
////        view.addSubview(dressing)
////        floatings.append(dressing)
////        let fruits = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 239.5, y: 80), size: CGSize(width: 42, height: 42)))
////        fruits.ingredient = ingredients.getAll(by: .fruits).random()!
////        view.addSubview(fruits)
////        floatings.append(fruits)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    // MARK: - Action Methods
//
////    class SWFakeFloatable: UIView, Floatable {
////        var asIngridient: SWIngredient {
////            get {
////                return ingredient
////            }
////        }
////        var ingredient: SWIngredient!
////    }
//
//    @IBAction func onBlueButtonClick(_ sender: Any) {
////        let ingredients = SWInmemoryIngredientRepository()
////        if let allowed = selection.getFocusedKind().first {
////            UIView.animate(withDuration: 0.225, animations: { self.selection.push(ingredients.getAll(by: allowed).random()!) })
////
////        }
//
////        selection.push(floatings.random()!)
//        abstractSelection.push(floatings)
//    }
//
//    @IBAction func onRedButtonClick(_ sender: Any) {
//        let ingredients = SWInmemoryIngredientRepository()
//        if let allowed = abstractSelection.getFocusedKind().first {
//            abstractSelection.push(ingredients.getAll(by: allowed).random()!)
//        }
//    }
//
//    @IBAction func onGreenButtonClick(_ sender: Any) {
//        if let focused = abstractSelection.getFocusedIngredient() {
//            abstractSelection.pop(focused)
//        }
//    }
//
//    @IBAction func onOrangeButtonClick(_ sender: Any) {
//        if let selection = abstractSelection as? SWSelectionWheelController{
//            selection.setStatus(!selection.getStatus())
//        }
//    }
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension SubwheelViewController: SWSelectionWheelDelegate {
//
//    func onKindSwitched(from prev: SWIngredientKinds, to next: SWIngredientKinds) {
//        print("onKindSwitched from \(prev) to \(next)")
//    }
//
//    func onCook() {
//        print("SubwheelViewController.onCook")
//    }
//
//    func onTriggerRandomIngredient(of kind: [SWIngredientKinds]) {
//        print("SubwheelViewController.onTriggerRandomIngredient")
//        let ingredients = SWInmemoryIngredientRepository()
////        selection.push(ingredients.getAll(by: kind.random()!).random()!)
//        let test = SWFakeFloatable(frame: CGRect(origin: CGPoint(x: 66, y: 312.5), size: CGSize(width: 42, height: 42)))
//        test.ingredient = ingredients.getAll(by: kind.random()!).random()!
//        view.addSubview(test)
//        selection.push([test])
//    }

}

//extension SubwheelViewController: SWAnimationSemaphor {
//
//    func couldAnimate(sender: Any) -> Bool {
//        return animating
//    }
//
//    func onAnimationStart(sender: Any) {
//        animating = true
//    }
//
//    func onAnimationEnd(sender: Any) {
//        animating = false
//    }
//
//}

