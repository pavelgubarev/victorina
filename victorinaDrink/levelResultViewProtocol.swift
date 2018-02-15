//
//  levelResultViewProtocol.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 07/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

protocol levelResultViewProtocol {
    
    var yourResultLabelText : String {get set}
    
    var isThereNextLevel : Bool {get set}
    
    var wereAllQuestionsAnsweredCorrectly : Bool {get set}
    
    var isGameOver : Bool {get set}
    
    func askForReviews()
    
    func setLayout()
    
    func shareFB()
    
    func shareMail()
    
    func showYourNameForm()
    
}
