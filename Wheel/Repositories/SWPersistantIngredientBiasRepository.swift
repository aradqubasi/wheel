//
//  SWPersistantIngredientBiasRepository.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/10/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWPersistantIngredientBiasRepository: SWIngredientBiasRepository {
    
    private static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    private static let ArchiveUrl = DocumentsDirectory.appendingPathComponent("SWPersistantIngredientBiasRepository")
    
    private func getRaw() -> [String] {
        let jsons = (NSKeyedUnarchiver.unarchiveObject(withFile: SWPersistantIngredientBiasRepository.ArchiveUrl.path) as? [String]) ?? []
        return jsons
    }
    
    private func setRaw(_ jsons: [String]) -> Void {
        NSKeyedArchiver.archiveRootObject(jsons, toFile: SWPersistantIngredientBiasRepository.ArchiveUrl.path)
    }
    
    func getAll() -> [SWIngredientBias] {
        let biases = getRaw()
            .map({
                (value: String)  -> SWIngredientBias in
                do {
                    let bias = try JSONDecoder().decode(SWIngredientBias.self, from: value.data(using: .utf8)!)
                    return bias
                }
                catch {
                    fatalError("\(error)")
                }
            })
        return biases
    }
    
    func saveOne(_ bias: SWIngredientBias) -> Void {
        do {
            var json = ""
            if bias.id == nil {
                let id = getAll().reduce(1, {
                    (result, next) -> Int in
                    return result < next.id! ? next.id! : result
                })
                json = String(data: try JSONEncoder().encode(SWIngredientBias(id: id, ingredientId: bias.ingredientId, cookId: bias.cookId, value: bias.value)), encoding: .utf8)!
            }
            else {
                json = String(data: try JSONEncoder().encode(bias), encoding: .utf8)!
            }
            var raw = self.getRaw()
            raw.append(json)
            self.setRaw(raw)
        }
        catch {
            fatalError("\(error)")
        }
    }
    
}
