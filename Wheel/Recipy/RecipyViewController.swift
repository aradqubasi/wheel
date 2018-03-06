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
    
    // MARK: - Private Properties
    
    private var _servings: Int!
    
    private var _selectionViews: [SWRecipyIngridientView]!
    
    private var _segues: SWSegueRepository!
    
    private var _selectionContainer: UIView!
    
    private var _recipyHeaderContainer: UIView!
    
    private var _name: String!
    
//    private var _ingredientRepository: SWIngredientRepository!
    
    private var _measuresmentRepository: SWMeasuresmentRepository!
    
    private var _ingredientStatsRepository: SWIngredientStatsRepository!
    
    private var _servingsGenerator: SWServingsGenerator!
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _name = assembler.resolve().getName(for: selection)
        
        _segues = assembler.resolve()
        
//        _ingredientRepository = assembler.resolve()
        
        _measuresmentRepository = assembler.resolve()
        
        _ingredientStatsRepository = assembler.resolve()
        
        _servingsGenerator = assembler.resolve()
        
        // selection container
        do {
            _selectionContainer = UIView()
            view.addSubview(_selectionContainer)
            
            let box = CGSize(width: 88, height: 88)
            let innerSpacing = CGPoint(x: 8, y: 24)
            let outerSpacing = CGPoint(x: 16, y: 24)
            let perLine = Int((view.bounds.width + innerSpacing.x - outerSpacing.x * 2) / (box.width + innerSpacing.x))
            var line: Int = 0
            var position: Int = 0
            
            selection?.forEach({
                if position >= perLine && position != 0 {
                    position = 0
                    line = line + 1
                }
                print($0.name)
                let left = /*outerSpacing.x + */CGFloat(position) * (box.width + innerSpacing.x)
                let top = /*outerSpacing.y + */CGFloat(line) * (box.height + innerSpacing.y)
                let next = SWRecipyIngridientView(frame: CGRect(origin: CGPoint(x: left, y: top), size: box), for: $0)
                next.alignSubviews()
                //            view.addSubview(next)
                _selectionContainer.addSubview(next)
                position = position + 1
            })
            
            let lines = line + 1
            let width = CGFloat(perLine) * box.width + CGFloat(perLine - 1) * innerSpacing.x
            let height = CGFloat(lines) * box.height + CGFloat(lines - 1) * innerSpacing.y
            _selectionContainer.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
            
        }

        view.backgroundColor = UIColor.aquaHaze
        
        _servings = 2
        
        // recipy header
        do {
            _recipyHeaderContainer = UIView()
            
            let recipyHeader = UILabel.getRecipyHeader(_name)
            _recipyHeaderContainer.addSubview(recipyHeader)
            recipyHeader.translatesAutoresizingMaskIntoConstraints = false
            recipyHeader.addSizeConstraints()
            recipyHeader.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
            recipyHeader.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: 16).isActive = true
            recipyHeader.topAnchor.constraint(equalTo: _recipyHeaderContainer.topAnchor, constant: 24).isActive = true
            
            var subheader: UIStackView!
            do {
                let spacing: CGFloat = 4
                
//                let stats = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 247, height: 16)))
                
                var energy: Double = 0
                var proteins: Double = 0
                var fats: Double = 0
                var carbohydrates: Double = 0
                do {
                    for ingredient in selection {
                        let unit = _measuresmentRepository.get(by: ingredient.unit)
                        let stats = _ingredientStatsRepository.get(by: ingredient, and: unit)
                        energy += stats.calories * Double(_servings)
                        proteins += stats.proteins * Double(_servings)
                        fats += stats.fats * Double(_servings)
                        carbohydrates += stats.carbohydrates * Double(_servings)
                    }
                }
                
                let gram = _measuresmentRepository.getGram()
                let calories = _measuresmentRepository.getCalories()
                
                let enegryLabel = UILabel.getRecipySubheader("\(Int(energy)) \(calories.short)")
                let oval1 = UIView.recipySubtitleOval
                let carbohydratesLabel = UILabel.getRecipySubheader("\(Int(carbohydrates)) \(gram.short) Carbs")
                let oval2 = UIView.recipySubtitleOval
                let fatsLabel = UILabel.getRecipySubheader("\(Int(fats)) \(gram.short) Fat")
                let oval3 = UIView.recipySubtitleOval
                let proteinsLabel = UILabel.getRecipySubheader("\(Int(proteins)) \(gram.short) Proteins")
                let filler = UIView()
                
                enegryLabel.translatesAutoresizingMaskIntoConstraints = false
                oval1.translatesAutoresizingMaskIntoConstraints = false
                carbohydratesLabel.translatesAutoresizingMaskIntoConstraints = false
                oval2.translatesAutoresizingMaskIntoConstraints = false
                fatsLabel.translatesAutoresizingMaskIntoConstraints = false
                oval3.translatesAutoresizingMaskIntoConstraints = false
                proteinsLabel.translatesAutoresizingMaskIntoConstraints = false
                
                enegryLabel.addSizeConstraints()
                oval1.addSizeConstraints()
                carbohydratesLabel.addSizeConstraints()
                oval2.addSizeConstraints()
                fatsLabel.addSizeConstraints()
                oval3.addSizeConstraints()
                proteinsLabel.addSizeConstraints()
                
                subheader = UIStackView(arrangedSubviews: [enegryLabel, oval1, carbohydratesLabel, oval2, fatsLabel, oval3, proteinsLabel, filler])
                subheader.alignment = .center
                subheader.axis = .horizontal
                subheader.spacing = spacing
            }
            _recipyHeaderContainer.addSubview(subheader)
            subheader.translatesAutoresizingMaskIntoConstraints = false
            subheader.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
            subheader.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: 16).isActive = true
            subheader.topAnchor.constraint(equalTo: recipyHeader.bottomAnchor, constant: 8).isActive = true
            subheader.heightAnchor.constraint(equalToConstant: 16).isActive = true
            
            var line1: UIView!
            do {
                line1 = UIView().getRecipySeparatorLine(for: view.bounds.width - 16 * 2)
                _recipyHeaderContainer.addSubview(line1)
                line1.translatesAutoresizingMaskIntoConstraints = false
                line1.addSizeConstraints()
                line1.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                line1.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
                line1.topAnchor.constraint(equalTo: subheader.bottomAnchor, constant: 24).isActive = true
            }
            
            var servings: SWRecipyServingsCounter!
            do {

                servings = SWRecipyServingsCounter.usual(with: _servingsGenerator)
                servings.servings = _servings
                _recipyHeaderContainer.addSubview(servings)
                servings.translatesAutoresizingMaskIntoConstraints = false
                servings.addSizeConstraints()
                servings.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 30).isActive = true
                servings.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
            }
            
            var increase: UIButton!
            do {
                increase = UIButton.increase
                _recipyHeaderContainer.addSubview(increase)
                increase.translatesAutoresizingMaskIntoConstraints = false
                increase.addSizeConstraints()
                increase.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 24).isActive = true
                increase.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
            }
            
            var decrease: UIButton!
            do {
                decrease = UIButton.decrease
                _recipyHeaderContainer.addSubview(decrease)
                decrease.translatesAutoresizingMaskIntoConstraints = false
                decrease.addSizeConstraints()
                decrease.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 24).isActive = true
                decrease.trailingAnchor.constraint(equalTo: increase.leadingAnchor, constant: 1).isActive = true
            }
            
            _recipyHeaderContainer.backgroundColor = .white
            _recipyHeaderContainer.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 80 + 8 + 16 + 600))
            view.addSubview(_recipyHeaderContainer)
        }
        
        do {
            navigationItem.titleView = UILabel.getRecipyTitle(_name)
            
            let back = UIBarButtonItem.back
            navigationItem.leftBarButtonItem = back
            back.action = #selector(onBackButtonClick(_:))
            back.target = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {

        let outerSpacing = CGPoint(x: 16, y: 24)
        _selectionContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        _selectionContainer.translatesAutoresizingMaskIntoConstraints = false
        _selectionContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: topLayoutGuide.length + outerSpacing.y).isActive = true
        _selectionContainer.addSizeConstraints()
        
        _recipyHeaderContainer.addSizeConstraints()
        _recipyHeaderContainer.translatesAutoresizingMaskIntoConstraints = false
        _recipyHeaderContainer.topAnchor.constraint(equalTo: _selectionContainer.bottomAnchor, constant: outerSpacing.y).isActive = true
        _recipyHeaderContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                
        print("self.topLayoutGuide.length \(self.topLayoutGuide.length)")
        super.viewWillLayoutSubviews()
        print("self.topLayoutGuide.length \(self.topLayoutGuide.length)")
    }
    
    // MARK: - Actions
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        
        performSegue(withIdentifier: _segues.getRecipyToWheels().identifier, sender: self)
        
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
