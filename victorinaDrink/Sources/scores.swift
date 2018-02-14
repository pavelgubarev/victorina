//
//  scores.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 14/02/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation
import ReactiveSwift


struct Scores {
    var bonusForTheCurrentQuesion : Double = 0 {
        
        didSet {
            if bonusForTheCurrentQuesion < 0 {
                self.bonusForTheCurrentQuesion = 0
            }
            
            
            var numberToDisplay = bonusForTheCurrentQuesion * 100
            
            numberToDisplay = round(numberToDisplay)
            
            numberToDisplay /= 100
            
            self.bonusForTheCurrentQuesionString.value = "\(numberToDisplay) бонусов"
            
        }
    }
    
    var bonusForTheCurrentQuesionString = MutableProperty<String>("")
    
    var scoresForTheLastAnswer = 0.0
    
    mutating func resetBonus() {
        bonusForTheCurrentQuesion = 30.0
    }
    
    var totalScoresForLevel = 0.0
    
    mutating func keepScoresForAnswer() {
        
        scoresForTheLastAnswer = Double(model.getCurrentQuestion().scores) + bonusForTheCurrentQuesion
        
        self.totalScoresForLevel += scoresForTheLastAnswer
    }
    
}
