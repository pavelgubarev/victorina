//
//  YourNameViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 16/02/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import UIKit

class YourNameViewController: UIViewController {
    
    
    
    @IBOutlet weak var yourNameTextField: UITextField!
    
  
    
    func yourNameSend() {
        
        model.userName = yourNameTextField.text!
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        yourNameSend()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
