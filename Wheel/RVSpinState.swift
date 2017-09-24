//
//  RadialViewState.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 24/09/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
enum RVSpinState {
    //not moving
    case calm
    
    //follow the finger
    case following
    
    //burn out momentum
    case decelerate
    
    //move thoward next spot
    case normalize
}
