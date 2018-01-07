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
    var linkForCurrentQuestion: URL
    
    var wasAnswerCorrect: Bool = false
    
    var shortExplanation : String = ""
    
    var peopleNumber : String?

    @IBOutlet weak var correctOrNotLabel: UILabel!
 
    @IBOutlet weak var explanationLabel: UILabel!
    
    @IBOutlet weak var skView: SKView!
    
    @IBOutlet weak var learnMoreButton: UIButton!
    
    @IBOutlet weak var howManyPeople: UILabel!
    
    var presenter : answerViewPresenter!
    
    func setAnswer() {
        
        correctOrNotLabel.text =  wasAnswerCorrect ? "Верно!" : "Неверно!"
        
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
        
        skView.backgroundColor = UIColor.clear
        
        
    }
    
    func gotoExplanationPage() {
        UIApplication.shared.open( linkForCurrentQuestion, options: [:], completionHandler: nil)
    }
    
    @IBAction func gotoSite(_ sender: Any) {
        presenter.gotoExplanationPage()
    }
    
    func makePad() {
        let pad = UIView()
        var padFrame = explanationLabel.frame.insetBy(dx: -10.0, dy: -10.0)
        
        padFrame.size = CGSize(width: padFrame.size.width, height: padFrame.size.height + 36)
        pad.frame = padFrame
        
        pad.backgroundColor = .white
        
        pad.layer.cornerRadius = 10
        
        self.view.addSubview(pad)
        self.view.bringSubview(toFront: explanationLabel)
        
        self.view.bringSubview(toFront: learnMoreButton)
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
        
        let scene = wasAnswerCorrect ? glassesScene.copy() as! SKScene : kefirScene.copy() as! SKScene
        
        skView.presentScene(scene)
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "nextQuestion")  {
            engine.goToNextQuestion()
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        var shouldWe = true
        if (identifier == "nextQuestion")  {
            shouldWe = !engine.isLevelOver()
        }
        
        if (!shouldWe) {
            presenter.showResultsForTheLevel()
            
            
        }
        
        return shouldWe
    }
    
    func gotoLevelResults() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "levelResults")
        self.show(mainViewController, sender: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        skView.removeFromSuperview()
    }
    

}
