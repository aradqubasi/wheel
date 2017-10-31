//
//  SVDelegate.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 25/10/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SVDelegate {
    func GetPicture(_ spoke: SpokeView, _ state: RVSpokeState) -> SVSettings
    
    func OnPinClick(_ spoke: SpokeView, _ state: RVSpokeState) -> Void
}

extension SVDelegate {
    func GetPicture(_ spoke: SpokeView, _ state: RVSpokeState) -> SVSettings {
        switch state {
        case .focused:
            return SVSettings(UIImage(color: .yellow, size: CGSize(width: 40, height: 40))!, 20)
        case .visible:
            return SVSettings(UIImage(color: .black, size: CGSize(width: 40, height: 40))!, 20)
        case .invisible:
            return SVSettings(UIImage(color: .white, size: CGSize(width: 40, height: 40))!, 20)
        }
    }
    
    func OnPinClick(_ spoke: SpokeView, _ state: RVSpokeState) -> Void {
        print("click at state \(state)")
    }
}
