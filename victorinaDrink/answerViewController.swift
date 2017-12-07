//
//  answerViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit

class answerViewController: UIViewController {

    @IBOutlet weak var correctOrNotLabel: UILabel!
    
    @IBOutlet weak var explanationView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        correctOrNotLabel.text = engine.wasAnswerCorrect() ? "Верно!" : "Неверно!"
        
        explanationView.loadHTMLString(engine.explanationForCurrentQuestion(), baseURL: URL(string: "")  )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
    
  print(segue.identifier)
 if (segue.identifier == "nextQuestion")
 {
 engine.goToNextQuestion()
 }
 }

}
