//
//  SWRecipyRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWRecipyRepository {
    
    func getAll() -> [SWRecipy]
    
    func get(by id: Int) -> SWRecipy?
    
    func save(_ recipy: SWRecipy) -> Void
    
    func create() -> SWRecipy
    
    func removeBy(id: Int) -> Void 
    
}
