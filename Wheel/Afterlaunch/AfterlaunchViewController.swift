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
        
        let initialize = appState.initializeDefaults
        
        if initialize {
            let diet: SWDietSettingsRepository = self.assembler.resolve()
            diet.upsert(SWDietSettings(id: 1, fatsDailyShare: 0.225, proteinsDailyShare: 0.275, carbohydratesDailyShare: 0.5, morningEnergyIntakeShare: 0.267, middayEnergyIntakeShare: 0.466, eveningEnergyIntakeShare: 0.267, dailyEnergyIntake: 1000, morning: 5, midday: 15, evening: 22))
            appStateRepository.setInitializeDefaults(false)
        }
        
        do {
            let optionRepository: SWOptionRepository = self.assembler.resolve()
            let userOptionRepository: SWUserOptionRepository = self.assembler.resolve()
            userOptionRepository.setEntities(
                optionRepository
                    .getAll()
                    .leftjoin(
                        with: userOptionRepository.getEntities(),
                        on: {
                            (option: SWOption, userOption: SWUserOption) -> Bool in
                            option.id == userOption.optionId
                        },
                        as: {
                            (option: SWOption, userOption: SWUserOption?) -> SWUserOption in
                            if let userOption = userOption {
                                return userOption
                            }
                            else if initialize {
                                return SWUserOption(option.id ?? 0, true)
                            }
                            else {
                                return SWUserOption(option.id ?? 0, false)
                            }
                        }))
        }
        
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
