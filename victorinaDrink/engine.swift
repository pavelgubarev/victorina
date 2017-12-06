//
//  engine.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 05/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import Foundation
import UIKit


struct question {
    var text : String = ""
    var answers : [String] = [String]()
    
    var explanations = [String]()
}

class engineClass {
    var questions = [question]()
    var explanations = [String]()
    var answers = [Int]()
    var correctAnswers = [Int]()
    var currentQuestion : Int = 0
    
    init() {
        loadQuestions()
    }
    
    func getCurrentQuestion() -> question {
        return questions[currentQuestion]
    }
    
    func loadQuestions() {
        if let path = Bundle.main.path(forResource: "questions", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                
                parseQuestions(fromStrings: myStrings)
                
            } catch {
                print(error)
            }
        }
    }
    
    func parseQuestions(fromStrings : [String]) {
        
        var qNumber = 0
        var answerNumber = 0
        
        for line in fromStrings {
            if line.count == 0 {
                let newQuestion = question()
                questions.append(newQuestion)
                qNumber = questions.count - 1
                answerNumber = 0
            } else {
                if answerNumber == 0 {
                    questions[qNumber].text = line
                } else {
                    
                    let answerArr = line.components(separatedBy: "|")
                    
                    if answerArr[0] == "+" {
                        correctAnswers.append(answerNumber - 1)
                    }
                    
                    questions[qNumber].answers.append(answerArr[1])
                }
                answerNumber = answerNumber + 1
            }
        }
        
    }
    
    func acceptSelectedAnswer(answerNumber: Int) {
        answers.append(answerNumber)
        
    }
    
    func loadExplanations() {
        
    }
}
