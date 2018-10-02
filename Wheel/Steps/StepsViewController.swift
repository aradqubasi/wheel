//
//  StepsViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 09/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit

class StepsViewController: SWViewController, UITextFieldDelegate, SWDismissableViewController/*, UIViewControllerTransitioningDelegate */{
    
    // MARK: - Public properties
    
    var assembler: SWStepsAssembler!
    
    // MARK: - Private Properties
    
    private var _dismisser: SWSwipeInteractiveTransition!
    
//    private var _swiper: UISwipeGestureRecognizer!
    
    private var _swiper: SWSwipeGestureRecognizer!
    
    private var _name: String!
        
    private var _container: UIView!
    
    private var _feedback: SWFeedbackService!
    
    private var aligner: SWStepsAligner!
    
    // MARK: - Outlets
    
    private var email: UITextField!
    
    private var line: SWValidationLine!
    
    private var isAnonymous: UISwitch!

    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _name = "Steps"
        
        segues = assembler.resolve()
        
        _feedback = assembler.resolve()
        
        aligner = assembler.resolve()
        
        //swipe to recipy
        do {
            let dismisser = SWSwipeInteractiveTransition({() -> Void in
                self.perform(segue: self.segues.getStepsToRecipyWithSwipe())
            })
            self._dismisser = dismisser
            _swiper = SWSwipeGestureRecognizer()
            _swiper.Delegate = dismisser
            view.addGestureRecognizer(_swiper)
        }
        
        
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
        
        do {
            line = SWValidationLine(width: view.bounds.width - 24 * 2)
            _container.addSubview(line)
            line.frame.origin = CGPoint(x: 24, y: email.frame.origin.y + email.frame.height)
            line.translatesAutoresizingMaskIntoConstraints = false
            line.addSizeConstraints()
            line.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 1).isActive = true
            line.centerXAnchor.constraint(equalTo: _container.centerXAnchor).isActive = true
            line.finalize(.valid)
        }
        
//        var isAnonymous: UISwitch!
        do {
            isAnonymous = UISwitch()
            isAnonymous.addTarget(self, action: #selector(onAnonymousClick(_:)), for: .allTouchEvents)
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
            let iwant = UIButton.iwant
            _container.addSubview(iwant)
            aligner.alignAtBottom(button: iwant, in: _container)
            iwant.addTarget(self, action: #selector(onIWantButtonClick(_:)), for: .touchUpInside)
            
//            iwant.translatesAutoresizingMaskIntoConstraints = false
//            iwant.heightAnchor.constraint(equalToConstant: iwant.frame.height).isActive = true
//            iwant.centerXAnchor.constraint(equalTo: _container.centerXAnchor).isActive = true
//            iwant.bottomAnchor.constraint(equalTo: _container.bottomAnchor).isActive = true
//            iwant.widthAnchor.constraint(equalTo: _container.widthAnchor).isActive = true
        }
        
        validateForm()
        
        
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
        perform(segue: segues.getStepsToRecipy())
    }
    
    @IBAction func onIWantButtonClick(_ sender: Any) {
        if !isAnonymous.isOn {
            _feedback.requestStepsFunctionality(contact: email.text ?? "")
        }
        else {
            _feedback.requestStepsFunctionality()
        }
        perform(segue: segues.getStepsToRecipyWithConfirm())
    }
    
    @IBAction func onAnonymousClick(_ sender: UISwitch) {
        validateForm()
    }

    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        validateForm()
        return true
    }
    
    // MARK: - Animations

    private func valid() {
        line.prepare(.valid)
        self.email.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.5, animations: {
            self.line.transition(to: .valid)
        }, completion: { (error) in self.line.finalize(.valid) })
    }
    
    private func invalid() {
        line.prepare(.invalid)
        email.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.5, animations: {
            self.line.transition(to: .invalid)
        }, completion: { (error) in self.line.finalize(.invalid) })
    }
    
    private func inactivate() {
        line.prepare(.inactive)
        self.email.isUserInteractionEnabled = false
        email.text = ""
        UIView.animate(withDuration: 0.5, animations: {
            self.line.transition(to: .inactive)
        }, completion: { (error) in self.line.finalize(.inactive) })
    }
    
    // MARK: - Private Methods
    
    private func validateForm() {
        print(isAnonymous.isOn)
        if !isAnonymous.isOn {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if email.text == nil {
                valid()
            }
            else if email.text == "" {
                valid()
            }
            else if emailTest.evaluate(with: email.text) {
                valid()
            }
            else {
                invalid()
            }
        }
        else {
            inactivate()
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case segues.getStepsToRecipy().identifier:
            print("StepsToRecipy")
            _dismisser = nil
        case segues.getStepsToRecipyWithSwipe().identifier:
            print("StepsToRecipyWithSwipe")
        default:
            print("\(segue.identifier ?? "")")
        }
    }
    
    // MARK: - SWDismissableViewController Methods
    
    func interactionControllerForDismissal() -> UIViewControllerInteractiveTransitioning? {
        return _dismisser
    }

}
