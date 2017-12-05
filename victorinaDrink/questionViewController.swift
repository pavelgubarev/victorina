//
//  questionViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 05/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit

class questionViewController: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    
    var optionsController : UITableViewController!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "embedOptions")
        {
            optionsController = segue.destination as! UITableViewController
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionText.text = engine.getCurrentQuestion().text

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
