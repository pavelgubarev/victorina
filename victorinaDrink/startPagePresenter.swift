//
//  mainPresenter.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

class startPagePresenter : startPagePresenterProtocol {
    
    func startPuttonPressed() {
        
    }
    
    func resetLevels() {
        model.resetLevels()
    }
    
    func goToNextQuestionButtonTapped() {
        
    }
    
    func goToLevel2ButtonTapped() {
            model.currentLevel = 2
            
            model.currentQuestionNumber = model.numberOfQuestionsPerLevel * (model.currentLevel - 1)
        
    }
    
    func resetGame() {
        model.resetGame()
    }
    
    func accessToLevel2() -> Bool {
        return model.passedLevels > 0
    }
    
}
