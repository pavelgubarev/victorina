//
//  answerViewProtocol.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 07/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

public protocol answerViewProtocol {
    
    var wasAnswerCorrect : Bool!  { get set }
    
    var shortExplanation : String { get set }
    
    var peopleNumber : String? { get set }
    
    var linkForCurrentQuestion : URL { get set }
    
    var isLevelOver : Bool! { get set }

    func setAnswer()
    
//    func gotoExplanationURL()
    
    func gotoResultsForTheLevel()
    
}
