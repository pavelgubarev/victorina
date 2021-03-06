//
//  answerViewPresenter.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 07/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation


public class answerViewPresenter : answerViewPresenterProtocol {
    private var view: answerViewProtocol
    private let model: modelClass
    
    public required init(withView: answerViewProtocol, withModel: modelClass) {
        self.view = withView
        self.model = withModel
    }

    public func setAnswer() {
        
        
        view.wasAnswerCorrect =  model.wasAnswerCorrect(forQuestion: model.currentQuestionNumber, optionChosen: model.lastOptionChosen)
        
        if view.wasAnswerCorrect {
            model.scores.keepScoresForAnswer()
        } else {
            model.scores.setZeroForTheWrongAnswer()
        }
        
        view.shortExplanation = model.shortExplanationForCurrentQuestion()
        
        if model.currentQuestionNumber < 14 {
            view.peopleNumber = model.returnComparison(questionNumber: model.currentQuestionNumber, optionNumber: model.lastOptionChosen)
        }
        
        view.linkForCurrentQuestion = model.linkForCurrentQuestion()
        
        view.isLevelOver = model.isLevelOver()
        
        view.setAnswer()
    }
    
//    func gotoExplanationPage() {
//        view.gotoExplanationURL()
//    }
    
    func showResultsForTheLevel() {
        model.updateLevelPassedAndSave()
        
        view.gotoResultsForTheLevel()
        
    }
    
    func goToNextQuestion() {
        model.goToNextQuestion()
    }
    
    func nextQuestionButtonTapped() {
        if model.isLevelOver() {
            self.showResultsForTheLevel()
        }
    }
    
    func gotoLongExplanationTapped() {
        model.scores.addScoresForReading()
    }
}

