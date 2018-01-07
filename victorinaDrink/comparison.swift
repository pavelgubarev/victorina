//
//  comparison.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 27/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import Foundation
import Alamofire

extension modelClass {

    func loadComparison() {
        
        Alamofire.request("https://pohmelje.ru/victorinaStats/3", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            
            if let result = response.result.value {
                self.comparisonData = result as? NSDictionary
               
            }
            
            
        }
    }
    
    func returnComparison(questionNumber: Int, optionNumber : Int) -> String? {
        if let comparison = comparisonData {
            
            let optionsData = comparison["q\(questionNumber)"] as! NSDictionary
            
            let number = optionsData["option\(optionNumber)"] as! String
            let numberOfPeople = Double(number)!
            
            var totalPeople : Double!            
            
            if questionNumber > 6 {
                totalPeople = Double(comparison["totalCountLVL2"] as! String)!
            } else {
                totalPeople = Double(comparison["totalCount"] as! String)!
            }
            
            let percentage = round(numberOfPeople / totalPeople * 100)
            
            return "\(Int(numberOfPeople))(\(percentage)%)"
            
        } else {
            return nil
        }
    }
    
}
