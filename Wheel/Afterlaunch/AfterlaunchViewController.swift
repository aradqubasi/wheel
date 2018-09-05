//
//  AfterlaunchViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import UIKit
class AfterlaunchViewController: SWViewController {
    
    // MARK: - Public properties
    var assembler: SWAfterlaunchAssembler!
    
    // MARK: - Initialization
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let appStateRepository: SWAppStateRepository = assembler.resolve()
        
        let appState: SWAppState = appStateRepository.get()
        
        segues = assembler.resolve()
        
        if appState.showOnboarding {
            appStateRepository.setShowOnboarding(false)
            perform(segue: segues.getAfterlaunchToOnboarding())
        }
        else {
            perform(segue: segues.getAfterlaunchToWheels())
        }
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigator = segue.destination as? SWNavigationController, let wheels = navigator.topViewController as? WheelsViewController {
            let wheelsAssembler: SWWheelsAssembler = assembler.resolve()
            wheels.assembler = wheelsAssembler
            let navigationAssembler: SWNavigationAssembler = assembler.resolve()
            navigator.assembler = navigationAssembler
        }
        else if let onboardingController = segue.destination as? OnboardingViewController {
            let onboardingAssembler: SWOnboardingAssembler = assembler.resolve()
            onboardingController.assembler = onboardingAssembler
        }
    }

}
