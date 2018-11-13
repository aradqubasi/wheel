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
    
    func leftjoin<T1, T2>(with collection: [T1], on predicate: (Element, T1) -> Bool, as select: (Element, T1?) -> T2) -> [T2] {
        var result: [T2] = []
        for i in 0..<self.count {
            var hitted = false
            for j in 0..<collection.count {
                if predicate(self[i], collection[j]) {
                    result.append(select(self[i], collection[j]))
                    hitted = true
                }
            }
            if !hitted {
                result.append(select(self[i], nil))
            }
        }
        return result
    }
    
    func zip<T1,T2>(with collection: [T1], as select: (Element, T1) -> T2) -> [T2] {
        var result: [T2] = []
        for i in 0..<Swift.min(self.count, collection.count) {
            result.append(select(self[i], collection[i]))
        }
        return result
    }
    
//    func query<T1,T2,T3>(_ t1: T1.Type, _ t2: T2.Type, _ t3: T3.Type) -> SWQuery<T1,T2,T3> {
//        return SWQuery<T1,T2,T3>().arrayjoin(from: self as! [T1])
//    }
    
}

//class SWQuery<T1,T2,T3> {
//    private func innerjoin(from inner: [T1], with outer: [T2], on predicate: (T1, T2) -> Bool, as select: (T1, T2) -> T3) -> [T3] {
//        var result: [T3] = []
//        for i in 0..<inner.count {
//            for j in 0..<outer.count {
//                if predicate(inner[i], outer[j]) {
//                    result.append(select(inner[i], outer[j]))
//                }
//            }
//        }
//        return result
//    }
//
//    func arrayjoin (from inner: [T1]) -> (_: [T2], _: (T1, T2) -> Bool, _: (T1, T2) -> T3) -> [T3] {
//        let join: (_: [T2], _: (T1, T2) -> Bool, _: (T1, T2) -> T3) -> [T3] = {
//            outer, predicate, selector in
//            return self.innerjoin(from: inner, with: outer, on: predicate, as: selector)
//        }
//        return join
//    }
//}

