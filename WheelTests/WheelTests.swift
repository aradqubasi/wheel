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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let ingredients = SWInmemoryIngredientRepository()
        let measures = SWInmemoryMeasuresmentRepository()
//        let stats = SWInmemoryIngredientStatsRepository()
        let recipy = SWConcreteRecipyListGenerator(measuresment: measures)
        for ingredient in ingredients.getAll() {
            print("\(recipy.getName(for: ingredient));\(recipy.getKind(for: ingredient));\(recipy.getQuantity(for: ingredient, per: 1))")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
