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
    
    
    func getAll() -> [SWIngredient] {
        
        return [
            SWIngredient(id: 1, "romainelettuce", of: .base, as: UIImage.Romainelettuce, UIImage.romainelettuce, quantity: 100, unit: "g"),
            SWIngredient(id: 2, "salad", of: .base, as: UIImage.Salad, UIImage.salad, quantity: 100, unit: "g"),
            SWIngredient(id: 3, "cabbage", of: .base, as: UIImage.Cabbage, UIImage.cabbage, quantity: 100, unit: "g"),
            SWIngredient(id: 4, "lettuce", of: .base, as: UIImage.Lettuce, UIImage.lettuce, quantity: 100, unit: "g"),
            SWIngredient(id: 5, "spinach", of: .base, as: UIImage.Spinach, UIImage.spinach, quantity: 100, unit: "g"),
            SWIngredient(id: 6, "coconut", of: .fat, as: UIImage.Coconut, UIImage.coconut, quantity: 100, unit: "g"),
            SWIngredient(id: 7, "hazelnut", of: .fat, as: UIImage.Hazelnut, UIImage.hazelnut, quantity: 100, unit: "g"),
            SWIngredient(id: 8, "seeds", of: .fat, as: UIImage.Seeds, UIImage.seeds, quantity: 100, unit: "g"),
            SWIngredient(id: 9, "brazilnut", of: .fat, as: UIImage.Brazilnut, UIImage.brazilnut, quantity: 100, unit: "g"),
            SWIngredient(id: 10, "cashewnut", of: .fat, as: UIImage.Cashewnut, UIImage.cashewnut, quantity: 100, unit: "g"),
            SWIngredient(id: 11, "avocado", of: .fat, as: UIImage.Avocado, UIImage.avocado, quantity: 100, unit: "g"),
            SWIngredient(id: 12, "peanut", of: .fat, as: UIImage.Peanut, UIImage.peanut, quantity: 100, unit: "g"),
            SWIngredient(id: 13, "aubergine", of: .veggy, as: UIImage.Aubergine, UIImage.aubergine, quantity: 100, unit: "g"),
            SWIngredient(id: 14, "tomato", of: .veggy, as: UIImage.Tomato, UIImage.tomato, quantity: 100, unit: "g"),
            SWIngredient(id: 15, "radish", of: .veggy, as: UIImage.Radish, UIImage.radish, quantity: 100, unit: "g"),
            SWIngredient(id: 16, "pepper", of: .veggy, as: UIImage.Pepper, UIImage.pepper, quantity: 100, unit: "g"),
            SWIngredient(id: 17, "broccoli", of: .veggy, as: UIImage.Broccoli, UIImage.broccoli, quantity: 100, unit: "g"),
            SWIngredient(id: 18, "carrot", of: .veggy, as: UIImage.Carrot, UIImage.carrot, quantity: 100, unit: "g"),
            SWIngredient(id: 19, "asparagus", of: .veggy, as: UIImage.Asparagus, UIImage.asparagus, quantity: 100, unit: "g"),
            SWIngredient(id: 20, "cauliflower", of: .veggy, as: UIImage.Cauliflower, UIImage.cauliflower, quantity: 100, unit: "g"),
            SWIngredient(id: 21, "corn", of: .veggy, as: UIImage.Corn, UIImage.corn, quantity: 100, unit: "g"),
            SWIngredient(id: 22, "chickpeas", of: .protein, as: UIImage.Chickpeas, UIImage.chickpeas, quantity: 100, unit: "g"),
            SWIngredient(id: 23, "fish", of: .protein, as: UIImage.Fish, UIImage.fish, quantity: 100, unit: "g"),
            SWIngredient(id: 24, "boiledegg", of: .protein, as: UIImage.Boiledegg, UIImage.boiledegg, quantity: 100, unit: "g"),
            SWIngredient(id: 25, "beans", of: .protein, as: UIImage.Beans, UIImage.beans, quantity: 100, unit: "g"),
            SWIngredient(id: 26, "friedegg", of: .protein, as: UIImage.Friedegg, UIImage.friedegg, quantity: 100, unit: "g"),
            SWIngredient(id: 27, "lentils", of: .protein, as: UIImage.Lentils, UIImage.lentils, quantity: 100, unit: "g"),
            SWIngredient(id: 28, "mushrooms", of: .protein, as: UIImage.Mushrooms, UIImage.mushrooms, quantity: 100, unit: "g"),
            SWIngredient(id: 29, "shrimp", of: .protein, as: UIImage.Shrimp, UIImage.shrimp, quantity: 100, unit: "g"),
            SWIngredient(id: 30, "cooked grains", of: .dressing, as: UIImage.cookedgrains, UIImage.cookedgrains, quantity: 100, unit: "g"),
            SWIngredient(id: 31, "cottage cheese", of: .dressing, as: UIImage.cottagecheese, UIImage.cottagecheese, quantity: 100, unit: "g"),
            SWIngredient(id: 32, "hot pepper", of: .dressing, as: UIImage.hotpepper, UIImage.hotpepper, quantity: 100, unit: "g"),
            SWIngredient(id: 33, "olives", of: .dressing, as: UIImage.olives, UIImage.olives, quantity: 100, unit: "g"),
            SWIngredient(id: 34, "onion", of: .dressing, as: UIImage.onion, UIImage.onion, quantity: 100, unit: "g"),
            SWIngredient(id: 35, "pickled veggies", of: .dressing, as: UIImage.pickledveggies, UIImage.pickledveggies, quantity: 100, unit: "g"),
            SWIngredient(id: 36, "cooked grains", of: .unexpected, as: UIImage.cookedgrains, UIImage.cookedgrains, quantity: 100, unit: "g"),
            SWIngredient(id: 37, "cottage cheese", of: .unexpected, as: UIImage.cottagecheese, UIImage.cottagecheese, quantity: 100, unit: "g"),
            SWIngredient(id: 38, "hot pepper", of: .unexpected, as: UIImage.hotpepper, UIImage.hotpepper, quantity: 100, unit: "g"),
            SWIngredient(id: 39, "olives", of: .unexpected, as: UIImage.olives, UIImage.olives, quantity: 100, unit: "g"),
            SWIngredient(id: 40, "onion", of: .unexpected, as: UIImage.onion, UIImage.onion, quantity: 100, unit: "g"),
            SWIngredient(id: 41, "pickled veggies", of: .unexpected, as: UIImage.pickledveggies, UIImage.pickledveggies, quantity: 100, unit: "g"),
            SWIngredient(id: 42, "cooked grains", of: .fruits, as: UIImage.cookedgrains, UIImage.cookedgrains, quantity: 100, unit: "g"),
            SWIngredient(id: 43, "cottage cheese", of: .fruits, as: UIImage.cottagecheese, UIImage.cottagecheese, quantity: 100, unit: "g"),
            SWIngredient(id: 44, "hot pepper", of: .fruits, as: UIImage.hotpepper, UIImage.hotpepper, quantity: 100, unit: "g"),
            SWIngredient(id: 45, "olives", of: .fruits, as: UIImage.olives, UIImage.olives, quantity: 100, unit: "g"),
            SWIngredient(id: 46, "onion", of: .fruits, as: UIImage.onion, UIImage.onion, quantity: 100, unit: "g"),
            SWIngredient(id: 47, "pickled veggies", of: .fruits, as: UIImage.pickledveggies, UIImage.pickledveggies, quantity: 100, unit: "g")
        ]
        
    }
    
    func getAll(by kind: SWIngredientKinds) -> [SWIngredient] {
        
        return self.getAll().filter({$0.kind == kind})
        
    }
    
    func get(by name: String) -> SWIngredient? {
        
        return self.getAll().first(where: { $0.name.uppercased() == name.uppercased() })
        
    }
}
