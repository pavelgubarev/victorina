//
//  startPageViewProtocol.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 08/01/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

protocol startPageViewProtocol : class {
    
    var hasUserAccessToLevel2 : Bool {get set}
    
    func gotoAyPohmelje()
    
}
