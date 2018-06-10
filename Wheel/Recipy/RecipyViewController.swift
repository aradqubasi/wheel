//
//  RecipyViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class RecipyViewController: UIViewController, UIScrollViewDelegate, SWDismissableViewController {
    
    // MARK: - Public Properties
    
    var assembler: SWRecipyAssembler!
    
    var selection: [SWIngredient]!
    
    // MARK: - Private Properties
    
//    private var _swiper: UISwipeGestureRecognizer!
    
    private var _swiper: SWSwipeGestureRecognizer!
    
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
    
    private var _dismisser: SWSwipeInteractiveTransition?
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _name = assembler.resolve().getName(for: selection)
        
        _segues = assembler.resolve()

        _measuresmentRepository = assembler.resolve()
        
        _ingredientStatsRepository = assembler.resolve()
        
        _servingsGenerator = assembler.resolve()
        
        _listGenerator = assembler.resolve()

//        view.backgroundColor = UIColor.aquaHaze
        
        _servings = 2
        
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
                let perLine = Int((view.bounds.width /*+ innerSpacing.x*/ - outerSpacing.x * 2) / (box.width + innerSpacing.x))
                var line: Int = 0
                var position: Int = 0
                
                selection?.forEach({
                    if position >= perLine && position != 0 {
                        position = 0
                        line = line + 1
                    }
                    let left = CGFloat(position) * (box.width + innerSpacing.x) + outerSpacing.x + (view.bounds.width - box.width * CGFloat(perLine) - innerSpacing.x * (CGFloat(perLine) - 1) - outerSpacing.x * 2) * 0.5
                    let top = CGFloat(line) * (box.height + innerSpacing.y) + outerSpacing.y
                    let next = SWRecipyIngridientView(frame: CGRect(origin: CGPoint(x: left, y: top), size: box), for: $0)
                    next.alignSubviews()
                    _selectionContainer.addSubview(next)
                    position = position + 1
                })
                
                let lines = line + 1
                let width = view.bounds.width
                let height = 24 + CGFloat(lines) * box.height + CGFloat(lines - 1) * innerSpacing.y + 24
                _selectionContainer.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height))
                
                _selectionContainer.backgroundColor = .aquaHaze
                
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
                    increase = SWMoreButton()
                    _recipyHeaderContainer.addSubview(increase)
                    increase.translatesAutoresizingMaskIntoConstraints = false
                    increase.addSizeConstraints()
                    increase.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 24).isActive = true
                    increase.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
                    increase.addTarget(self, action: #selector(onMore(_:)), for: .touchUpInside)
                }
                
                var decrease: UIButton!
                do {
                    decrease = SWLessButton()
                    _recipyHeaderContainer.addSubview(decrease)
                    decrease.translatesAutoresizingMaskIntoConstraints = false
                    decrease.addSizeConstraints()
                    decrease.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 24).isActive = true
                    decrease.trailingAnchor.constraint(equalTo: increase.leadingAnchor, constant: 2).isActive = true
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
                
                var showSteps: UIButton!
                do {
                    showSteps = UIButton.showSteps
                    _recipyHeaderContainer.addSubview(showSteps)
                    showSteps.translatesAutoresizingMaskIntoConstraints = false
                    showSteps.addSizeConstraints()
                    showSteps.topAnchor.constraint(equalTo: line3.bottomAnchor, constant: 24).isActive = true
                    showSteps.centerXAnchor.constraint(equalTo: _recipyHeaderContainer.centerXAnchor).isActive = true
                    showSteps.addTarget(self, action: #selector(onShowStepsClick(_:)), for: .touchUpInside)
                }
                
                var happyCooking: UILabel!
                do {
                    happyCooking = UILabel.happyCooking
                    _recipyHeaderContainer.addSubview(happyCooking)
                    happyCooking.translatesAutoresizingMaskIntoConstraints = false
                    happyCooking.addSizeConstraints()
                    happyCooking.centerXAnchor.constraint(equalTo: _recipyHeaderContainer.centerXAnchor).isActive = true
                    happyCooking.topAnchor.constraint(equalTo: showSteps.bottomAnchor, constant: 32).isActive = true
                }
                
                do {
                    _broccoli = SWRecipyBroccoliView()
                    _recipyHeaderContainer.addSubview(_broccoli)
                    _broccoli.translatesAutoresizingMaskIntoConstraints = false
                    _broccoli.addSizeConstraints()
                    _broccoli.centerXAnchor.constraint(equalTo: _recipyHeaderContainer.centerXAnchor).isActive = true
                    _broccoli.topAnchor.constraint(equalTo: happyCooking.bottomAnchor, constant: 19).isActive = true
                }
                
                _recipyHeaderContainer.backgroundColor = .white
                _recipyHeaderContainer.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 24 + /*recipy header*/ recipyHeader.frame.height /*subheader:*/ + 8 + 17 /*line1:*/ + 24 + 2 /*counter:*/ + 24 + 32 /*line2:*/ + 24 + 2 /*listTitle:*/ + 24 + 19 /*list:*/ + 8 + _list.frame.height /*line3:*/ + 24 + 2 /*show steps*/ + 24 + showSteps.frame.height /*happy cooking:*/ + 32 + 22 /*broccoli pop-up*/ + 18 + 64))
            }
            
            view.addSubview(_scroller)
            _scroller.translatesAutoresizingMaskIntoConstraints = false
            _scroller.delegate = self
            _scroller.showsHorizontalScrollIndicator = false
            
            _scroller.addSubview(_selectionContainer)
            _selectionContainer.centerXAnchor.constraint(equalTo: _scroller.centerXAnchor).isActive = true
            _selectionContainer.translatesAutoresizingMaskIntoConstraints = false
            _selectionContainer.topAnchor.constraint(equalTo: _scroller.topAnchor).isActive = true
            _selectionContainer.addSizeConstraints()
            
            _scroller.addSubview(_recipyHeaderContainer)
            _recipyHeaderContainer.addSizeConstraints()
            _recipyHeaderContainer.translatesAutoresizingMaskIntoConstraints = false
            _recipyHeaderContainer.topAnchor.constraint(equalTo: _selectionContainer.bottomAnchor).isActive = true
            _recipyHeaderContainer.leadingAnchor.constraint(equalTo: _scroller.leadingAnchor).isActive = true
            _scroller.contentSize = CGSize(width: _recipyHeaderContainer.frame.size.width, height: _recipyHeaderContainer.frame.size.height + _selectionContainer.frame.size.height)
        }
        
        do {
            navigationItem.titleView = UILabel.getRecipyTitle(_name)
            
            let back = UIBarButtonItem.back
            navigationItem.leftBarButtonItem = back
            back.action = #selector(onBackButtonClick(_:))
            back.target = self
        }
        
        //swipe to wheels
