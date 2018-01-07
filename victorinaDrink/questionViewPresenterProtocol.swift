//
//  questionPresenterProtocol.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

protocol questionViewPresenterProtocol {
        
    func showCurrentQuestion()
    
    func acceptSelectedAnswer(optionChosen: Int)
    
    func showAnswer()

}
