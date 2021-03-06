//
//  RecipyViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class RecipyViewController: SWTransitioningViewController, UIScrollViewDelegate {
    
    // MARK: - Public Properties
    
    var assembler: SWRecipyAssembler!
    
    var selection: SWRecipy!
    
    var showLikeButton: Bool = false
    
    var showDeleteButton: Bool = false
    
    var showSaveButton: Bool = false
    
    // MARK: - Private Properties
    
    private var _selectionViews: [SWRecipyIngridientView]!
    
    private var _selectionContainer: UIView!
    
    private var _recipyHeaderContainer: UIView!
    
    private var _servingsGenerator: SWServingsGenerator!
    
    private var _counter: SWRecipyServingsCounter!
    
    private var _subheader: SWRecipyStatsView!
    
    private var _listGenerator: SWRecipyListGenerator!
    
    private var _list: SWRecipyListView!
    
    private var _scroller: UIScrollView!
    
    private var _broccoli: SWRecipyBroccoliView!
    
    private var like: UIButton!

    // MARK - Repositories
    
    private var measuresments: SWMeasuresmentRepository!
    
    private var ingredients: SWIngredientRepository!
    
    private var recipies: SWRecipyRepository!
    
    // MARK: - Initialization

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segues = assembler.resolve()

        self.measuresments = assembler.resolve()
        
        self._servingsGenerator = assembler.resolve()
        
        self._listGenerator = assembler.resolve()
        
        self.recipies = assembler.resolve()
        
        self.ingredients = assembler.resolve()
        
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
                
                self
                    .selection
                    .ingredients
                    .join(
                        with: ingredients.getAll(), on: {
                            (inner: Int, outer: SWIngredient) -> Bool in
                            return inner == outer.id
                        }, as: {
                            (inner: Int, outer: SWIngredient) -> SWIngredient in
                            return outer
                        }
                    )
                    .forEach({
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
                
                let recipyHeader = UILabel.getRecipyHeader(self.selection.name, width: view.bounds.width - 16 * 2)
                _recipyHeaderContainer.addSubview(recipyHeader)
                recipyHeader.translatesAutoresizingMaskIntoConstraints = false
                recipyHeader.addSizeConstraints()
                recipyHeader.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                recipyHeader.topAnchor.constraint(equalTo: _recipyHeaderContainer.topAnchor, constant: 24).isActive = true
                
                do {
                
                    let gram = self.measuresments.getGram()
                    let calories = self.measuresments.getCalories()
                    
                    _subheader = SWRecipyStatsView(energyUnit: calories.short, weightUnit: gram.short)
                    
                    _subheader.set(
                        energy: self.selection.calories,
                        carbohydrates: self.selection.carbohydrates,
                        fats: self.selection.fats,
                        proteins: self.selection.proteins)
                    
                }
                _recipyHeaderContainer.addSubview(_subheader)
                _subheader.translatesAutoresizingMaskIntoConstraints = false
                _subheader.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                _subheader.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: 16).isActive = true
                _subheader.topAnchor.constraint(equalTo: recipyHeader.bottomAnchor, constant: 8).isActive = true
                _subheader.heightAnchor.constraint(equalToConstant: 17).isActive = true
                
                var preLine1: UIView = _subheader
                
                if self.showLikeButton || self.showDeleteButton {
                    if self.showLikeButton {
                        do {
                            like = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 56)))
                            _recipyHeaderContainer.addSubview(like)
                            like.translatesAutoresizingMaskIntoConstraints = false
                            like.backgroundColor = .shamrock
                            like.layer.cornerRadius = 28
                            like.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -24).isActive = true
                            like.topAnchor.constraint(equalTo: _subheader.bottomAnchor, constant: 24).isActive = true
                            like.addSizeConstraints()
                            like.addTarget(self, action: #selector(onLikeRecipyClick(_:)), for: .touchUpInside)
                            self.setSaveRecipyButtonState()
                            
                            preLine1 = like
                        }
                    }
                    
                    if self.showDeleteButton {
                        var delete: UIButton!
                        do {
                            delete = UIButton(frame: CGRect(origin: .zero, size: CGSize(side: 56)))
                            _recipyHeaderContainer.addSubview(delete)
                            delete.translatesAutoresizingMaskIntoConstraints = false
//                            delete.backgroundColor = .blue
                            delete.setImage(#imageLiteral(resourceName: "recipy/delete"), for: .normal)
                            if showLikeButton {
                                delete.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -24 + -56 + -24).isActive = true
                            }
                            else {
                                delete.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -24).isActive = true
                            }
                            delete.topAnchor.constraint(equalTo: _subheader.bottomAnchor, constant: 24).isActive = true
                            delete.addSizeConstraints()
                            delete.addTarget(self, action: #selector(onDeleteRecipyClick(_:)), for: .touchUpInside)
                            
                            preLine1 = delete
                        }
                    }
                }

                var line1: UIView!
                do {
                    line1 = UIView().getRecipySeparatorLine(for: view.bounds.width - 16 * 2)
                    _recipyHeaderContainer.addSubview(line1)
                    line1.translatesAutoresizingMaskIntoConstraints = false
                    line1.addSizeConstraints()
                    line1.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                    line1.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
                    line1.topAnchor.constraint(equalTo: preLine1.bottomAnchor, constant: 24).isActive = true
                }
                
                do {
                    _counter = SWRecipyServingsCounter.usual(with: _servingsGenerator)
                    _counter.servings = self.selection.servings
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
                    _list = SWRecipyListView(
                        for: self
                            .selection
                            .ingredients
                            .join(with: self.ingredients.getAll(), on: {
                                (inner: Int, outer: SWIngredient) -> Bool in
                                return inner == outer.id
                            }, as: {
                                (inner: Int, outer: SWIngredient) -> SWIngredient in
                                return outer
                            }),
                        with: _listGenerator)
                    _recipyHeaderContainer.addSubview(_list)
                    _list.translatesAutoresizingMaskIntoConstraints = false
                    _list.topAnchor.constraint(equalTo: listTitle.bottomAnchor, constant: 8).isActive = true
                    _list.leadingAnchor.constraint(equalTo: _recipyHeaderContainer.leadingAnchor, constant: 16).isActive = true
                    _list.trailingAnchor.constraint(equalTo: _recipyHeaderContainer.trailingAnchor, constant: -16).isActive = true
                    _list.servings = self.selection.servings
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
                
                var preHappyCooking: UIView = line3
                
                if self.showSaveButton {
                    var saveRecipy: UIButton!
                    do {
                        saveRecipy = UIButton.saveRecipy
                        _recipyHeaderContainer.addSubview(saveRecipy)
                        saveRecipy.translatesAutoresizingMaskIntoConstraints = false
                        saveRecipy.addSizeConstraints()
                        saveRecipy.topAnchor.constraint(equalTo: line3.bottomAnchor, constant: 24).isActive = true
                        saveRecipy.centerXAnchor.constraint(equalTo: _recipyHeaderContainer.centerXAnchor).isActive = true
                        saveRecipy.addTarget(self, action: #selector(onSaveRecipyClick(_:)), for: .touchUpInside)
                        
                        preHappyCooking = saveRecipy
                    }
                }
                
                var happyCooking: UILabel!
                do {
                    happyCooking = UILabel.happyCooking
                    _recipyHeaderContainer.addSubview(happyCooking)
                    happyCooking.translatesAutoresizingMaskIntoConstraints = false
                    happyCooking.addSizeConstraints()
                    happyCooking.centerXAnchor.constraint(equalTo: _recipyHeaderContainer.centerXAnchor).isActive = true
                    happyCooking.topAnchor.constraint(equalTo: preHappyCooking.bottomAnchor, constant: 32).isActive = true
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
                _recipyHeaderContainer.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 24 + /*recipy header*/ recipyHeader.frame.height /*subheader:*/ + 8 + 17 /*like & delete*/ + (self.showLikeButton || self.showDeleteButton ? (24 + 56) : 0) /*line1:*/ + 24 + 2 /*counter:*/ + 24 + 32 /*line2:*/ + 24 + 2 /*listTitle:*/ + 24 + 19 /*list:*/ + 8 + _list.frame.height /*line3:*/ + 24 + 2 /*save recipy*/ + (self.showSaveButton ? (24 + 56) : 0) /*happy cooking:*/ + 32 + 22 /*broccoli pop-up*/ + 18 + 64))
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
            navigationItem.titleView = UILabel.getRecipyTitle(self.selection.name)
            
            let back = UIBarButtonItem.back
            navigationItem.leftBarButtonItem = back
            back.action = #selector(onBackClick(sender:))
            back.target = self
        }

        do {
            self.swiper = SWDismissRecipyGestureRecognizer(target: self, action: #selector(onSwipe(sender:)))
            self._scroller.gestureRecognizers?.forEach({ $0.require(toFail: self.swiper) })
            self._scroller.addGestureRecognizer(self.swiper)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    // MARK: - Private Methods
    
    private func setSaveRecipyButtonState() {
        if let recipy = self.selection, let like = self.like {
            if recipy.liked {
                like.setImage(#imageLiteral(resourceName: "recipy/heart_full"), for: .normal)
            }
            else {
                like.setImage(#imageLiteral(resourceName: "recipy/heart_empty"), for: .normal)
            }
        }
    }
    
    // MARK: - Actions

    @IBAction private func onSaveRecipyClick(_ sender: Any) {
        do {
            var recipy = self.selection!
            recipy.servings = self.selection.servings
            self.recipies.save(recipy)
            self.recipies.setBookmark(recipy)
            //perform(segue: self.segues.getRecipyToWheels())
            self.perform(segue: self.backSegue)
        }
    }
    
    @IBAction private func onLikeRecipyClick(_ sender: Any) {
        self.selection.liked = !self.selection.liked
        self.setSaveRecipyButtonState()
        if !showSaveButton {
            self.recipies.save(self.selection)
        }
    }
    
    @IBAction private func onDeleteRecipyClick(_ sender: Any) {
        if let id = self.selection.id {
            self.recipies.removeBy(id: id)
        }
        self.perform(segue: self.backSegue)
    }

    @IBAction func onMore(_ sender: Any) {
        self.selection.servings = self.selection.servings + 1
        _subheader.set(
            energy: self.selection.calories,
            carbohydrates: self.selection.carbohydrates,
            fats: self.selection.fats,
            proteins: self.selection.proteins)
        _list.servings = self.selection.servings
        _counter.servings = self.selection.servings
    }
    
    @IBAction func onLess(_ sender: Any) {
        self.selection.servings = max(self.selection.servings - 1, 1)
        _subheader.set(
            energy: self.selection.calories,
            carbohydrates: self.selection.carbohydrates,
            fats: self.selection.fats,
            proteins: self.selection.proteins)
        _list.servings = self.selection.servings
        _counter.servings = self.selection.servings
    }

    // MARK: - UIScrollViewDelegate Methods
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var insets: CGFloat = 0
        if #available(iOS 11.0, *) {
            insets = scrollView.adjustedContentInset.bottom + scrollView.adjustedContentInset.top
        }
        if abs(scrollView.contentOffset.y - abs(scrollView.contentSize.height - (scrollView.frame.size.height - insets))) < 5 {
            popUpBroccoli()
        }
    }
    
    // MARK: - Animations
    
    func popUpBroccoli() {
        UIView.animate(withDuration: 0.225, delay: 0, options: [.curveEaseInOut], animations: { self._broccoli.showed = 1 }, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case segues.getRecipyToSteps().identifier:
            print("RecipyToSteps")
//            _dismisser = nil
            (segue.destination as? StepsViewController)?.assembler = self.assembler.resolve()
            break
        case segues.getRecipyToWheelsWithSwipe().identifier:
            print("RecipyToWheelsWithSwipe")
            break
        case segues.getRecipyToWheels().identifier:
            print("RecipyToWheels")
//            _dismisser = nil
            break
        case segues.getRecipyToHistory().identifier, segues.getRecipyToHistoryWithSwipe().identifier:
            print("back to history")
        default:
            fatalError("Unrecognized segue \(segue.identifier ?? "empty")")
        }
    }
    
    @IBAction func unwindToRecipy(segue: UIStoryboardSegue) {
        print("unwindToRecipy")
    }

}
