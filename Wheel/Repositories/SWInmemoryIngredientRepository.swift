//
//  SWInmemoryIngredientRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 18/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWInmemoryIngredientRepository: SWIngredientRepository {
    
    func getAll(by kind: SWIngredientKinds) -> [SWIngredient] {
        switch kind {
        case .base: return [
            SWIngredient("romainelettuce", of: .base, as: UIImage.Romainelettuce, UIImage.romainelettuce),
            SWIngredient("salad", of: .base, as: UIImage.Salad, UIImage.salad),
            SWIngredient("cabbage", of: .base, as: UIImage.Cabbage, UIImage.cabbage),
            SWIngredient("lettuce", of: .base, as: UIImage.Lettuce, UIImage.lettuce),
            SWIngredient("spinach", of: .base, as: UIImage.Spinach, UIImage.spinach)
            ]
        case .fat: return [
            SWIngredient("coconut", of: .fat, as: UIImage.Coconut, UIImage.coconut),
            SWIngredient("hazelnut", of: .fat, as: UIImage.Hazelnut, UIImage.hazelnut),
            SWIngredient("seeds", of: .fat, as: UIImage.Seeds, UIImage.seeds),
            SWIngredient("brazilnut", of: .fat, as: UIImage.Brazilnut, UIImage.brazilnut),
            SWIngredient("cashewnut", of: .fat, as: UIImage.Cashewnut, UIImage.cashewnut),
            SWIngredient("avocado", of: .fat, as: UIImage.Avocado, UIImage.avocado),
            SWIngredient("peanut", of: .fat, as: UIImage.Peanut, UIImage.peanut)
            ]
        case .veggy: return [
            SWIngredient("aubergine", of: .veggy, as: UIImage.Aubergine, UIImage.aubergine),
            SWIngredient("tomato", of: .veggy, as: UIImage.Tomato, UIImage.tomato),
            SWIngredient("radish", of: .veggy, as: UIImage.Radish, UIImage.radish),
            SWIngredient("pepper", of: .veggy, as: UIImage.Pepper, UIImage.pepper),
            SWIngredient("broccoli", of: .veggy, as: UIImage.Broccoli, UIImage.broccoli),
            SWIngredient("carrot", of: .veggy, as: UIImage.Carrot, UIImage.carrot),
            SWIngredient("asparagus", of: .veggy, as: UIImage.Asparagus, UIImage.asparagus),
            SWIngredient("cauliflower", of: .veggy, as: UIImage.Cauliflower, UIImage.cauliflower),
            SWIngredient("corn", of: .veggy, as: UIImage.Corn, UIImage.corn)
            ]
        case .protein: return [
            SWIngredient("chickpeas", of: .protein, as: UIImage.Chickpeas, UIImage.chickpeas),
            SWIngredient("fish", of: .protein, as: UIImage.Fish, UIImage.fish),
            SWIngredient("boiledegg", of: .protein, as: UIImage.Boiledegg, UIImage.boiledegg),
            SWIngredient("beans", of: .protein, as: UIImage.Beans, UIImage.beans),
            SWIngredient("friedegg", of: .protein, as: UIImage.Friedegg, UIImage.friedegg),
            SWIngredient("lentils", of: .protein, as: UIImage.Lentils, UIImage.lentils),
            SWIngredient("mushrooms", of: .protein, as: UIImage.Mushrooms, UIImage.mushrooms),
            SWIngredient("shrimp", of: .protein, as: UIImage.Shrimp, UIImage.shrimp)
            ]
        case .dressing: return [
            SWIngredient("cooked grains", of: .dressing, as: UIImage.cookedgrains, UIImage.cookedgrains),
            SWIngredient("cottage cheese", of: .dressing, as: UIImage.cottagecheese, UIImage.cottagecheese),
            SWIngredient("hot pepper", of: .dressing, as: UIImage.hotpepper, UIImage.hotpepper),
            SWIngredient("olives", of: .dressing, as: UIImage.olives, UIImage.olives),
            SWIngredient("onion", of: .dressing, as: UIImage.onion, UIImage.onion),
            SWIngredient("pickled veggies", of: .dressing, as: UIImage.pickledveggies, UIImage.pickledveggies)
            ]
        case .unexpected: return [
            SWIngredient("cooked grains", of: .unexpected, as: UIImage.cookedgrains, UIImage.cookedgrains),
            SWIngredient("cottage cheese", of: .unexpected, as: UIImage.cottagecheese, UIImage.cottagecheese),
            SWIngredient("hot pepper", of: .unexpected, as: UIImage.hotpepper, UIImage.hotpepper),
            SWIngredient("olives", of: .unexpected, as: UIImage.olives, UIImage.olives),
            SWIngredient("onion", of: .unexpected, as: UIImage.onion, UIImage.onion),
            SWIngredient("pickled veggies", of: .unexpected, as: UIImage.pickledveggies, UIImage.pickledveggies)
            ]
        case .fruits: return [
            SWIngredient("cooked grains", of: .fruits, as: UIImage.cookedgrains, UIImage.cookedgrains),
            SWIngredient("cottage cheese", of: .fruits, as: UIImage.cottagecheese, UIImage.cottagecheese),
            SWIngredient("hot pepper", of: .fruits, as: UIImage.hotpepper, UIImage.hotpepper),
            SWIngredient("olives", of: .fruits, as: UIImage.olives, UIImage.olives),
            SWIngredient("onion", of: .fruits, as: UIImage.onion, UIImage.onion),
            SWIngredient("pickled veggies", of: .fruits, as: UIImage.pickledveggies, UIImage.pickledveggies)
            ]
        }
    }
}
