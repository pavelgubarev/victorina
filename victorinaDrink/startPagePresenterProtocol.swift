//
//  mainPresenter.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

protocol startPagePresenterProtocol {
    
    func startPuttonPressed()
    
    func resetLevels()
    
    func goToNextQuestionButtonTapped()
    
    func goToLevel2ButtonTapped()
    
    func resetGame()
    
    func accessToLevel2() -> Bool
}
