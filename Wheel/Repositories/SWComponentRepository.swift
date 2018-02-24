//
//  SWRecipyComponentRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWComponentRepository {
    
    func getAll(by recipy: SWRecipy) -> [SWComponent]
    
    func create(_ component: SWComponent) -> SWComponent
    
}
