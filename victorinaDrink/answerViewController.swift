//
//  answerViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import SpriteKit

class answerViewController: UIViewController {

    @IBOutlet weak var correctOrNotLabel: UILabel!
 
    @IBOutlet weak var explanationLabel: UILabel!
    
    @IBOutlet weak var skView: SKView!
    
    @IBOutlet weak var learnMoreButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        correctOrNotLabel.text = engine.wasAnswerCorrect() ? "Верно!" : "Неверно!"
        
        explanationLabel.text = engine.explanationForCurrentQuestion()
        
        explanationLabel.sizeToFit()
        
        
        
    }
    @IBAction func gotoSite(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: engine.linkForCurrentQuestion())! as URL, options: [:], completionHandler: nil)
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
        
        
        let scene = kefirFalling(fileNamed: "kefirfalling")!
        
        scene.scaleMode = .aspectFit
        
        skView.backgroundColor = UIColor.clear
        
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
            engine.showResultsForTheLevel()
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "levelResults")
            self.show(mainViewController, sender: self)
        }
        
        return shouldWe
    }
    
    

}
