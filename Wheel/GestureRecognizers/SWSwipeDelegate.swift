//
//  SWSwipeDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/05/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWSwipeDelegate {
    
    func onBegin(_ sender: SWSwipeGestureRecognizer) -> Void
    
    func onMove(_ sender: SWSwipeGestureRecognizer) -> Void
    
    func onFinish(_ sender: SWSwipeGestureRecognizer) -> Void
    
    func onCancel(_ sender: SWSwipeGestureRecognizer) -> Void
    
}
