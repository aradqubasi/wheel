//
//  [T].swift
//  Wheel
//
//  Created by Oleg Sokolansky on 03/07/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
extension Array {
    
    func random() -> Element? {
        if count == 0 {
            return nil
        }
        else {
            return self[Int(arc4random_uniform(UInt32(self.count)))]
        }
    }
    
    func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
    
    func join<T1, T2>(with collection: [T1], on predicate: (Element, T1) -> Bool, as select: (Element, T1) -> T2) -> [T2] {
        var result: [T2] = []
        for i in 0..<self.count {
            for j in 0..<collection.count {
                if predicate(self[i], collection[j]) {
                    result.append(select(self[i], collection[j]))
                }
            }
        }
        return result
    }
}
