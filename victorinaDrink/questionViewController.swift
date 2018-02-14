//
//  questionViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 05/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class questionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, questionViewProtocol  {
    
    
    
    
    var currentQuestion: question!
    
    var presenter : questionViewPresenter!
    
    func setCurrentQuestion(withQuestion: question) {
        currentQuestion = withQuestion
        
        scoresLabel.reactive.text <~ currentQuestion.scoresString

        bonusLabel.reactive.text <~ model.scores.bonusForTheCurrentQuesionString

        questionTextLabel.text = currentQuestion.text
    }
    
    @IBOutlet weak var scoresLabel: UILabel!
    
    @IBOutlet weak var bonusLabel: UILabel!
    
    
    @IBOutlet weak var questionTextLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dynamicTVHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        
        presenter = questionViewPresenter(withView: self, withModel: model)
        
        presenter.showCurrentQuestion()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        presenter.changeBonus()
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
        
        let count = currentQuestion.options.count
        
        return count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCellID", for: indexPath) as! optionCell
        
        let text = currentQuestion.options[indexPath.row].text
        
        cell.optionLabel.text = text
        
        let selectedView = UIView()
        selectedView.frame = selectedView.frame.insetBy(dx: 0, dy: 10)
        selectedView.layer.cornerRadius = 10
        selectedView.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        cell.selectedBackgroundView = selectedView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter.acceptSelectedAnswer(optionChosen: indexPath.row)
              
        
    }
    
    func showAnswer() {        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Answer")
        self.present(viewController, animated: false, completion: nil)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.layoutIfNeeded()
        
        let height = tableView.contentSize.height
        
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
