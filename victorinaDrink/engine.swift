//
//  engine.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 05/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

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
    var currentQuestionNumber : Int = 0
    var numberOfCorrectAnswersSoFar = 0

    init() {
        loadQuestions()
        loadExplanations()
    }
    
    func getCurrentQuestion() -> question {
        return questions[currentQuestionNumber]
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
    
    func loadExplanations() {
        if let path = Bundle.main.path(forResource: "explanations", ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
                
                for line in myStrings {
                    if line.count > 0 {
                        explanations.append(line)
                    }
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    func acceptSelectedAnswer(answerNumber: Int) {
        answers.append(answerNumber)
        
        if wasAnswerCorrect() {
            numberOfCorrectAnswersSoFar += 1
        }
        
    }
    
    func wasAnswerCorrect() -> Bool {
        return answers[currentQuestionNumber] == correctAnswers[currentQuestionNumber]
    }
    
    func explanationForCurrentQuestion() -> String {
        return explanations[currentQuestionNumber]
    }
  
    func goToNextQuestion() {
        currentQuestionNumber = currentQuestionNumber + 1
        
        if currentQuestionNumber == 8 {
            showResultsForTheLevel()
        }
        
    }
    
    func showResultsForTheLevel() {
        sendResultsForTheLevel()
    }
    
    func gotoNextLelel() {
        
    }
    
    func sendResultsForTheLevel() {
        
    }
    
}
