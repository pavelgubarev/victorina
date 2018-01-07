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
    
    @IBOutlet weak var skView: SKView!
    
    @IBAction func resetLevels(_ sender: Any) {
        engine.resetLevels()
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
        
        level2Button.alpha = engine.accessToLevel2() ? 1 : 0.3
        
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
       
        engine.resetGame()
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        var shouldWe = true
        if identifier == "gotoLevel2" {
            shouldWe = engine.accessToLevel2()
        }
        
        return shouldWe
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "nextQuestion")  {
            engine.goToNextQuestion()
        }
        if (segue.identifier == "gotoLevel2")  {
            engine.goToLevel2()
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
