//
//  startPageViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 14/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import SpriteKit


class startPageViewController: UIViewController {
    
    let dev = false
    
    var presenter : startPagePresenterProtocol!
    
    @IBOutlet weak var skView: SKView!
    
    @IBAction func resetLevels(_ sender: Any) {
        presenter.resetLevels()
    }
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var level2Button: UIButton!
    
    @IBAction func ayPohmelje(_ sender: Any) {
        
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id476347173"),
            UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }
    }
    @IBAction func backToMain(unwindSegue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = startPagePresenter()
        
        level2Button.alpha = presenter.accessToLevel2() ? 1 : 0.3
        
        skView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
        
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
            shouldWe = presenter.accessToLevel2()
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
