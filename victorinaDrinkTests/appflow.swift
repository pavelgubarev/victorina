//
//  appflow.swift
//  victorinaDrinkTests
//
//  Created by Павел Губарев on 08/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import XCTest
import victorinaDrink

class appFlow: XCTestCase {
    
    var model = modelClass()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testUserCannotPassALevelWithWrongAnswers() {
        model.initUsersAnswers()
        for i in 1...model.numberOfQuestionsPerLevel {
            //we rely on the fact that correct answers have different numbers
            model.acceptSelectedAnswer(optionChosen: 1)
            model.goToNextQuestion()
        }
        
        XCTAssert(model.wereAllQuestionsAnsweredCorrectly() == false)
    }
    
}
