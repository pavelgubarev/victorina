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
}

class engineClass {
    var questions = [question]()
    var explanations = [String]()
    var links = [String]()
    var answers = [Int]()
    var correctAnswers = [Int]()
    var currentQuestionNumber : Int = 0
    var numberOfCorrectAnswersSoFar = 0
    var currentLevel = 1
    
    let numberOfQuestionsInLevel = 7
    
    var sessionManager : SessionManager!

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
                
                var i = 0
                for line in myStrings {
                    if line.count > 0 {
                        if i % 2 == 0 {
                            explanations.append(line)
                        }
                        else {
                            links.append(line)
                        }
                        i = i + 1
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
    
    func linkForCurrentQuestion() -> String {
        return links[currentQuestionNumber]
    }

    func goToNextQuestion() {
        currentQuestionNumber = currentQuestionNumber + 1
      
        
    }
    
    func isLevelOver() -> Bool {
        
        print("currentQuestionNumber", currentQuestionNumber)
        
        return currentQuestionNumber + 1 == 7
    }
    
    func showResultsForTheLevel() {
        sendResultsForTheLevel()
        
      
    }
    
    
    func sendResultsForTheLevel() {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        var parametres = Parameters()
        
        var i = 0
        for answer in answers {
            i += 1
            var value = "\(answer),"
            let wascorrect = answer == correctAnswers[i-1] ? "YES" : "NO"
            value += wascorrect
            parametres["q\(i)"] = value
        }
        
        sessionManager =  Alamofire.SessionManager(configuration: configuration)
        
        sessionManager.request("https://pohmelje.ru/victorina/", method: .post, parameters: parametres).responseString { response in
            
            print(response)
            
        }

        
    }
    
    func resetAnswers() {
        numberOfCorrectAnswersSoFar = 0

    }
    

    func nextLevel() {
        resetAnswers()
        currentLevel += 1

    }
    
}
