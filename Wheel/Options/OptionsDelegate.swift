//
//  OptionsDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/12/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit
protocol OptionsDelegate {
    func optionsDelegate(on action: OptionsActions, in controller: OptionsController) -> Void
}
