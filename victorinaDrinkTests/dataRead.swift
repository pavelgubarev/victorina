//
//  dataRead.swift
//  victorinaDrinkTests
//
//  Created by Павел Губарев on 08/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import XCTest
import victorinaDrink

class dataRead: XCTestCase {

    var model = modelClass()
    

    func testDataHasLoaded() {

        XCTAssert(model.questions.count == model.numberOfQuestionsPerLevel * model.numberOfLevels)

        XCTAssert(model.explanations.count == model.numberOfQuestionsPerLevel * model.numberOfLevels)
        
    }
    
    func testDataIntegrity() {
        
        var integrity = true
        for dQuestion in model.questions {
            
            if dQuestion.text.count == 0 {
                integrity = false
            }
            if dQuestion.options.count == 0 {
                integrity = false
            }

            for dOption in dQuestion.options {
                if dOption.text.count == 0 {
                    integrity = false
                }
            }
            
        }
        
        XCTAssert(integrity)
        
        
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
   
    
}
