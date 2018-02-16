//
//  answerViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import SpriteKit

class answerViewController: UIViewController, answerViewProtocol {
    
    
  
    var linkForCurrentQuestion: URL? = URL(string: "https://pohmelje.ru")!
    
    var wasAnswerCorrect: Bool! = false
    
    var shortExplanation : String = ""
    
    var peopleNumber : String?
    
    var isLevelOver: Bool!
    
    var alreadyShown = false
    
    

    @IBOutlet weak var scoresLabel: UILabel!
    
    
    @IBOutlet weak var correctOrNotLabel: UILabel!
 
    @IBOutlet weak var explanationLabel: UILabel!
    
    @IBOutlet weak var skView: SKView?
    
    @IBOutlet weak var learnMoreButton : UIButton?
    
    @IBOutlet weak var howManyPeople: UILabel!
    
    var presenter : answerViewPresenterProtocol!
    
    func setAnswer() {
        
        correctOrNotLabel.text =  wasAnswerCorrect ? "Верно!" : "Неверно!"
        
        if !wasAnswerCorrect {
            scoresLabel.text = "+0 очков"
        } else {
            scoresLabel.text = "+\(model.scores.scoresForTheLastAnswer) очков!"
        }
        
        explanationLabel.text = shortExplanation
        
        explanationLabel.sizeToFit()

        if let peopleNumberString = peopleNumber  {
            howManyPeople.text = "\(peopleNumberString) человек ответили так же"
        } else {
            howManyPeople.removeFromSuperview()
        }        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        presenter = answerViewPresenter(withView: self, withModel: model)

        presenter.setAnswer()
        
        skView?.backgroundColor = UIColor.clear
        
        if model.longExplanationFileForCurrentQuestion().count == 0 {
            learnMoreButton!.removeFromSuperview()
            learnMoreButton = nil
        }
    }
    
//    func gotoExplanationURL() {
//        UIApplication.shared.open( linkForCurrentQuestion, options: [:], completionHandler: nil)
//    }
    
//    @IBAction func gotoSite(_ sender: Any) {
//        presenter.gotoExplanationPage()
//    }
    
    func makePad() {
        let pad = UIView()
        var padFrame = explanationLabel.frame.insetBy(dx: -10.0, dy: -10.0)
        
        let bottomMargin = learnMoreButton != nil ? 36.0 : 10.0
        
        padFrame.size = CGSize(width: padFrame.size.width, height: padFrame.size.height + CGFloat(bottomMargin))
        pad.frame = padFrame
        
        pad.backgroundColor = .white
        
        pad.layer.cornerRadius = 10
        
        self.view.addSubview(pad)
        self.view.bringSubview(toFront: explanationLabel)
        
        if learnMoreButton != nil {
            self.view.bringSubview(toFront: learnMoreButton!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.layoutIfNeeded()
        
        makePad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
   
        
        guard alreadyShown == false else {
            return
        }
        alreadyShown = true

        let scene = wasAnswerCorrect ? glassesScene.copy() as! SKScene : kefirScene.copy() as! SKScene
        
        skView?.presentScene(scene)
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "nextQuestion")  {
            presenter.goToNextQuestion()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        var shouldWe = true
        if (identifier == "nextQuestion")  {
            shouldWe = !isLevelOver
            presenter.nextQuestionButtonTapped()
        }
        
        
        return shouldWe
    }
    
    func gotoResultsForTheLevel() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "levelResults")
        self.show(mainViewController, sender: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        skView?.removeFromSuperview()
    }
    

}
