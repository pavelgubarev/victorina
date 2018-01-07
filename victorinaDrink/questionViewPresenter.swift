//
//  questionPresenter.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation
import UIKit

class questionViewPresenter {
    private let view: questionViewProtocol
    private let model: modelClass
    
    required init(withView: questionViewProtocol, withModel: modelClass) {
        self.view = withView
        self.model = withModel
    }
    
    func showCurrentQuestion() {
        view.setCurrentQuestion(withQuestion: model.getCurrentQuestion())
    }
    
    func showAnswer() {
        self.view.showAnswer()
    }
    
    func acceptSelectedAnswer(optionChosen: Int) {
        
        model.acceptSelectedAnswer(optionChosen: optionChosen)
        
    }

}
