//
//  ToOverlayButton.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 21/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import UIKit

class ToOverlayButton: UIButton, Floatable {
    
    var selection: SWIngredient?
    
    var asIngridient: SWIngredient {
        get {
            guard let selection = self.selection else {
                fatalError("overlay is not assigned to ToOverlayButton")
            }
            return selection
        }
    }
    
}
