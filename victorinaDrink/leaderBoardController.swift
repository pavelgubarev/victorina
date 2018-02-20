//
//  leaderBoardController.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 19/02/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class LeaderBoardController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var leaderBoardTableData : NSArray?
    
    weak var owner : levelResultViewController?
    
    var sessionManager : SessionManager!

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return leaderBoardTableData == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderBoardCell", for: indexPath) as! LeaderBoardCell
        
        
        let data = leaderBoardTableData![indexPath.row] as! NSDictionary
        
        var userName = data["user_name"]! as? String
        
        if userName == "" {
            userName = "---"
        }
        
        cell.userNameLabel.text = userName
        
        cell.scoreLabel.text = data["scores_for_the_game"]! as? String
        
        
        return cell
        
    }
    
    func showLeaderBoard() {
        
        self.owner!.leaderBoard.reloadData()
        
        self.owner!.leaderBoard.alpha = 1
        
        self.owner!.leaderBoardHeader.alpha = 1
        
    }
    
    
    func loadData() {
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.urlCache = nil
        sessionManager =  Alamofire.SessionManager(configuration: configuration)

        
        sessionManager.request("https://pohmelje.ru/victorinaLeaderboard/", method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in
            
            if let result = response.result.value {
                
            print(result)
                
                self.leaderBoardTableData = result as? NSArray
                
                self.showLeaderBoard()
                
            }
            
            
        }
    }
    
    
}
