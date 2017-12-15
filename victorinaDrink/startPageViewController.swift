//
//  startPageViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 14/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import SpriteKit

var engine : engineClass!

class startPageViewController: UIViewController {
    
    @IBOutlet weak var skView: SKView!
    
    @IBAction func backToMain(unwindSegue: UIStoryboardSegue) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        engine = engineClass()
        
        skView.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        let scene = SKScene(fileNamed: "kefirfallingStart")!
        scene.scaleMode = .aspectFill
        

        skView.presentScene(scene)
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
