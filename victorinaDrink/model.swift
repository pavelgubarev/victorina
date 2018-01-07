//
//  model.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation
import Alamofire

class modelClass {
    
    var comparisonData : NSDictionary?
    
    var explanations = [explanation]()
    
    var questions = [question]()
    
    let numberOfQuestionsPerLevel = 7
    
    let numberOfLevels = 2
    
    var currentUsersAnswers = [Int:[Int]]()
    
    var currentQuestionNumber : Int = 0
    
    var numberOfCorrectAnswersSoFar = 0
    
    var lastOptionChosen : Int = 0
    
    var currentLevel = 1
    
    var passedLevels = 0
    
    var sessionManager : SessionManager!
    
    init() {
        loadQuestions()
        loadExplanations()
        
        loadComparison()
    }
    
    
    func loadData() {
        let userDefaults = UserDefaults.standard
        
        self.passedLevels = userDefaults.integer(forKey: "passedLevels")
    }
    
    func wasAnswerCorrect(forQuestion questionNumber : Int, optionChosen: Int) -> Bool {
        
        return questions[questionNumber].options[optionChosen].isCorrect
    }
    
    
    
    func shortExplanationForCurrentQuestion() -> String {
        return explanations[currentQuestionNumber].shortText
    }
    
    func linkForCurrentQuestion() -> URL {
        return explanations[currentQuestionNumber].link
    }

    func saveData() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.passedLevels, forKey: "passedLevels")
    }
    
    
    func getCurrentQuestion() -> question {        
        return questions[currentQuestionNumber]
    }
    
    func acceptSelectedAnswer(optionChosen: Int) {
        
        lastOptionChosen = optionChosen
        
        currentUsersAnswers[currentLevel]!.append(optionChosen)
        
        if wasAnswerCorrect(forQuestion: currentQuestionNumber, optionChosen: lastOptionChosen) {
            numberOfCorrectAnswersSoFar += 1
        }
        
    }
    
    func sendResultsForTheLevel() {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        var parameters = Parameters()
        
        var i = 0
        for answer in currentUsersAnswers[currentLevel]! {
            var value = "\(answer),"
            let wascorrect = wasAnswerCorrect(forQuestion: i, optionChosen: answer) ? "YES" : "NO"
            i += 1
            
            let qNumberToSend = i + currentLevel * numberOfQuestionsPerLevel
            value += wascorrect
            parameters["q\(qNumberToSend)"] = value
        }
        
        parameters["correct_answers"] = "\(numberOfCorrectAnswersSoFar)"
        
        //print(parameters)
        
        sessionManager =  Alamofire.SessionManager(configuration: configuration)
        
        sessionManager.request("https://pohmelje.ru/victorina/", method: .post, parameters: parameters).responseString { response in
            
            // print(response)
            
        }
        
        
    }
    
    
    func updateLevelPassedAndSave() {
        
        if wereAllQuestionsAnswered() {
            
            passedLevels = currentLevel
            
            saveData()
        }
        
    }
    
    func wereAllQuestionsAnswered() -> Bool {
        return numberOfCorrectAnswersSoFar == numberOfQuestionsPerLevel
    }
    
    func resetLevels() {
        let userDefaults = UserDefaults.standard
        self.passedLevels = 0
        userDefaults.set(0, forKey: "passedLevels")
    }
    
    
    func isThereNextLevel() -> Bool {
        return currentLevel + 1 == numberOfLevels
    }
    

}
