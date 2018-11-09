//
//  SWPersistantImageRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 08/11/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
import UIKit

class SWPersistantImageRepository: SWImageRepository {
    
    func get(by id: UUID) -> SWImage {
        let path: String = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(String(describing: id))
        let image = UIImage(contentsOfFile: path)!
        let entity = SWImage(id: id, image: image)
        return entity
    }
    
    func create(_ image: UIImage) -> SWImage {
        return SWImage(id: UUID(), image: image)
    }
    
    func save(_ entity: SWImage) -> Void {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(String(describing: entity.id))
        let data = UIImagePNGRepresentation(entity.image)
        fileManager.createFile(atPath: path as String, contents: data, attributes: nil)
    }
    
}
