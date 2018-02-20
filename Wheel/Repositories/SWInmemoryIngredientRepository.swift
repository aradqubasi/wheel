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
            SWIngredient(id: 1, "romainelettuce", of: .base, as: UIImage.Romainelettuce, UIImage.romainelettuce),
            SWIngredient(id: 2, "salad", of: .base, as: UIImage.Salad, UIImage.salad),
            SWIngredient(id: 3, "cabbage", of: .base, as: UIImage.Cabbage, UIImage.cabbage),
            SWIngredient(id: 4, "lettuce", of: .base, as: UIImage.Lettuce, UIImage.lettuce),
            SWIngredient(id: 5, "spinach", of: .base, as: UIImage.Spinach, UIImage.spinach)
            ]
        case .fat: return [
            SWIngredient(id: 6, "coconut", of: .fat, as: UIImage.Coconut, UIImage.coconut),
            SWIngredient(id: 7, "hazelnut", of: .fat, as: UIImage.Hazelnut, UIImage.hazelnut),
            SWIngredient(id: 8, "seeds", of: .fat, as: UIImage.Seeds, UIImage.seeds),
            SWIngredient(id: 9, "brazilnut", of: .fat, as: UIImage.Brazilnut, UIImage.brazilnut),
            SWIngredient(id: 10, "cashewnut", of: .fat, as: UIImage.Cashewnut, UIImage.cashewnut),
            SWIngredient(id: 11, "avocado", of: .fat, as: UIImage.Avocado, UIImage.avocado),
            SWIngredient(id: 12, "peanut", of: .fat, as: UIImage.Peanut, UIImage.peanut)
            ]
        case .veggy: return [
            SWIngredient(id: 13, "aubergine", of: .veggy, as: UIImage.Aubergine, UIImage.aubergine),
            SWIngredient(id: 14, "tomato", of: .veggy, as: UIImage.Tomato, UIImage.tomato),
            SWIngredient(id: 15, "radish", of: .veggy, as: UIImage.Radish, UIImage.radish),
            SWIngredient(id: 16, "pepper", of: .veggy, as: UIImage.Pepper, UIImage.pepper),
            SWIngredient(id: 17, "broccoli", of: .veggy, as: UIImage.Broccoli, UIImage.broccoli),
            SWIngredient(id: 18, "carrot", of: .veggy, as: UIImage.Carrot, UIImage.carrot),
            SWIngredient(id: 19, "asparagus", of: .veggy, as: UIImage.Asparagus, UIImage.asparagus),
            SWIngredient(id: 20, "cauliflower", of: .veggy, as: UIImage.Cauliflower, UIImage.cauliflower),
            SWIngredient(id: 21, "corn", of: .veggy, as: UIImage.Corn, UIImage.corn)
            ]
        case .protein: return [
            SWIngredient(id: 22, "chickpeas", of: .protein, as: UIImage.Chickpeas, UIImage.chickpeas),
            SWIngredient(id: 23, "fish", of: .protein, as: UIImage.Fish, UIImage.fish),
            SWIngredient(id: 24, "boiledegg", of: .protein, as: UIImage.Boiledegg, UIImage.boiledegg),
            SWIngredient(id: 25, "beans", of: .protein, as: UIImage.Beans, UIImage.beans),
            SWIngredient(id: 26, "friedegg", of: .protein, as: UIImage.Friedegg, UIImage.friedegg),
            SWIngredient(id: 27, "lentils", of: .protein, as: UIImage.Lentils, UIImage.lentils),
            SWIngredient(id: 28, "mushrooms", of: .protein, as: UIImage.Mushrooms, UIImage.mushrooms),
            SWIngredient(id: 29, "shrimp", of: .protein, as: UIImage.Shrimp, UIImage.shrimp)
            ]
        case .dressing: return [
            SWIngredient(id: 30, "cooked grains", of: .dressing, as: UIImage.cookedgrains, UIImage.cookedgrains),
            SWIngredient(id: 31, "cottage cheese", of: .dressing, as: UIImage.cottagecheese, UIImage.cottagecheese),
            SWIngredient(id: 32, "hot pepper", of: .dressing, as: UIImage.hotpepper, UIImage.hotpepper),
            SWIngredient(id: 33, "olives", of: .dressing, as: UIImage.olives, UIImage.olives),
            SWIngredient(id: 34, "onion", of: .dressing, as: UIImage.onion, UIImage.onion),
            SWIngredient(id: 35, "pickled veggies", of: .dressing, as: UIImage.pickledveggies, UIImage.pickledveggies)
            ]
        case .unexpected: return [
            SWIngredient(id: 36, "cooked grains", of: .unexpected, as: UIImage.cookedgrains, UIImage.cookedgrains),
            SWIngredient(id: 37, "cottage cheese", of: .unexpected, as: UIImage.cottagecheese, UIImage.cottagecheese),
            SWIngredient(id: 38, "hot pepper", of: .unexpected, as: UIImage.hotpepper, UIImage.hotpepper),
            SWIngredient(id: 39, "olives", of: .unexpected, as: UIImage.olives, UIImage.olives),
            SWIngredient(id: 40, "onion", of: .unexpected, as: UIImage.onion, UIImage.onion),
            SWIngredient(id: 41, "pickled veggies", of: .unexpected, as: UIImage.pickledveggies, UIImage.pickledveggies)
            ]
        case .fruits: return [
            SWIngredient(id: 42, "cooked grains", of: .fruits, as: UIImage.cookedgrains, UIImage.cookedgrains),
            SWIngredient(id: 43, "cottage cheese", of: .fruits, as: UIImage.cottagecheese, UIImage.cottagecheese),
            SWIngredient(id: 44, "hot pepper", of: .fruits, as: UIImage.hotpepper, UIImage.hotpepper),
            SWIngredient(id: 45, "olives", of: .fruits, as: UIImage.olives, UIImage.olives),
            SWIngredient(id: 46, "onion", of: .fruits, as: UIImage.onion, UIImage.onion),
            SWIngredient(id: 47, "pickled veggies", of: .fruits, as: UIImage.pickledveggies, UIImage.pickledveggies)
            ]
        }
    }
}
