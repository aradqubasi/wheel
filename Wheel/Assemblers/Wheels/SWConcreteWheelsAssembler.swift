//
//  SWConcreteWheelsAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWConcreteWheelsAssembler: SWWheelsAssembler {
    
    func resolve() -> SWIngredientRepository {
        return SWInmemoryIngredientRepository()
    }
    
    func resolve() -> SWBlockingRepository {
        return SWInmemoryBlockingRepoitory()
    }
    
    func resolve() -> SWOptionRepository {
        return SWInmemoryOptionRepository()
    }
    
    func resolve() -> SWWheelPositionCalculator {
        return SWConcreteWheelPositionCalculator()
    }
    
    func resolve() -> SWSegueRepository {
        return SWInmemorySegueRepository()
    }
    
    func resolve() -> SWRecipyAssembler {
        return SWConcreteRecipyAssembler()
    }
    
    func resolve() -> SWWheelsAligner {
        let size = UIScreen.main.bounds.size
        switch size.width {
        case 0..<414:
            switch size.height {
            case 0..<700: return SWNarrowWheelsAligner()
            default: return SWTallWheelsAligner()
            }
        case 414..<1000:
            return SWWideWheelsAligner()
        default:
            fatalError("can not choose aligner for device \(size)")
        }
    }
    
    func resolve() -> SWTipGenerator {
        return SWConcreteTipGenerator()
    }
    
    func resolve() -> SWFilterAssembler {
        return SWConcreteFilterAssembler()
    }
    
    func resolve() -> SWOverlayAssembler {
        return SWConcreteOverlayAssembler()
    }
    
    func resolve() -> SWIngredientsFilter {
        return SWConcreteIngredientsFilter(ingredients: resolve(), options: resolve(), blockings: resolve())
    }
    
    func resolve(using background: UIView) -> SWSubwheelAssembler {
        return SWConcreteSubwheelAssembler(background: background)
    }
    
    func resolve(semaphor: SWAnimationSemaphor) -> SWSelectionWheelAssembler {
        return SWConcreteSelectionWheelAssembler(semaphor: semaphor)
    }
    
    func resolve() -> SWAppStateRepository {
        return SWUserDefaultsAppStateRepository()
    }
    
    func resolve(from controller: UIViewController, areas: SWAreasOfInterest) -> SWWalkthroughAssembler {
        let wheels = controller.navigationController?.view.snapshotView(afterScreenUpdates: true)
        return SWConcreteWalkthroughAssembler(background: wheels!, areas: areas)
    }
    
    func resolve() -> SWCheifCook {
        return SWBalancedCheifCook(ingredients: SWConcreteFullIngredientRepository(ingredients: SWInmemoryIngredientRepository(), measuresments: SWInmemoryMeasuresmentRepository(), stats: SWInmemoryIngredientStatsRepository(), blockings: SWInmemoryBlockingRepoitory(), options: SWInmemoryOptionRepository(), biases: SWPersistantIngredientBiasRepository(), state: SWUserDefaultsAppStateRepository()), randomizer: SWBiasedRandomIngredientProvider())
    }
    
    func resolve(bases: SWAbstractWheelController, fats: SWAbstractWheelController, veggies: SWAbstractWheelController, proteins: SWAbstractWheelController, unexpected: UIButton, fruits: UIButton, dressings: UIButton, scene: UIView) -> SWWheelsAnimationHelper {
        return SWConcreteWheelsAnimationHelper(bases: bases, fats: fats, veggies: veggies, proteins: proteins, unexpected: unexpected, fruits: fruits, dressings: dressings, scene: scene)
    }
    
    func resolve() -> SWModelHelper {
        return SWConcreteModelHelper()
    }
    
    func resolve(using background: UIView) -> SWHamburgerAssembler {
        return SWConcreteHamburgerAssembler(background)
    }
    
    func resolve() -> SWHistoryAssembler {
        return SWConcreteHistoryAssembler()
    }
    
    func resolve() -> SWRecipyGenerator {
        return SWConcreteRecipyGenerator(
            SWPersistantRecipyRepository(),
            SWConcreteNameGenerator(),
            SWConcreteServingsGenerator(
                measuresment: SWInmemoryMeasuresmentRepository(),
                stats: SWInmemoryIngredientStatsRepository()))
    }
    
    func resolve() -> SWDietAssembler {
        return SWConcreteDietAssembler()
    }
    
}
