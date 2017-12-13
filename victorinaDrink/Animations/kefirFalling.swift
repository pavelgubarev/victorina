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
        
            
        
        let makeNewKefir = SKAction.run(
         {
            
            let newKefir = kefirSprite.copy() as! SKNode
            
            newKefir.physicsBody!.affectedByGravity = true
            newKefir.physicsBody!.pinned = false

            self.addChild(newKefir)
            
            
        })
        
        let dropKefir = SKAction.repeat(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            makeNewKefir
            ]), count: 60)
        
        let releaseKefir = SKAction.run( { self.childNode(withName: "bottom")!.removeFromParent() })
        
        let stopScene = SKAction.run({ self.removeAllChildren() })
        
        self.run(SKAction.sequence([dropKefir,
                                    SKAction.wait(forDuration: 2),
                                    releaseKefir,
                                    SKAction.wait(forDuration: 3),
                                    stopScene]))
    }
    

}
