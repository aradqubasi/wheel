//
//  RecipyViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class RecipyViewController: UIViewController, UIScrollViewDelegate {
    
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

    private var _measuresmentRepository: SWMeasuresmentRepository!
    
    private var _ingredientStatsRepository: SWIngredientStatsRepository!
    
    private var _servingsGenerator: SWServingsGenerator!
    
    private var _counter: SWRecipyServingsCounter!
    
    private var _subheader: SWRecipyStatsView!
    
    private var _listGenerator: SWRecipyListGenerator!
    
    private var _list: SWRecipyListView!
    
    private var _scroller: UIScrollView!
    
    private var _broccoli: SWRecipyBroccoliView!
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _name = assembler.resolve().getName(for: selection)
        
        _segues = assembler.resolve()

        _measuresmentRepository = assembler.resolve()
        
        _ingredientStatsRepository = assembler.resolve()
        
        _servingsGenerator = assembler.resolve()
        
        _listGenerator = assembler.resolve()

        view.backgroundColor = UIColor.aquaHaze
        
        _servings = 2
        
        //white background for botom
        do {
            let back = UIView(frame: CGRect(origin: CGPoint(x: 0, y: view.bounds.height * 0.80), size: view.bounds.size))
            back.backgroundColor = .white
            view.addSubview(back)
        }
        
        // scroll
        do {
            _scroller = UIScrollView()
            
            //selection
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
//                    print($0.name)
                    let left = CGFloat(position) * (box.width + innerSpacing.x)
                    let top = CGFloat(line) * (box.height + innerSpacing.y)
                    let next = SWRecipyIngridientView(frame: CGRect(origin: CGPoint(x: left, y: top), size: box), for: $0)
                    next.alignSubviews()
                    _selectionContainer.addSubview(next)
                    position = position + 1
                })
                
                let lines = line + 1
                let width = CGFloat(perLine) * box.width + CGFloat(perLine - 1) * innerSpacing.x
                let height = CGFloat(lines) * box.height + CGFloat(lines - 1) * innerSpacing.y
                _selectionContainer.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
                
            }
            
            // recipy header
            do {
                _recipyHeaderContainer = UIView()
                
                let recipyHeader = UILabel.getRecipyHeader(_name, width: view.bounds.width - 16 * 2)
                _recipyHeaderContainer.addSubview(recipyHeader)
                recipyHeader.translatesAutoresizingMaskIntoConstraints = false
                recipyHeader.addSizeConstraints()
                recipyHeader.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                recipyHeader.topAnchor.constraint(equalTo: _recipyHeaderContainer.topAnchor, constant: 24).isActive = true
                
                do {
                    
                    let energy: Double = _servingsGenerator.getEnergy(for: selection, per: _servings)
                    let proteins: Double = _servingsGenerator.getProteins(for: selection, per: _servings)
                    let fats: Double = _servingsGenerator.getFats(for: selection, per: _servings)
                    let carbohydrates: Double = _servingsGenerator.getCarbs(for: selection, per: _servings)
                    
                    let gram = _measuresmentRepository.getGram()
                    let calories = _measuresmentRepository.getCalories()
                    
                    _subheader = SWRecipyStatsView(energyUnit: calories.short, weightUnit: gram.short)
                    
                    _subheader.set(energy: energy, carbohydrates: carbohydrates, fats: fats, proteins: proteins)
                    
                }
                _recipyHeaderContainer.addSubview(_subheader)
                _subheader.translatesAutoresizingMaskIntoConstraints = false
                _subheader.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                _subheader.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: 16).isActive = true
                _subheader.topAnchor.constraint(equalTo: recipyHeader.bottomAnchor, constant: 8).isActive = true
                _subheader.heightAnchor.constraint(equalToConstant: 17).isActive = true
                
                var line1: UIView!
                do {
                    line1 = UIView().getRecipySeparatorLine(for: view.bounds.width - 16 * 2)
                    _recipyHeaderContainer.addSubview(line1)
                    line1.translatesAutoresizingMaskIntoConstraints = false
                    line1.addSizeConstraints()
                    line1.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                    line1.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
                    line1.topAnchor.constraint(equalTo: _subheader.bottomAnchor, constant: 24).isActive = true
                }
                
                do {
                    _counter = SWRecipyServingsCounter.usual(with: _servingsGenerator)
                    _counter.servings = _servings
                    _recipyHeaderContainer.addSubview(_counter)
                    _counter.translatesAutoresizingMaskIntoConstraints = false
                    _counter.addSizeConstraints()
                    _counter.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 30).isActive = true
                    _counter.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                }
                
                var increase: UIButton!
                do {
                    increase = UIButton.increase
                    _recipyHeaderContainer.addSubview(increase)
                    increase.translatesAutoresizingMaskIntoConstraints = false
                    increase.addSizeConstraints()
                    increase.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 24).isActive = true
                    increase.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
                    increase.addTarget(self, action: #selector(onMore(_:)), for: .touchUpInside)
                }
                
                var decrease: UIButton!
                do {
                    decrease = UIButton.decrease
                    _recipyHeaderContainer.addSubview(decrease)
                    decrease.translatesAutoresizingMaskIntoConstraints = false
                    decrease.addSizeConstraints()
                    decrease.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 24).isActive = true
                    decrease.trailingAnchor.constraint(equalTo: increase.leadingAnchor, constant: 1).isActive = true
                    decrease.addTarget(self, action: #selector(onLess(_:)), for: .touchUpInside)
                }
                
                var line2: UIView!
                do {
                    line2 = UIView().getRecipySeparatorLine(for: view.bounds.width - 16 * 2)
                    _recipyHeaderContainer.addSubview(line2)
                    line2.translatesAutoresizingMaskIntoConstraints = false
                    line2.addSizeConstraints()
                    line2.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                    line2.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
                    line2.topAnchor.constraint(equalTo: decrease.bottomAnchor, constant: 24).isActive = true
                }
                
                var listTitle: UILabel!
                do {
                    listTitle = UILabel.recipyListTitle
                    _recipyHeaderContainer.addSubview(listTitle)
                    listTitle.translatesAutoresizingMaskIntoConstraints = false
                    listTitle.addSizeConstraints()
                    listTitle.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                    listTitle.topAnchor.constraint(equalTo: line2.bottomAnchor, constant: 24).isActive = true
                }
                
                do {
                    _list = SWRecipyListView(for: selection, with: _listGenerator)
                    _recipyHeaderContainer.addSubview(_list)
                    _list.translatesAutoresizingMaskIntoConstraints = false
                    _list.topAnchor.constraint(equalTo: listTitle.bottomAnchor, constant: 8).isActive = true
                    _list.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                    _list.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
                    _list.servings = _servings
                }
                
                var line3: UIView!
                do {
                    line3 = UIView().getRecipySeparatorLine(for: view.bounds.width - 16 * 2)
                    _recipyHeaderContainer.addSubview(line3)
                    line3.translatesAutoresizingMaskIntoConstraints = false
                    line3.addSizeConstraints()
                    line3.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                    line3.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
                    line3.topAnchor.constraint(equalTo: _list.bottomAnchor, constant: 24).isActive = true
                }
                
                var happyCooking: UILabel!
                do {
                    happyCooking = UILabel.happyCooking
                    _recipyHeaderContainer.addSubview(happyCooking)
                    happyCooking.translatesAutoresizingMaskIntoConstraints = false
                    happyCooking.addSizeConstraints()
                    happyCooking.centerXAnchor.constraint(equalTo: _recipyHeaderContainer.centerXAnchor).isActive = true
                    happyCooking.topAnchor.constraint(equalTo: line3.bottomAnchor, constant: 32).isActive = true
                }
                
                _recipyHeaderContainer.backgroundColor = .white
                _recipyHeaderContainer.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 24 + 80 /*subheader:*/ + 8 + 17 /*line1:*/ + 24 + 2 /*counter:*/ + 24 + 32 /*line2:*/ + 24 + 2 /*listTitle:*/ + 24 + 19 /*list:*/ + 8 + _list.frame.height /*line3:*/ + 24 + 2 /*happy cooking:*/ + 32 + 22 /*broccoli pop-up*/ + 16 + 64))
            }
            
            view.addSubview(_scroller)
            _scroller.translatesAutoresizingMaskIntoConstraints = false
            _scroller.delegate = self
            _scroller.showsHorizontalScrollIndicator = false
            
            _scroller.addSubview(_selectionContainer)
            _selectionContainer.centerXAnchor.constraint(equalTo: _scroller.centerXAnchor).isActive = true
            _selectionContainer.translatesAutoresizingMaskIntoConstraints = false
            _selectionContainer.topAnchor.constraint(equalTo: _scroller.topAnchor, constant: 24).isActive = true
            _selectionContainer.addSizeConstraints()
            
            _scroller.addSubview(_recipyHeaderContainer)
            _recipyHeaderContainer.addSizeConstraints()
            _recipyHeaderContainer.translatesAutoresizingMaskIntoConstraints = false
            _recipyHeaderContainer.topAnchor.constraint(equalTo: _selectionContainer.bottomAnchor, constant: 24).isActive = true
            _recipyHeaderContainer.leadingAnchor.constraint(equalTo: _scroller.leadingAnchor).isActive = true
            
            _scroller.contentSize = CGSize(width: _recipyHeaderContainer.frame.size.width, height: 24 + _recipyHeaderContainer.frame.size.height +
                24 + _selectionContainer.frame.size.height)
        }
        
        do {
            _broccoli = SWRecipyBroccoliView()
            view.addSubview(_broccoli)
            _broccoli.translatesAutoresizingMaskIntoConstraints = false
            _broccoli.addSizeConstraints()
            _broccoli.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            _broccoli.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        
        _scroller.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _scroller.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        _scroller.topAnchor.constraint(equalTo: view.topAnchor, constant: topLayoutGuide.length).isActive = true
        _scroller.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        if abs(view.bounds.height - _scroller.contentSize.height - topLayoutGuide.length) < 20 {
            popUpBroccoli()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        
        performSegue(withIdentifier: _segues.getRecipyToWheels().identifier, sender: self)
        
    }
    
    @IBAction func onMore(_ sender: Any) {
        _servings = _servings + 1
        let energy: Double = _servingsGenerator.getEnergy(for: selection, per: _servings)
        let proteins: Double = _servingsGenerator.getProteins(for: selection, per: _servings)
        let fats: Double = _servingsGenerator.getFats(for: selection, per: _servings)
        let carbohydrates: Double = _servingsGenerator.getCarbs(for: selection, per: _servings)
        _subheader.set(energy: energy, carbohydrates: carbohydrates, fats: fats, proteins: proteins)
        _list.servings = _servings
        _counter.servings = _servings
    }
    
    @IBAction func onLess(_ sender: Any) {
        _servings = _servings - 1
        let energy: Double = _servingsGenerator.getEnergy(for: selection, per: _servings)
        let proteins: Double = _servingsGenerator.getProteins(for: selection, per: _servings)
        let fats: Double = _servingsGenerator.getFats(for: selection, per: _servings)
        let carbohydrates: Double = _servingsGenerator.getCarbs(for: selection, per: _servings)
        _subheader.set(energy: energy, carbohydrates: carbohydrates, fats: fats, proteins: proteins)
        _list.servings = _servings
        _counter.servings = _servings
    }

    // MARK: - UIScrollViewDelegate Methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if abs(scrollView.contentOffset.y - abs(scrollView.contentSize.height - scrollView.frame.size.height)) < 5 {
            popUpBroccoli()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState], animations: { self._broccoli.showed = 0 }, completion: nil)
    }
    
    // MARK: - Animations
    
    func popUpBroccoli() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: { self._broccoli.showed = 1 }, completion: nil)
    }
}
