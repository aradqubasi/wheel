//
//  SWPersistantRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 20/12/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
protocol SWPersistantRepository {
    associatedtype Repository
    associatedtype Entity: Decodable, Encodable
    
    func getEntities() -> [Entity]
    
    func setEntities(_ entities: [Entity])
}

extension SWPersistantRepository {
    
    private func getArchiveUrl() -> URL {
        return FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(String(describing: Repository.self))
    }
    
    private func getRaw() -> String {
        let jsons = (NSKeyedUnarchiver.unarchiveObject(withFile: self.getArchiveUrl().path) as? String) ?? "[]"
        return jsons
    }
    
    private func setRaw(_ json: String) -> Void {
        NSKeyedArchiver.archiveRootObject(json, toFile: self.getArchiveUrl().path)
    }
    
    func getEntities() -> [Entity] {
        do {
            let entities = try JSONDecoder().decode([Entity].self, from: getRaw().data(using: .utf8)!)
            return entities
        }
        catch {
            fatalError("\(error)")
        }
    }
    
    func setEntities(_ entities: [Entity]) {
        do {
            let json = String(data: try JSONEncoder().encode(entities), encoding: .utf8)!
            self.setRaw(json)
        }
        catch {
            fatalError("\(error)")
        }
    }
}
