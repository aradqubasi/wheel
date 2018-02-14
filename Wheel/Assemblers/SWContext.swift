//
//  SWContext.swift
//  Wheel
//
//  Created by Oleg Sokolansky on 14/02/2018.
//  Copyright © 2018 Oleg Sokolansky. All rights reserved.
//

import Foundation
class SWContext {
    
    private static var _root: SWRootAssembler?
    
    static var root: SWRootAssembler {
        get {
            guard let root = _root else {
                fatalError("root assembler is not initialized")
            }
            return root
        }
        set (new) {
            if _root == nil {
                _root = new
            }
            else {
                print("WARNING: trying to reinitialize root assembler")
            }
        }
    }
}
