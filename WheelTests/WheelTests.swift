//
//  WheelTests.swift
//  WheelTests
//
//  Created by Oleg Sokolansky on 13/08/2017.
//  Copyright © 2017 Oleg Sokolansky. All rights reserved.
//

import XCTest
@testable import Wheel

class WheelTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {

    }
    
    func testSWPersistantIngredientBiasRepository() {
        let repository = SWPersistantIngredientBiasRepository()
        
        let all1 = repository.getAll()
        
        repository.saveOne(SWIngredientBias(id: 3, ingredientId: 1, cookId: 1, value: 5))
        
        let all2 = repository.getAll()
        
        print("success before \(all1.count) after \(all2.count)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
