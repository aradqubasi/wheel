//
//  AbstractAssembler.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWRootAssembler {
    
    func resolve() -> SWOptionRepository
    
    func resolve() -> SWAfterlaunchAssembler

}
