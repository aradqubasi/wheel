//
//  File.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol RVDelegate {
    func numberOfSpokes(in wheel: RadialView) -> Int
    
    func radialView(_ wheel: RadialView, _ wheelAt: RVState) -> RVSettings
    
    func radialView(_ wheel: RadialView, _ wheelAt: RVState, _ spoke: SpokeView, _ spokeAt: RVSpokeState, _ indexIs: Int) -> SVSettings
    
}