//        do {
//            _swiper = SWSwipeGestureRecognizer(target: self, action: #selector(onSwipeBack(_:)))
//            _scroller.gestureRecognizers?.forEach({ $0.require(toFail: _swiper) })
//            _scroller.addGestureRecognizer(_swiper)
//        }
        do {
            _dismisser = SWSwipeInteractiveTransition({() -> Void in
                self.performSegue(withIdentifier: self._segues.getRecipyToWheelsWithSwipe().identifier, sender: self)
            })
            _swiper = SWSwipeGestureRecognizer()
            _swiper.Delegate = _dismisser
            _scroller.gestureRecognizers?.forEach({ $0.require(toFail: _swiper) })
            _scroller.addGestureRecognizer(_swiper)
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
    
//    @IBAction func onSwipeBack(_ sender: Any) {
//        performSegue(withIdentifier: _segues.getRecipyToWheels().identifier, sender: self)
//    }
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        if _swiper.state != .began && _swiper.state != .changed && _swiper.state != .ended {
            performSegue(withIdentifier: _segues.getRecipyToWheels().identifier, sender: self)
        }
    }
    
    @IBAction func onShowStepsClick(_ sender: Any) {
        print("state is \(_swiper.state.rawValue)")
//        if _swiper.state != .began && _swiper.state != .changed && _swiper.state != .ended {
//            performSegue(withIdentifier: _segues.getRecipyToSteps().identifier, sender: self)
//        }
        
//        if _swiper.IsIdle {
//            performSegue(withIdentifier: _segues.getRecipyToSteps().identifier, sender: self)
//        }
        print("\(_dismisser?.percentComplete)")
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(transit), userInfo: nil, repeats: false)
        transit()
    }
    
    @IBAction func transit() {
        self.performSegue(withIdentifier: self._segues.getRecipyToSteps().identifier, sender: self)
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
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState], animations: {
//            self._broccoli.showed = 0
        }, completion: nil)
    }
    
    // MARK: - Animations
    
    func popUpBroccoli() {
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: { self._broccoli.showed = 1 }, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case _segues.getRecipyToSteps().identifier:
            print("RecipyToSteps")
            _dismisser = nil
            (segue.destination as? StepsViewController)?.assembler = self.assembler.resolve()
            break
        case _segues.getRecipyToWheelsWithSwipe().identifier:
            print("RecipyToWheelsWithSwipe")
            break
        case _segues.getRecipyToWheels().identifier:
            print("RecipyToWheels")
            _dismisser = nil
            break
        default:
            fatalError("Unrecognized segue \(segue.identifier ?? "empty")")
        }
    }
    
    @IBAction func unwindToRecipy(segue: UIStoryboardSegue) {
        print("unwindToRecipy")
    }
    
    // MARK: - SWDismissableViewController Methods
    
    func interactionControllerForDismissal() -> UIViewControllerInteractiveTransitioning? {
        return _dismisser
    }
}
