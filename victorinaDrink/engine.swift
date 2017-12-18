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

struct option {
    var text : String = ""
    var isCorrect : Bool = false
}

struct question {
    var text : String = ""
    var options = [option]()
}

struct explanation {
    var shortText : String = ""
    var link : URL!
}

extension explanation {
    init?(json: [String: Any]) {
        
        
        
        guard let shortDescription = json["Short Description"] as? String,
            let link = json["Link"] as?  String
            else {
                return nil
        }
        self.shortText = shortDescription
        self.link = URL(string: link)
    }
}

class engineClass {
    var questions = [question]()
    var explanations = [explanation]()
    var answers = [Int]()
    var correctAnswers = [Int]()
    var currentQuestionNumber : Int = 0
    var numberOfCorrectAnswersSoFar = 0
    var currentLevel = 1
    
    let numberOfQuestionsPerLevel = 7
    
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
        
        var qJson = [Any]()
        var qDicOptions = [[String:Any]]()
        
        var previousLine : String = ""

        for line in fromStrings {
            

            if line.count == 0 {
                let newQuestion = question()
                
                
                questions.append(newQuestion)
                qNumber = questions.count - 1
                answerNumber = 0
                
            } else {
                if answerNumber == 0 {
                    questions[qNumber].text = line
                    
                    

                    var qDic = [String : Any]()
                    
                    qDic["text"] = previousLine
                    qDic["options"] = qDicOptions
                    
                    qDicOptions = [[String:Any]]()
                    previousLine = line
                    
                    qJson.append(qDic)
                    
                    
                } else {
                    
                    let answerArr = line.components(separatedBy: "|")
                    
                    var dOption = option()
                    
                    dOption.isCorrect = answerArr[0] == "+" ? true : false
                    dOption.text = answerArr[1]
                    
                    var dic = [String: Any]()
                    
                    dic["isCorrect"] = dOption.isCorrect
                    dic["text"] = dOption.text
                    
                    qDicOptions.append(dic)
                    
                    questions[qNumber].options.append(dOption)
                }
                answerNumber = answerNumber + 1
            }
        }
        
        do {
            
            //Convert to Data
            let jsonData = try JSONSerialization.data(withJSONObject: qJson, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //Convert back to string. Usually only do this for debugging
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                print(JSONString)
            }
            
            //In production, you usually want to try and cast as the root data structure. Here we are casting as a dictionary. If the root object is an array cast as [Any].
            var json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
            
            
        } catch {
            print(error)
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
        
        if wasAnswerCorrect() {
            numberOfCorrectAnswersSoFar += 1
        }
        
    }
    
    func wasAnswerCorrect() -> Bool {
        return answers[currentQuestionNumber] == correctAnswers[currentQuestionNumber]
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
            i += 1
            var value = "\(answer),"
            let wascorrect = answer == correctAnswers[i-1] ? "YES" : "NO"
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
