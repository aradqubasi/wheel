//
//  OnboardingViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/01/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var skip: UIButton!
    
    @IBOutlet weak var pager: UIView!
    
    var obey: UIView!
    var leafs: UIView!
    var proteins: UIView!
    var veggies: UIView!
    var fats: UIView!
    var enhancers: UIView!
    
    // MARK: - Public Properties
    
    var state: SWPagerStates {
        get {
            return _state
        }
        set (new) {
            _state = new
            for slide in [obey, leafs, proteins, veggies, fats, enhancers] {
                slide!.frame.origin = CGPoint(x: slide!.frame.width * -1, y: 0)
            }
            switch new {
            case .obey:
                obey.frame.origin = .zero
            case .leafs:
                leafs.frame.origin = .zero
            case .proteins:
                proteins.frame.origin = .zero
            case .veggies:
                veggies.frame.origin = .zero
            case .fats:
                fats.frame.origin = .zero
            case .ehancers:
                enhancers.frame.origin = .zero
            }
        }
    }
    
    // MARK: - Private Properties
    
    private var pagerController: SWPagerController!
    
    private var _state: SWPagerStates!
    
    // MARK: - Initalization

    override func viewDidLoad() {
        super.viewDidLoad()

        //setup gradient on background
        do {
            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.tanhide.cgColor, UIColor.radicalred.cgColor]
            gradient.frame = view.bounds
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
            gradient.locations = [-0.23, 0.15, 0.82]
            view.layer.insertSublayer(gradient, at: 0)
            //-176 109 600 of 736
        }
        
        //setup pager
        do {
            pagerController = SWPagerController(pager)
        }
        
        //setup sliders
        do {
            obey = SWObeySlideView(frame: view.bounds)
            view.addSubview(obey)
            
            leafs = SWLeafsSlideView(frame: view.bounds)
            view.addSubview(leafs)
            
            proteins = SWProteinsSlideView(frame: view.bounds)
            view.addSubview(proteins)
            
            veggies = SWVeggiesSlideView(frame: view.bounds)
            view.addSubview(veggies)
            
            fats = SWFatsSlideView(frame: view.bounds)
            view.addSubview(fats)
            
            enhancers = SWEnhancersSlideView(frame: view.bounds)
            view.addSubview(enhancers)
        }
        
        //setup test buttons
        do {
            let prev = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 16), size: CGSize(width: 32, height: 32)))
            prev.setTitle("<", for: .normal)
            prev.addTarget(self, action: #selector(onPrev(_:)), for: .touchUpInside)
            view.addSubview(prev)
            
            let next = UIButton(frame: CGRect(origin: CGPoint(x: view.bounds.width - 32, y: 16), size: CGSize(width: 32, height: 32)))
            next.setTitle(">", for: .normal)
            next.addTarget(self, action: #selector(onNext(_:)), for: .touchUpInside)
            view.addSubview(next)
        }
        
        state = .obey
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    @IBAction private func onNext(_ sender: UIButton) {
        print("next")
        switch state {
        case .obey:
            state = .leafs
        case .leafs:
            state = .proteins
        case .proteins:
            state = .veggies
        case .veggies:
            state = .fats
        case .fats:
            state = .ehancers
        case .ehancers:
            state = .obey
        }
    }
    
    @IBAction private func onPrev(_ sender: UIButton) {
        print("prev")
        switch state {
        case .obey:
            state = .ehancers
        case .leafs:
            state = .obey
        case .proteins:
            state = .leafs
        case .veggies:
            state = .proteins
        case .fats:
            state = .veggies
        case .ehancers:
            state = .fats
        }
    }
    
    // MARK: - Private Methods
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
