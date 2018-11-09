//
//  SWImageRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 08/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

protocol SWImageRepository {
    
    func get(by id: UUID) -> SWImage

    func create(_ image: UIImage) -> SWImage
    
    func save(_ image: SWImage) -> Void
    
}
