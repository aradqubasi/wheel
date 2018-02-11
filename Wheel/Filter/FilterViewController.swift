//
//  FilterViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDataSource {
    
    // MARK: - Subviews
    
    private var _stack: UIStackView!
    
    private var _scroll: UIScrollView!
    
    private var _ingredients: [SWIngrigientsOptionView]!
    
    private var _allergies: [SWAllergiesOptionView]!
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            
        //food preferences
        case 0:
            return 4
            
        //allergies
        case 1:
            return 4
        
        default:
            fatalError("section #\(section) does not exists at source")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        //food preferences
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngridientsCell", for: indexPath) as? UITableViewCell else {
                fatalError("no cell to dequeque for section #\(indexPath.section)")
            }
            return cell
        //allergies
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllergiesCell", for: indexPath) as? UITableViewCell else {
                fatalError("no cell to dequeque for section #\(indexPath.section)")
            }
            return cell
        default:
            fatalError("section #\(indexPath.section) does not exists at source")
        }
    }
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        options.translatesAutoresizingMaskIntoConstraints = false
//        options.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        options.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        options.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        options.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//        options.dataSource = self
        
        let headerRectangle = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 35))
        
        let lineRectangle = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 83))
        
        let ingredientsHeader = SWHeaderOptionView(frame: headerRectangle)
        ingredientsHeader.title = .ingredientsHeader
        
        let noPreferences = SWIngrigientsOptionView(frame: lineRectangle)
        noPreferences.title = .noFoodPreferencesOption
        
        let vegan = SWIngrigientsOptionView(frame: lineRectangle)
        vegan.title = .veganOption
        
        let vegeterian = SWIngrigientsOptionView(frame: lineRectangle)
        vegeterian.title = .vegeterianOption
        
        let percetarian = SWIngrigientsOptionView(frame: lineRectangle)
        percetarian.title = .percetarianOption
        
        let allergiesHeader = SWHeaderOptionView(frame: headerRectangle)
        allergiesHeader.title = .allergiesHeader
        
        let noAllergiesOption = SWAllergiesOptionView(frame: lineRectangle)
        noAllergiesOption.title = .noAllergiesOption
        
        let glutenIntolerantOption = SWAllergiesOptionView(frame: lineRectangle)
        glutenIntolerantOption.title = .glutenIntolerantOption
        
        let wheatIntolerantOption = SWAllergiesOptionView(frame: lineRectangle)
        wheatIntolerantOption.title = .wheatIntolerantOption
        
        let lactoseIntolerantOption = SWAllergiesOptionView(frame: lineRectangle)
        lactoseIntolerantOption.title = .lactoseIntolerantOption
        
        let subviews: [UIView] = [ingredientsHeader, noPreferences, vegan, vegeterian, percetarian, allergiesHeader, noAllergiesOption, glutenIntolerantOption, wheatIntolerantOption, lactoseIntolerantOption]
        
        subviews.forEach({
            if let alignable = $0 as? SWAlignableProtocol {
                alignable.alignSubviews()
            }
            $0.addSizeConstraints()
        })
        
        _ingredients = [noPreferences, vegan, vegeterian, percetarian]
        
        _ingredients.forEach({ $0.onCheck(self, selector: #selector(onIngredientsOptionClick(_:))) })
        
        _allergies = [noAllergiesOption, glutenIntolerantOption, wheatIntolerantOption, lactoseIntolerantOption]
        
        
        _stack = UIStackView(arrangedSubviews: subviews)
        _stack.axis = .vertical
        _stack.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(_stack)
        
        _scroll = UIScrollView(frame: view.bounds)
        _scroll.addSubview(_stack)
        _scroll.contentSize = CGSize(width: 414, height: 892 - 71)
        view.addSubview(_scroll)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    @IBAction private func onIngredientsOptionClick(_ sender: SWIngrigientsOptionView) {
        
        let overcheck: () -> Void = { self._ingredients.forEach({ $0.checked = sender == $0 }) }
        
        UIView.animate(withDuration: 0.112, animations: overcheck)
    }
    
}
