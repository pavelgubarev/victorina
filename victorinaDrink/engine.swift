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


class engineClass {
    var questions = [question]()
    var explanations = [explanation]()
    var answers = [Int]()
    var currentQuestionNumber : Int = 0
    var numberOfCorrectAnswersSoFar = 0
    var currentLevel = 1
    
    let numberOfQuestionsPerLevel = 2
    
    let numberOfLevels = 2
    
    var sessionManager : SessionManager!

    init() {
        loadQuestions()
        loadExplanations()
    }
    
    func isThereNextLevel() -> Bool {
        return currentLevel + 1 == numberOfLevels
    }
    
    func getCurrentQuestion() -> question {
                
        return questions[currentQuestionNumber]
    }
    
    func openShareLink() {
        
        let url = URL(string: "https://www.facebook.com/sharer/sharer.php?u=https:/pohmelje.ru")!
        
         UIApplication.shared.open( url, options: [:], completionHandler: nil)
    }

    
    func loadQuestions() {
        if let path = Bundle.main.path(forResource: "questions", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
                
                for oneObj in json! {
                    if let oneExplanation = question(json: oneObj) {
                        questions.append(oneExplanation)
                    }
                }
                
            } catch {
                print(error)
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }
    
   
    
    func loadExplanations() {
        if let path = Bundle.main.path(forResource: "explanations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                
                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String:Any]]
                
                for oneObj in json! {
                    if let oneExplanation = explanation(json: oneObj) {
                        explanations.append(oneExplanation)
                    }
                }
                
            } catch {
                print(error)
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    func acceptSelectedAnswer(answerNumber: Int) {
        answers.append(answerNumber)
        
        if wasAnswerCorrect(forQuestion: currentQuestionNumber) {
            numberOfCorrectAnswersSoFar += 1
        }
        
    }
    
    func wasAnswerCorrect(forQuestion questionNumber : Int) -> Bool {
        return questions[questionNumber].options[answers[questionNumber]].isCorrect
    }
    
    func shortExplanationForCurrentQuestion() -> String {
        return explanations[currentQuestionNumber].shortText
    }
    
    func linkForCurrentQuestion() -> URL {
        return explanations[currentQuestionNumber].link
    }

    func goToNextQuestion() {
        currentQuestionNumber = currentQuestionNumber + 1
      
        
    }
    
    func isLevelOver() -> Bool {
        
      //  print("currentQuestionNumber", currentQuestionNumber)
        
        return (currentQuestionNumber + 1) % numberOfQuestionsPerLevel == 0
    }
    
    func showResultsForTheLevel() {
        sendResultsForTheLevel()
        
      
    }
    
    
    func sendResultsForTheLevel() {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        var parameters = Parameters()
        
        var i = 0
        for answer in answers {
            var value = "\(answer),"
            let wascorrect = engine.wasAnswerCorrect(forQuestion: i) ? "YES" : "NO"
            i += 1
            value += wascorrect
            parameters["q\(i)"] = value
        }
        
        parameters["correct_answers"] = "\(engine.numberOfCorrectAnswersSoFar)"
        
//print(parameters)
        
        sessionManager =  Alamofire.SessionManager(configuration: configuration)
        
        sessionManager.request("https://pohmelje.ru/victorina/", method: .post, parameters: parameters).responseString { response in
            
           // print(response)
            
        }

        
    }
    
    func resetAnswers() {
        numberOfCorrectAnswersSoFar = 0

    }
    

    func nextLevel() {
        resetAnswers()
        currentLevel += 1
        
        self.goToNextQuestion()

    }
    
}
