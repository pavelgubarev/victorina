//
//  mainPresenter.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

class startPagePresenter : startPagePresenterProtocol {
    
    private let view: startPageViewProtocol
    private let model: modelClass
    
    required init(withView: startPageViewProtocol, withModel: modelClass) {
        self.view = withView
        self.model = withModel
    }
    
    func setStartPage() {
        view.hasUserAccessToLevel2 = model.hasUserAccessToLevel2()
    }
    
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
    
    func ayPohmeljeButtonTapped() {
        view.gotoAyPohmelje()
    }
    
}
