//
//  SWFilterAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 22/04/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWFilterAssembler {
    
    func resolve() -> SWOptionRepository
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> SWFilterAligner
    
}
