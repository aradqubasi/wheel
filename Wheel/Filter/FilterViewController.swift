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
    
    private var _noAllergies: SWAllergiesOptionView!
    
    private var _back: UIBarButtonItem!
    
    private var _ok: UIButton!
    
    // MARK: - Dependencies
    
    var repository: SWOptionRepository!
    
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
        
        _allergies.forEach({ $0.onCheck(self, selector: #selector(onAllergiesOptionClick(_:))) })
        
        _noAllergies = noAllergiesOption
        
        
        _stack = UIStackView(arrangedSubviews: subviews)
        
//        for index in 0..<subviews.count {
//            let subview = subviews[index]
//
//            if index == 0 {
//                subview.topAnchor.constraint(equalTo: _stack.topAnchor).isActive = true
//            }
//            else {
//                subview.topAnchor.constraint(equalTo: subviews[index - 1].bottomAnchor).isActive = true
//            }
//            subview.leadingAnchor.constraint(equalTo: _stack.leadingAnchor).isActive = true
//            if let alignable = subview as? SWAlignableProtocol {
//                alignable.alignSubviews()
//            }
//            subview.addSizeConstraints()
//            print("intristic size of \(index) is \(subview.intrinsicContentSize)")
//        }
        
        _stack.axis = .vertical
        _stack.translatesAutoresizingMaskIntoConstraints = false
        print("_stack.intrinsicContentSize = \(_stack.intrinsicContentSize)")
        
//        view.addSubview(_stack)
        
//        _scroll = UIScrollView(frame: view.bounds)
        _scroll = UIScrollView()
        view.addSubview(_scroll)
        _scroll.addSubview(_stack)
        _scroll.translatesAutoresizingMaskIntoConstraints = false
        _stack.leadingAnchor.constraint(equalTo: _scroll.leadingAnchor).isActive = true
        _scroll.addBoundsConstraints()
        
        _stack.trailingAnchor.constraint(equalTo: _scroll.trailingAnchor).isActive = true
        _stack.bottomAnchor.constraint(equalTo: _scroll.bottomAnchor).isActive = true
        _stack.topAnchor.constraint(equalTo: _scroll.topAnchor).isActive = true
        _stack.widthAnchor.constraint(equalTo: _scroll.widthAnchor).isActive = true
        
        print("_scroll.contentSize = \(_scroll.contentSize)")
//        _scroll.contentSize = CGSize(width: 414, height: 892 - 71)
//        view.addSubview(_scroll)
        
        let _back = UIBarButtonItem.back
        _back.target = self
        _back.action = #selector(onBackButtonClick(_:))
        navigationItem.leftBarButtonItem = _back
        
        navigationItem.titleView = UILabel.filterTitle
        
        _ok = UIButton.ok
        view.addSubview(_ok)
        _ok.translatesAutoresizingMaskIntoConstraints = false
        _ok.addSizeConstraints()
        _ok.addCenterBottomConstraints()
        _ok.addTarget(self, action: #selector(onOkButtonClick(_:)), for: .touchUpInside)
        
        view.constraints.filter({ $0.firstAttribute == .bottom && $0.firstItem === _scroll }).first!.isActive = false
        _scroll.bottomAnchor.constraint(equalTo: _ok.topAnchor).isActive = true
        
        repository.getAll().forEach({ print($0.name) })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    @IBAction private func onIngredientsOptionClick(_ sender: SWIngrigientsOptionView) {
        
        let overcheck: () -> Void = { self._ingredients.forEach({ $0.checked = sender == $0 }) }
        
        UIView.animate(withDuration: 0.225, animations: overcheck)
    }
    
    @IBAction private func onAllergiesOptionClick(_ sender: SWAllergiesOptionView) {
        if sender == _noAllergies && sender.checked {
            _allergies.forEach({ $0.checked = $0 == sender })
        }
        else if sender != _noAllergies && _noAllergies.checked {
            _allergies.forEach({ $0.checked = $0 == _noAllergies ? false : $0.checked })
        }
    }
    
    @IBAction private func onBackButtonClick(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "FilterToWheels", sender: self)
        
    }
    
    @IBAction private func onOkButtonClick(_ sender: UIButton) {
        
        performSegue(withIdentifier: "FilterToWheels", sender: self)
        
    }
//    @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
//
//        //code
//
//    }
    
}
