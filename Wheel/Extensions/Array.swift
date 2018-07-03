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
    
}
