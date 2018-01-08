//
//  startPageViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 14/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import SpriteKit


class startPageViewController: UIViewController, startPageViewProtocol {
    
    let dev = false
    
    var presenter : startPagePresenterProtocol!
    
    var hasUserAccessToLevel2 : Bool = false
    
    @IBOutlet weak var skView: SKView!
    
    @IBAction func resetLevels(_ sender: Any) {
        presenter.resetLevels()
    }
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var level2Button: UIButton!
    
    @IBAction func ayPohmelje(_ sender: Any) {        
       presenter.ayPohmeljeButtonTapped()
    }
    
    func gotoAyPohmelje() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id476347173"),
            UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }
    }
    
    @IBAction func backToMain(unwindSegue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = startPagePresenter(withView: self, withModel: model)
        
        presenter.setStartPage()
        
        level2Button.alpha = hasUserAccessToLevel2 ? 1 : 0.3
        
        skView.backgroundColor = UIColor.clear
        
        if !dev {
            resetButton.removeFromSuperview()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let scene = SKScene(fileNamed: "kefirfallingStart")!
        scene.scaleMode = .aspectFill
        
        
        skView.presentScene(scene)
       
        presenter.resetGame()
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        var shouldWe = true
        if identifier == "gotoLevel2" {
            shouldWe = hasUserAccessToLevel2
        }
        
        return shouldWe
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "nextQuestion")  {
            presenter.goToNextQuestionButtonTapped()
        }
        if (segue.identifier == "gotoLevel2")  {
            presenter.goToLevel2ButtonTapped()
        }
        
        
    }
   
    
}
