//
//  SWInmemoryComponentRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWInmemoryComponentRepository: SWComponentRepository {
    
    private static var components: [SWComponent] = []
    
    func getAll(by recipy: SWRecipy) -> [SWComponent] {
        return SWInmemoryComponentRepository.components
    }
    
    func create(_ component: SWComponent) -> SWComponent {
        let next = (SWInmemoryComponentRepository.components.map({ $0.id ?? 0 }).max() ?? 0) + 1
        let new = SWComponent(id: next, ingrigientId: component.ingrigientId, recipyId: component.recipyId)
        SWInmemoryComponentRepository.components.append(new)
        return new
    }
    
}
