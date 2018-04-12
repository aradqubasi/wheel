//
//  StepsViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Public properties
    
    var assembler: SWStepsAssembler!
    
    // MARK: - Private Properties
    
    private var _name: String!
    
    private var _segues: SWSegueRepository!
    
    private var _container: UIView!
    
    private var _feedback: SWFeedbackService!
    
    // MARK: - Outlets
    
    private var email: UITextField!
    
    private var isAnonymous: UISwitch!

    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _name = "Steps"
        
        _segues = assembler.resolve()
        
        _feedback = assembler.resolve()
        
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
        
        //construction sign
        var sign: UIImageView!
        do {
            sign = UIImageView(image: UIImage.happy_broccoli)
            _container.addSubview(sign)
            
            sign.translatesAutoresizingMaskIntoConstraints = false
            sign.addSizeConstraints()
            sign.centerXAnchor.constraint(equalTo: _container.centerXAnchor).isActive = true
            sign.topAnchor.constraint(equalTo: _container.topAnchor, constant: 24).isActive = true
        }
        
        var explanation: UILabel!
        do {
            explanation = UILabel.stepsExplanation(estimated: view.bounds.width - 24 * 2)
            _container.addSubview(explanation)
            
            explanation.translatesAutoresizingMaskIntoConstraints = false
            explanation.addSizeConstraints()
            explanation.centerXAnchor.constraint(equalTo: _container.centerXAnchor).isActive = true
            explanation.topAnchor.constraint(equalTo: sign.bottomAnchor, constant: 24).isActive = true
        }
        
        //email input
//        var email: UITextField!
        do {
            email = .email
            email.delegate = self
            _container.addSubview(email)
            
            email.translatesAutoresizingMaskIntoConstraints = false
            email.addHeightConstraints()
            email.topAnchor.constraint(equalTo: explanation.bottomAnchor, constant: 16).isActive = true
            email.leadingAnchor.constraint(equalTo: _container.leadingAnchor, constant: 24).isActive = true
            email.trailingAnchor.constraint(equalTo: _container.trailingAnchor, constant: -24).isActive = true
        }
        
        var line: UIView!
        do {
            line = UIView()
            line.backgroundColor = .shamrock
            _container.addSubview(line)
            
            line.translatesAutoresizingMaskIntoConstraints = false
            line.heightAnchor.constraint(equalToConstant: 1).isActive = true
            line.widthAnchor.constraint(equalTo: _container.widthAnchor, constant: -24 * 2).isActive = true
            line.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 1).isActive = true
            line.leadingAnchor.constraint(equalTo: _container.leadingAnchor, constant: 24).isActive = true
            line.trailingAnchor.constraint(equalTo: _container.trailingAnchor, constant: -24).isActive = true
        }
        
//        var isAnonymous: UISwitch!
        do {
            isAnonymous = UISwitch()
            _container.addSubview(isAnonymous)
            
            isAnonymous.translatesAutoresizingMaskIntoConstraints = false
            isAnonymous.addSizeConstraints()
            isAnonymous.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 24).isActive = true
            isAnonymous.leadingAnchor.constraint(equalTo: _container.leadingAnchor, constant: 24).isActive = true
        }
        
        var isAnonymousLabel: UILabel!
        do {
            isAnonymousLabel = .isAnonymousLabel
            _container.addSubview(isAnonymousLabel)
            
            isAnonymousLabel.translatesAutoresizingMaskIntoConstraints = false
            isAnonymousLabel.addSizeConstraints()
            isAnonymousLabel.centerYAnchor.constraint(equalTo: isAnonymous.centerYAnchor).isActive = true
            isAnonymousLabel.leadingAnchor.constraint(equalTo: isAnonymous.trailingAnchor, constant: 8).isActive = true
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
        if !isAnonymous.isOn {
            _feedback.requestStepsFunctionality(contact: email.text ?? "")
        }
        else {
            _feedback.requestStepsFunctionality()
        }
        performSegue(withIdentifier: _segues.getStepsToRecipy().identifier, sender: self)
    }

    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
