//
//  levelResultViewPresenter.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 07/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

class levelResultViewPresenter : levelResultPresenterProtocol {
    private var view: levelResultViewProtocol
    private let model: modelClass
    
    required init(withView: levelResultViewProtocol, withModel: modelClass) {
        self.view = withView
        self.model = withModel
    }
    
    func setLevelResult() {
        
        view.yourResultLabelText = "Ваш результат: \(model.numberOfCorrectAnswersSoFar) из 7"
        
        view.isThereNextLevel = model.isThereNextLevel()
        
        view.wereAllQuestionsAnsweredCorrectly = model.wereAllQuestionsAnsweredCorrectly()
        
        if model.wereAllQuestionsAnsweredCorrectly() || model.currentLevel == model.numberOfLevels {
            view.isGameOver = true
        } else {
            view.isGameOver = false
        }

        if model.wereAllQuestionsAnsweredCorrectly() && model.currentLevel == model.numberOfLevels {
            view.showYourNameForm()
        }
        view.setLayout()
    }
    
    func nextLevelButtonTapped() {
        if model.wereAllQuestionsAnsweredCorrectly() {
            nextLevel()
        }
    }
    
    
    func nextLevel() {
        model.resetAnswers()
        model.currentLevel += 1
        
        model.goToNextQuestion()
        
    }
    
    func restartLevelButtonTapped() {
        model.resetAnswers()
        model.currentUsersAnswers[model.currentLevel] = [Int]()
        model.currentQuestionNumber = (model.currentLevel - 1) * model.numberOfQuestionsPerLevel
    }
    
    func viewDidAppearAskForReviews() {
        if (!model.isThereNextLevel()) {
            if model.wereAllQuestionsAnsweredCorrectly() {
                view.askForReviews()
            }
        }

    }
    
    func shareByFBButtonTapped() {        
       view.shareFB()
    }
    
    func shareByMailButtonTapped() {
        view.shareMail()
    }

}
