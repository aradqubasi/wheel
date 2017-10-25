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
    func GetPicture(for: RVSpokeState) -> UIImage
}

extension SVDelegate {
    func GetPicture(for state: RVSpokeState) -> UIImage {
        switch state {
        case .focused:
            return UIImage(color: .yellow, size: CGSize(width: 40, height: 40))!
        case .visible:
            return UIImage(color: .black, size: CGSize(width: 40, height: 40))!
        case .invisible:
            return UIImage(color: .white, size: CGSize(width: 40, height: 40))!
        }
    }
}
