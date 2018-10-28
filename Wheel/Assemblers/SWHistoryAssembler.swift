//
//  SWHistoryAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 26/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWHistoryAssembler {
    
    func resolve() -> SWSegueRepository
    
    func resolve() -> SWRecipyRepository
    
    func resolve() -> SWDateStringifier
    
}
