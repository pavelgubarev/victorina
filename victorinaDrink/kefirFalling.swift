//
//  kefirFalling.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 12/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import SpriteKit

class kefirFalling: SKScene {
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.clear
        
        let kefirSprite = self.childNode(withName: "kefir")!
        
        for _ in 0...50 {
            
            let newKefir = kefirSprite.copy() as! SKNode
            
            newKefir.physicsBody!.affectedByGravity = true
            
            self.addChild(newKefir)
            
            
        }
        
    }

}
