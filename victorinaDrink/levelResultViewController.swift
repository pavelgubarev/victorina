//
//  levelResultViewController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 12/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI
import Alamofire

class levelResultViewController: UIViewController, levelResultViewProtocol, MFMailComposeViewControllerDelegate {


    
    @IBOutlet weak var yourNameForm: UIView!
    
    
    @IBOutlet weak var yourNameTextField: UITextField!
    
    @IBAction func skipYourName(_ sender: Any) {
        dismissYourNameForm()
    }
    
    @IBOutlet weak var yourNameSendButton: UIButton!
    
    
    func dismissYourNameForm() {
        yourNameForm.removeFromSuperview()
        
        model.sendResultsForTheLevel()
        
        presenter.viewDidAppearAskForReviews()
        

    }
    
    func showYourNameForm() {
        self.view.addSubview(yourNameForm)
    }
    
    @IBAction func yourNameSend(_ sender: Any) {
        
        
        model.userName = yourNameTextField.text!
            
        dismissYourNameForm()
        
    }
    var presenter : levelResultPresenterProtocol!


    @IBOutlet weak var levelScoresLabel: UILabel!
    
    var yourResultLabelText : String = ""
    
    var isThereNextLevel : Bool = false
    
    var wereAllQuestionsAnsweredCorrectly : Bool = false
    
    var isGameOver : Bool = false
    
    @IBOutlet weak var shareFBButton: UIButton!
    
    @IBOutlet weak var congratsLabel: UILabel!
    @IBOutlet weak var shareByMailButton: UIButton!
    
    @IBOutlet weak var yourResultLabel: UILabel!
    
    @IBOutlet weak var nextLevelButton: UIButton!
    
    @IBOutlet weak var comingSoon: UILabel!
    
    @IBOutlet weak var pleaseAnswerAllLabel: UILabel!
    
    @IBAction func share(_ sender: Any) {
        presenter.shareByFBButtonTapped()
    }
    
    @IBAction func shareByMail(_ sender: Any) {
       presenter.shareByMailButtonTapped()
    }
    
    func shareMail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func setLayout() {
        yourResultLabel.text = yourResultLabelText
        
        levelScoresLabel.text = "Всего \(model.scores.totalScoresForGame) очков"
        
        
        if !isThereNextLevel {
            nextLevelButton.removeFromSuperview()
        } else {
            comingSoon.removeFromSuperview()
        }
        
        nextLevelButton.alpha = wereAllQuestionsAnsweredCorrectly ? 1 : 0.3
        
        if isGameOver {
            pleaseAnswerAllLabel.removeFromSuperview()
        }
        
        if !wereAllQuestionsAnsweredCorrectly {
            shareFBButton.removeFromSuperview()
            congratsLabel.removeFromSuperview()
            shareByMailButton.removeFromSuperview()
        }


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yourNameForm.alpha = 1
        yourNameForm.removeFromSuperview()
        
        
        presenter = levelResultViewPresenter(withView: self, withModel: model)

        presenter.setLevelResult()
        
       
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        var shouldWe = true
        
        if identifier == "nextLevel" {
            shouldWe = wereAllQuestionsAnsweredCorrectly
        }
        return shouldWe
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "nextLevel" {
          presenter.nextLevelButtonTapped()

        }
        
        if segue.identifier == "restartLevel" {
            presenter.restartLevelButtonTapped()
            
        }
    }
    

    

    func askForReviews() {
        
        delay(3) {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
        }
        
    }
    
    func shareFB() {
        let url = URL(string: "https://www.facebook.com/sharer/sharer.php?u=https://pohmelje.ru/victorinaShare/")!
        
        UIApplication.shared.open( url, options: [:], completionHandler: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients([""])
        mailComposerVC.setSubject("Я умею пить? А вы?")
        mailComposerVC.setMessageBody("Я правильно ответил на все вопросы викторины! А вам слабо? Попробуйте: https://pohmelje.ru/victorinaShare/", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Ой", message: "Не получилось отправить письмо. Проверьте настройки почтовой программы.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    

}
