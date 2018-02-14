//
//  questionPresenter.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation
import UIKit

public class questionViewPresenter {
    private let view: questionViewProtocol
    private let model: modelClass
    
    public required init(withView: questionViewProtocol, withModel: modelClass) {
        self.view = withView
        self.model = withModel
    }
    
    func showCurrentQuestion() {
        view.setCurrentQuestion(withQuestion: model.getCurrentQuestion())
        model.scores.resetBonus()
    }
    
    func changeBonus() {
        
        self.model.scores.bonusForTheCurrentQuesion -= 0.3
        
        
        delay(0.3) {
            
            guard (self.model.scores.bonusForTheCurrentQuesion > 0 ) else {return}
            
            self.changeBonus() }
    }
    

    public func acceptSelectedAnswer(optionChosen: Int) {
        
        model.acceptSelectedAnswer(optionChosen: optionChosen)
        
        view.showAnswer()
        
    }

}
