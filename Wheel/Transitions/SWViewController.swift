//
//  SWViewController.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 19/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
class SWViewController: UIViewController {
    
    var segues: SWSegueRepository!
    
    func perform(segue: SWSegue) {
        segues.set(current: segue)
        performSegue(withIdentifier: segue.identifier, sender: self)
    }
    
}
