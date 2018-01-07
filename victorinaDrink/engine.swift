//
//  engine.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 05/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import Foundation
import UIKit


class engineClass {
    
    

    func initUsersAnswers() {
        for i in 1...numberOfLevels {
            currentUsersAnswers[i] = [Int]()
        }
    }
    
    func goToLevel2() {
        currentLevel = 2
        
        currentQuestionNumber = numberOfQuestionsPerLevel * (currentLevel - 1)
    }
    
    func accessToLevel2() -> Bool {
        return engine.passedLevels > 0
    }
    
  
    
    func shareFB() {
        
        let url = URL(string: "https://www.facebook.com/sharer/sharer.php?u=https://pohmelje.ru/victorinaShare/")!
        
         UIApplication.shared.open( url, options: [:], completionHandler: nil)
    }
    
    



   
   
    
  
    
  
    func goToNextQuestion() {
        currentQuestionNumber = currentQuestionNumber + 1
      
        
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
