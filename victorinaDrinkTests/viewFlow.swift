//
//  viewFlow.swift
//  victorinaDrinkTests
//
//  Created by Павел Губарев on 08/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import XCTest
import victorinaDrink

class mockQuestionView : questionViewProtocol {
    func setCurrentQuestion(withQuestion: question) {
    }
    
    func showAnswer() {
    }
    
    
}

class mockAnswerView : answerViewProtocol {
    
    
    var wasAnswerCorrect: Bool! = false
    
    var shortExplanation: String  = ""
    
    var peopleNumber: String? = ""
    
    var linkForCurrentQuestion: URL = URL(string: "https://pohmelje.ru")!
    
    var isLevelOver: Bool!
    
    func setAnswer() {
    }
    
    func gotoExplanationURL() {
    }
    
    func gotoResultsForTheLevel() {
    }
    
    
}

class viewFlow: XCTestCase {
    
    var model = modelClass()
    
    func testIfAnswerIsDisplayed() {
        
        model.initUsersAnswers()
        
        let mockQuestion = mockQuestionView()
        
        let mockAnswer = mockAnswerView()
        
        let questionPresenter = questionViewPresenter(withView: mockQuestion, withModel: model)
        
        //for the test we give an incorrect answer for question #1
        questionPresenter.acceptSelectedAnswer(optionChosen: 1)
        
        let answerPresenter = answerViewPresenter(withView: mockAnswer, withModel: model)
        answerPresenter.setAnswer()
        
        XCTAssert(mockAnswer.wasAnswerCorrect == false)
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
