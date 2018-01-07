//
//  questionView.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

protocol questionViewProtocol : class {
 
  func setCurrentQuestion(withQuestion: question)
    
  func showAnswer()
    
}
