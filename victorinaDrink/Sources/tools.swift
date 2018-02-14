//
//  tools.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 14/02/2018.
//  Copyright © 2018 Pavel Gubarev. All rights reserved.
//

import Foundation

func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            
                closure()
    })
}
