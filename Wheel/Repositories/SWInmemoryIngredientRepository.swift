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
            SWIngredient(id: 1, "Romaine Lettuce", of: .base, as: UIImage.Romainelettuce, UIImage.romainelettuce, quantity: 3, unit: 6),
            SWIngredient(id: 2, "salad", of: .base, as: UIImage.Salad, UIImage.salad, quantity: 1, unit: 7),
            SWIngredient(id: 3, "cabbage", of: .base, as: UIImage.Cabbage, UIImage.cabbage, quantity: 3, unit: 6),
            SWIngredient(id: 4, "lettuce", of: .base, as: UIImage.Lettuce, UIImage.lettuce, quantity: 1, unit: 7),
            SWIngredient(id: 5, "spinach", of: .base, as: UIImage.Spinach, UIImage.spinach, quantity: 1, unit: 7),
            
            SWIngredient(id: 6, "coconut", of: .fat, as: UIImage.Coconut, UIImage.coconut, quantity: 1, unit: 8),
            SWIngredient(id: 7, "hazelnut", of: .fat, as: UIImage.Hazelnut, UIImage.hazelnut, quantity: 34, unit: 1),
            SWIngredient(id: 8, "seeds", of: .fat, as: UIImage.Seeds, UIImage.seeds, quantity: 1, unit: 3),
            SWIngredient(id: 9, "brazilnut", of: .fat, as: UIImage.Brazilnut, UIImage.brazilnut, quantity: 6, unit: 8),
            SWIngredient(id: 10, "cashewnut", of: .fat, as: UIImage.Cashewnut, UIImage.cashewnut, quantity: 1, unit: 9),
            SWIngredient(id: 11, "avocado", of: .fat, as: UIImage.Avocado, UIImage.avocado, quantity: 1, unit: 8),
            SWIngredient(id: 12, "peanut", of: .fat, as: UIImage.Peanut, UIImage.peanut, quantity: 1, unit: 9),
            
            SWIngredient(id: 13, "aubergine", of: .veggy, as: UIImage.Aubergine, UIImage.aubergine, quantity: 1, unit: 7),
            SWIngredient(id: 14, "tomato", of: .veggy, as: UIImage.Tomato, UIImage.tomato, quantity: 1, unit: 8),
            SWIngredient(id: 15, "radish", of: .veggy, as: UIImage.Radish, UIImage.radish, quantity: 1, unit: 7),
            SWIngredient(id: 16, "pepper", of: .veggy, as: UIImage.Pepper, UIImage.pepper, quantity: 1, unit: 10),
            SWIngredient(id: 17, "broccoli", of: .veggy, as: UIImage.Broccoli, UIImage.broccoli, quantity: 1, unit: 7),
            SWIngredient(id: 18, "carrot", of: .veggy, as: UIImage.Carrot, UIImage.carrot, quantity: 1, unit: 7),
            SWIngredient(id: 19, "asparagus", of: .veggy, as: UIImage.Asparagus, UIImage.asparagus, quantity: 1, unit: 7),
            SWIngredient(id: 20, "cauliflower", of: .veggy, as: UIImage.Cauliflower, UIImage.cauliflower, quantity: 1, unit: 7),
            SWIngredient(id: 21, "corn", of: .veggy, as: UIImage.Corn, UIImage.corn, quantity: 1, unit: 9),
            SWIngredient(id: 22, "chickpeas", of: .protein, as: UIImage.Chickpeas, UIImage.chickpeas, quantity: 1, unit: 7),
            SWIngredient(id: 23, "tuna", of: .protein, as: UIImage.Fish, UIImage.fish, quantity: 100, unit: 1),
            SWIngredient(id: 24, "boiledegg", of: .protein, as: UIImage.Boiledegg, UIImage.boiledegg, quantity: 1, unit: 10),
            SWIngredient(id: 25, "beans", of: .protein, as: UIImage.Beans, UIImage.beans, quantity: 1, unit: 9),
            SWIngredient(id: 26, "friedegg", of: .protein, as: UIImage.Friedegg, UIImage.friedegg, quantity: 1, unit: 10),
            SWIngredient(id: 27, "lentils", of: .protein, as: UIImage.Lentils, UIImage.lentils, quantity: 0.25, unit: 7),
            SWIngredient(id: 28, "mushrooms", of: .protein, as: UIImage.Mushrooms, UIImage.mushrooms, quantity: 1, unit: 7),
            SWIngredient(id: 29, "shrimp", of: .protein, as: UIImage.Shrimp, UIImage.shrimp, quantity: 6, unit: 10),
            
            SWIngredient(id: 30, "mustard", of: .dressing, as: UIImage.mustard, UIImage.mustard, quantity: 1, unit: 3),
            SWIngredient(id: 31, "tahini", of: .dressing, as: UIImage.tahini, UIImage.tahini, quantity: 2, unit: 3),
            SWIngredient(id: 32, "yogurt", of: .dressing, as: UIImage.yogurt, UIImage.yogurt, quantity: 2, unit: 9),
            SWIngredient(id: 33, "vinegar", of: .dressing, as: UIImage.vinegar, UIImage.vinegar, quantity: 1, unit: 3),
            SWIngredient(id: 34, "honey", of: .dressing, as: UIImage.honey, UIImage.honey, quantity: 1, unit: 3),
            SWIngredient(id: 35, "olive oil", of: .dressing, as: #imageLiteral(resourceName: "wheels/dressing/oliveoil"), #imageLiteral(resourceName: "wheels/dressing/oliveoil"), quantity: 1, unit: 3),
            
            SWIngredient(id: 36, "cooked grains", of: .unexpected, as: UIImage.cookedgrains, UIImage.cookedgrains, quantity: 1, unit: 7),
            SWIngredient(id: 37, "cottage cheese", of: .unexpected, as: UIImage.cottagecheese, UIImage.cottagecheese, quantity: 4, unit: 9),
            SWIngredient(id: 38, "hot pepper", of: .unexpected, as: UIImage.hotpepper, UIImage.hotpepper, quantity: 1, unit: 10),
            SWIngredient(id: 39, "olives", of: .unexpected, as: UIImage.olives, UIImage.olives, quantity: 10, unit: 10),
            SWIngredient(id: 40, "onion", of: .unexpected, as: UIImage.onion, UIImage.onion, quantity: 1, unit: 11),
            SWIngredient(id: 41, "pickled veggies", of: .unexpected, as: UIImage.pickledveggies, UIImage.pickledveggies, quantity: 1, unit: 10),
            
            SWIngredient(id: 42, "apple", of: .fruits, as: #imageLiteral(resourceName: "wheels/fruits/apple"), #imageLiteral(resourceName: "wheels/fruits/apple"), quantity: 0.5, unit: 10),
            SWIngredient(id: 43, "blueberry", of: .fruits, as: #imageLiteral(resourceName: "wheels/fruits/blueberries"), #imageLiteral(resourceName: "wheels/fruits/blueberries"), quantity: 1, unit: 9),
            SWIngredient(id: 44, "orange", of: .fruits, as: #imageLiteral(resourceName: "wheels/fruits/orange"), #imageLiteral(resourceName: "wheels/fruits/orange"), quantity: 0.5, unit: 10),
            //SWIngredient(id: 45, "grapefruit", of: .fruits, as: UIImage.olives, UIImage.olives, quantity: 0.5, unit: 10),
            SWIngredient(id: 46, "grapes", of: .fruits, as: #imageLiteral(resourceName: "wheels/fruits/grapes"), #imageLiteral(resourceName: "wheels/fruits/grapes"), quantity: 1, unit: 9),
            //SWIngredient(id: 47, "watermelon", of: .fruits, as: UIImage.pickledveggies, UIImage.pickledveggies, quantity: 10, unit: 12),
            
            SWIngredient(id: 48, "pistachio", of: .fat, as: UIImage.Pistachio, UIImage.pistachio, quantity: 1, unit: 9),
            SWIngredient(id: 49, "pomegranate", of: .fruits, as: #imageLiteral(resourceName: "wheels/fruits/pomegranate"), #imageLiteral(resourceName: "wheels/fruits/pomegranate"), quantity: 0.5, unit: 10),
            SWIngredient(id: 50, "lemon juice", of: .dressing, as: #imageLiteral(resourceName: "wheels/fruits/lemon"), #imageLiteral(resourceName: "wheels/fruits/lemon"), quantity: 0.5, unit: 10),
            SWIngredient(id: 51, "meat", of: .protein, as: #imageLiteral(resourceName: "wheels/proteins/active/meat"), #imageLiteral(resourceName: "wheels/proteins/inactive/meat"), quantity: 100, unit: 1),
            SWIngredient(id: 52, "salmon", of: .protein, as: #imageLiteral(resourceName: "wheels/proteins/active/salmon"), #imageLiteral(resourceName: "wheels/proteins/inactive/salmon"), quantity: 100, unit: 1),
        ]

    }
    
    func getAll(by kind: SWIngredientKinds) -> [SWIngredient] {
        
        return self.getAll().filter({$0.kind == kind})
        
    }
    
    func get(by name: String) -> SWIngredient? {
        
        return self.getAll().first(where: { $0.name.uppercased() == name.uppercased() })
        
    }
}
