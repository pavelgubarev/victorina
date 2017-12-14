//
//  levelResultViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 12/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import StoreKit

class levelResultViewController: UIViewController {

    @IBOutlet weak var yourResultLabel: UILabel!
    
    @IBOutlet weak var nextLevelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yourResultLabel.text = "Ваш результат: \(engine.numberOfCorrectAnswersSoFar) из 8"

        if (!engine.isThereNextLevel()) {
            nextLevelButton.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "nextLevel" {
            engine.nextLevel()

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
         if (!engine.isThereNextLevel()) {
            askForReviews()
        }
    }

    func askForReviews() {
        
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
        }
        
    }
}
