//
//  model.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation
import Alamofire
import ReactiveSwift


public class modelClass {
    
    var comparisonData : NSDictionary?
    
    public var explanations = [explanation]()
    
    public var questions = [question]()
    
    public let numberOfQuestionsPerLevel = 7
    
    public let numberOfLevels = 3
    
    var currentUsersAnswers = [Int:[Int]]()
    
    var currentQuestionNumber : Int = 0
    
    var numberOfCorrectAnswersSoFar = 0
    
    var lastOptionChosen : Int = 0
    
    var currentLevel = 1
    
    var passedLevels = 0
    
    var sessionManager : SessionManager!
    
    var scores = Scores()
    
    var userName = ""
    
   
    //MARK: init
    public init() {
        
        loadQuestions()
        loadExplanations()
        
        loadComparison()
    }
    
    //MARK: save to disk
    func loadData() {
        let userDefaults = UserDefaults.standard
        
        self.passedLevels = userDefaults.integer(forKey: "passedLevels")
        
        for dLevel in 1...numberOfLevels {
            let oneScore = userDefaults.double(forKey: "scoreForLevel\(dLevel)")
            
              //  print("from memory", oneScore)
                
            self.scores.scoresForOldLevels.append(oneScore)
        }
    }
    
    func saveData() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(self.passedLevels, forKey: "passedLevels")
        
        let oldScore = self.scores.scoresForOldLevels[self.currentLevel - 1]
       // print("oldScore", oldScore)
        
        let newScore = self.scores.totalScoresForLevel
        
       // print("newScore", newScore)
        
        if newScore > oldScore {
            userDefaults.set(self.scores.totalScoresForLevel, forKey: "scoreForLevel\(self.currentLevel)")
        }

        
    }
    

    //MARK: questions and answers
    func wasAnswerCorrect(forQuestion questionNumber : Int, optionChosen: Int) -> Bool {
        
        return questions[questionNumber].options[optionChosen].isCorrect
    }
    
    
    func shortExplanationForCurrentQuestion() -> String {
        return explanations[currentQuestionNumber].shortText
    }
    
    func longExplanationFileForCurrentQuestion() -> String {
        return explanations[currentQuestionNumber].longTextFile
    }
    
    
    func linkForCurrentQuestion() -> URL? {
        return explanations[currentQuestionNumber].link
    }

    
    func getCurrentQuestion() -> question {        
        return questions[currentQuestionNumber]
    }
    
    public func acceptSelectedAnswer(optionChosen: Int) {
        
        lastOptionChosen = optionChosen
        
        currentUsersAnswers[currentLevel]!.append(optionChosen)
        
        if wasAnswerCorrect(forQuestion: currentQuestionNumber, optionChosen: lastOptionChosen) {
            numberOfCorrectAnswersSoFar += 1
        }
        
    }
    
    public func goToNextQuestion() {
        currentQuestionNumber = currentQuestionNumber + 1
    }
    
    //MARK: send results to server
    func sendResultsForTheLevel() {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        var parameters = Parameters()
        
        var i = (currentLevel - 1) * numberOfQuestionsPerLevel
        for answer in currentUsersAnswers[currentLevel]! {
            var value = "\(answer),"
            let wascorrect = wasAnswerCorrect(forQuestion: i, optionChosen: answer) ? "YES" : "NO"
            
            value += wascorrect
            parameters["q\(i)"] = value
            i += 1
        }
        
        parameters["correct_answers"] = "\(numberOfCorrectAnswersSoFar)"
        parameters["scores_for_the_level"] = "\(scores.totalScoresForLevel)"
        parameters["scores_for_the_game"] = "\(scores.totalScoresForGame)"
        parameters["user_name"] = "\(model.userName)"

        //print(parameters)
        
        sessionManager =  Alamofire.SessionManager(configuration: configuration)
        
        //print(parameters)
        
        sessionManager.request("https://pohmelje.ru/victorina/", method: .post, parameters: parameters).responseString { response in
            
           // print(response)
                        
        }
        
        
    }
    
    
    func updateLevelPassedAndSave() {
        
        if wereAllQuestionsAnsweredCorrectly() {
            
            passedLevels = currentLevel
            
        }
        
        saveData()
    }
    
    public func wereAllQuestionsAnsweredCorrectly() -> Bool {
        return numberOfCorrectAnswersSoFar == numberOfQuestionsPerLevel
    }
    
    func resetLevels() {
        let userDefaults = UserDefaults.standard
        self.passedLevels = 0
        userDefaults.set(0, forKey: "passedLevels")
    }
    
    
    func isThereNextLevel() -> Bool {
        
        return currentLevel + 1 <= numberOfLevels
    }
    
    
    func isLevelOver() -> Bool {
        
        return (currentQuestionNumber + 1) % numberOfQuestionsPerLevel == 0
    }
    
    
    func resetAnswers() {
        numberOfCorrectAnswersSoFar = 0
    }
    
    func resetGame() {
        resetAnswers()
        initUsersAnswers()
        currentQuestionNumber = 0
    }
    
    public func initUsersAnswers() {
        for i in 1...self.numberOfLevels {
            self.currentUsersAnswers[i] = [Int]()
        }
    }
    
    public func hasUserAccessToLevel2() -> Bool {
        return passedLevels > 0
    }
    

}
