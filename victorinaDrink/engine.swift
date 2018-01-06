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
    
    var comparisonData : NSDictionary?

    let numberOfQuestionsPerLevel = 7
    
    let numberOfLevels = 2

    var questions = [question]()
    
    var explanations = [explanation]()
    
    var currentUsersAnswers = [Int:[Int]]()
    
    var currentQuestionNumber : Int = 0
    
    var numberOfCorrectAnswersSoFar = 0
    
    var lastOptionChosen : Int = 0
    
    var currentLevel = 1
    
    var passedLevels = 0
    
    var sessionManager : SessionManager!

    func initUsersAnswers() {
        for i in 1...numberOfLevels {
            currentUsersAnswers[i] = [Int]()
        }
    }
    
    init() {
        loadQuestions()
        loadExplanations()
        
        loadComparison()
    }
    
    func goToLevel2() {
        currentLevel = 2
        
        currentQuestionNumber = numberOfQuestionsPerLevel * (currentLevel - 1)
    }
    
    func accessToLevel2() -> Bool {
        return engine.passedLevels > 0
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
    
    func getCurrentQuestion() -> question {
                
        return questions[currentQuestionNumber]
    }
    
    func shareFB() {
        
        let url = URL(string: "https://www.facebook.com/sharer/sharer.php?u=https://pohmelje.ru/victorinaShare/")!
        
         UIApplication.shared.open( url, options: [:], completionHandler: nil)
    }
    
    



    func saveData() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.passedLevels, forKey: "passedLevels")
    }
    
    func loadData() {
        let userDefaults = UserDefaults.standard

        self.passedLevels = userDefaults.integer(forKey: "passedLevels")
    }
   
    
    func acceptSelectedAnswer(optionChosen: Int) {
        
        lastOptionChosen = optionChosen
        
        currentUsersAnswers[currentLevel]!.append(optionChosen)
        
        if wasAnswerCorrect(forQuestion: currentQuestionNumber, optionChosen: lastOptionChosen) {
            numberOfCorrectAnswersSoFar += 1
        }
        
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

    func goToNextQuestion() {
        currentQuestionNumber = currentQuestionNumber + 1
      
        
    }
    
    func isLevelOver() -> Bool {
        
        return (currentQuestionNumber + 1) % numberOfQuestionsPerLevel == 0
    }
    
    func showResultsForTheLevel() {
        sendResultsForTheLevel()
        
        updateLevelPassedAndSave()
        
    }
    
    func updateLevelPassedAndSave() {
        
        if wereAllQuestionsAnswered() {
            
            passedLevels = currentLevel
            
            saveData()
        }
        
    }
    
    
    func sendResultsForTheLevel() {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        var parameters = Parameters()
        
        var i = 0
        for answer in currentUsersAnswers[currentLevel]! {
            var value = "\(answer),"
            let wascorrect = engine.wasAnswerCorrect(forQuestion: i, optionChosen: answer) ? "YES" : "NO"
            i += 1
            
            let qNumberToSend = i + currentLevel * numberOfQuestionsPerLevel
            value += wascorrect
            parameters["q\(qNumberToSend)"] = value
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
    
    func resetGame() {
        resetAnswers()
        initUsersAnswers()
        currentQuestionNumber = 0
    }
    
    
    func restartLevel() {
        resetAnswers()
        currentUsersAnswers[currentLevel] = [Int]()
        currentQuestionNumber = (currentLevel - 1) * numberOfQuestionsPerLevel
    }
    
    func nextLevel() {
        resetAnswers()
        currentLevel += 1
        
        self.goToNextQuestion()

    }
    
}
