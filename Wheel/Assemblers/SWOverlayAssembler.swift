//
//  SWOverlayAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 23/06/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWOverlayAssembler {
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> SWIngredientsFilter
    
    func resolve() -> SWWheelsAligner
    
}
