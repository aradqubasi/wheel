//
//  FilterViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 10/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    // MARK: - Subviews
    
    private var _stack: UIStackView!
    
    private var _scroll: UIScrollView!
    
    private var _ingredients: [SWIngrigientsOptionView : SWOption]!
    
    private var _noPreferences: SWIngrigientsOptionView!
    
    private var _allergies: [SWAllergiesOptionView : SWOption]!
    
    private var _noAllergies: SWAllergiesOptionView!
    
    private var _back: UIBarButtonItem!
    
    private var _ok: UIButton!
    
    private var _swiper: UISwipeGestureRecognizer!
    
    // MARK: - Dependencies
    
    var assembler: SWFilterAssembler!
    
    private var _options: SWOptionRepository!

    private var _segues: SWSegueRepository!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        print("on FilterViewController viewDidLoad()")
        super.viewDidLoad()
        
        _options = assembler.resolve()
        
        _segues = assembler.resolve()

        do {
            _swiper = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeBack(_:)))
            _swiper.direction = .right
            view.addGestureRecognizer(_swiper)
            
        }
        
        let headerRectangle = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 35))
        
        let lineRectangle = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 83))
        
        let ingredientsHeader = SWHeaderOptionView(frame: headerRectangle)
        ingredientsHeader.title = .ingredientsHeader
        
        _ingredients = _options.getAll(by: .ingredient).reduce([SWIngrigientsOptionView : SWOption](), { (result, next) -> [SWIngrigientsOptionView : SWOption] in
            var result = result
            let view = SWIngrigientsOptionView(frame: lineRectangle)
            view.title = next.name.toFilterOptionCaption
//            view.checked = next.checked
            view.order = next.id!
            view.onCheck(self, selector: #selector(onIngredientsOptionClick(_:)))
            result[view] = next
            return result
        })
        
        let noPreferences = SWIngrigientsOptionView(frame: lineRectangle)
        noPreferences.title = .noFoodPreferencesOption
        noPreferences.onCheck(self, selector: #selector(onNoPreferenceClick(_:)))
//        noPreferences.checked = _ingredients.first(where: { $0.key.checked }) == nil
        _noPreferences = noPreferences
        
        let allergiesHeader = SWHeaderOptionView(frame: headerRectangle)
        allergiesHeader.title = .allergiesHeader
        
        _allergies = _options.getAll(by: .allergy).reduce([SWAllergiesOptionView : SWOption](), { (result, next) -> [SWAllergiesOptionView : SWOption] in
            var result = result
            let view = SWAllergiesOptionView(frame: lineRectangle)
            view.title = next.name.toFilterOptionCaption
            view.checked = next.checked
            view.order = next.id!
            view.onCheck(self, selector: #selector(onAllergiesOptionClick(_:)))
            result[view] = next
            return result
        })
        
        let noAllergiesOption = SWAllergiesOptionView(frame: lineRectangle)
        noAllergiesOption.title = .noAllergiesOption
        noAllergiesOption.onCheck(self, selector: #selector(onAllergiesOptionClick(_:)))
        noAllergiesOption.checked = _allergies.first(where: { $0.key.checked }) == nil
        _noAllergies = noAllergiesOption

        var subviews: [UIView] = []
        subviews.append(contentsOf: [ingredientsHeader, noPreferences])
        subviews.append(contentsOf: _ingredients.map({ $0.key }).sorted(by: {(prev, next) -> Bool in return prev.order < next.order }).map({ $0 as UIView }))
        subviews.append(contentsOf: [allergiesHeader, noAllergiesOption])
        subviews.append(contentsOf: _allergies.map({ $0.key }).sorted(by: {(prev, next) -> Bool in return prev.order < next.order }).map({ $0 as UIView }))
        
        subviews.forEach({
            if let alignable = $0 as? SWAlignableProtocol {
                alignable.alignSubviews()
            }
            $0.addSizeConstraints()
        })
        
        _stack = UIStackView(arrangedSubviews: subviews)
        
        _stack.axis = .vertical
        _stack.translatesAutoresizingMaskIntoConstraints = false
        
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
        
//        repository.getAll().forEach({ print($0.name) })
        _ingredients.forEach({ $0.key.checked = $0.value.checked })
        noPreferences.checked = _ingredients.first(where: { $0.key.checked }) == nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Actions
    
    @IBAction private func onNoPreferenceClick(_ sender: SWIngrigientsOptionView) {

        let overcheck: () -> Void = {
            self._ingredients.forEach({ $0.key.checked = false })
            self._noPreferences.checked = true
        }
        
        UIView.animate(withDuration: 0.225, animations: overcheck)
    }
    
    @IBAction private func onIngredientsOptionClick(_ sender: SWIngrigientsOptionView) {
        
        let overcheck: () -> Void = {
            self._ingredients.forEach({ $0.key.checked = sender == $0.key })
            self._noPreferences.checked = false
        }
        
        UIView.animate(withDuration: 0.225, animations: overcheck)
    }
    
    @IBAction private func onAllergiesOptionClick(_ sender: SWAllergiesOptionView) {
        if sender == _noAllergies && sender.checked {
            _allergies.forEach({ $0.key.checked = $0.key == sender })
        }
        else if sender != _noAllergies && _noAllergies.checked {
            _allergies.forEach({ $0.key.checked = $0.key == _noAllergies ? false : $0.key.checked })
            _noAllergies.checked = false
        }
    }
    
    @IBAction private func onBackButtonClick(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: _segues.getFilterToWheels().identifier, sender: self)
    }
    
    @IBAction private func onSwipeBack(_ sender: Any) {
        performSegue(withIdentifier: _segues.getFilterToWheels().identifier, sender: self)
    }
    
    @IBAction private func onOkButtonClick(_ sender: UIButton) {
        
        _ingredients.forEach({
            let view = $0.key
            var model = $0.value
            model.checked = view.checked
            _options.save(model)
        })
        _allergies.forEach({
            let view = $0.key
            var model = $0.value
            model.checked = view.checked
            _options.save(model)
        })
        performSegue(withIdentifier: _segues.getFilterToWheels().identifier, sender: self)
        
    }
}
