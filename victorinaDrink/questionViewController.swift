//
//  questionViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 05/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit

class questionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionText: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
@IBOutlet weak var dynamicTVHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        
        questionText.text = engine.getCurrentQuestion().text
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let count = engine.getCurrentQuestion().answers.count
        
        return count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCellID", for: indexPath) as! optionCell
        
        let text = engine.getCurrentQuestion().answers[indexPath.row]
        
        cell.optionLabel.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        engine.acceptSelectedAnswer(answerNumber: indexPath.row)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Answer")
        self.present(viewController, animated: true, completion: nil)
        
    }
   
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        tableView.reloadData()
        self.view.layoutIfNeeded()

        let height = tableView.contentSize.height

        print(height)

        dynamicTVHeight.constant = height
        self.view.layoutIfNeeded()
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
