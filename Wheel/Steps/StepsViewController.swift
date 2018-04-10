//
//  StepsViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController {
    
    // MARK: - Public properties
    
    var assembler: SWStepsAssembler!
    
    // MARK: - Private Properties
    
    private var _name: String!
    
    private var _segues: SWSegueRepository!
    
    private var _container: UIView!

    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _name = "Steps"
        
        _segues = assembler.resolve()
        
        //Navigation bar decoration
        do {
            navigationItem.titleView = UILabel.getRecipyTitle(_name)
            
            let back = UIBarButtonItem.back
            navigationItem.leftBarButtonItem = back
            back.action = #selector(onBackButtonClick(_:))
            back.target = self
        }
        
        //container
        do {
            _container = UIView()
            view.addSubview(_container)
            _container.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //i want button
        do {
            let button = UIButton.iwant
            button.addTarget(self, action: #selector(onIWantButtonClick(_:)), for: .touchUpInside)
            _container.addSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: button.frame.height).isActive = true
            button.centerXAnchor.constraint(equalTo: _container.centerXAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: _container.bottomAnchor).isActive = true
            button.widthAnchor.constraint(equalTo: _container.widthAnchor).isActive = true
        }
    }
    
    override func viewWillLayoutSubviews() {
        
        _container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        _container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        _container.topAnchor.constraint(equalTo: view.topAnchor, constant: topLayoutGuide.length).isActive = true
        _container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        super.viewWillLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    
    @IBAction func onBackButtonClick(_ sender: Any) {
        performSegue(withIdentifier: _segues.getStepsToRecipy().identifier, sender: self)
    }
    
    @IBAction func onIWantButtonClick(_ sender: Any) {
        performSegue(withIdentifier: _segues.getStepsToRecipy().identifier, sender: self)
    }

}
