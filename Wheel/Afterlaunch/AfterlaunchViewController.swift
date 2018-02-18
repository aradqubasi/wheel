//
//  AfterlaunchViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit
class AfterlaunchViewController: UIViewController {
    
    // MARK: - Public properties
    var assembler: SWAfterlaunchAssembler!
    
    // MARK: - Initialization
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let appState: SWAppState = assembler.resolve().get()
        
        let navigation: SWSegueRepository = assembler.resolve()
        
        if appState.showOnboarding {
            performSegue(withIdentifier: navigation.getAfterlaunchToOnboarding().identifier, sender: self)
        }
        else {
            performSegue(withIdentifier: navigation.getAfterlaunchToWheels().identifier, sender: self)
        }
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigator = segue.destination as? UINavigationController, let wheels = navigator.topViewController as? WheelsViewController {
            let wheelsAssembler: SWWheelsAssembler = assembler.resolve()
            wheels.assembler = wheelsAssembler
        }
        else if let onboardingController = segue.destination as? OnboardingViewController {
            let onboardingAssembler: SWOnboardingAssembler = assembler.resolve()
            onboardingController.assembler = onboardingAssembler
        }
    }

}
