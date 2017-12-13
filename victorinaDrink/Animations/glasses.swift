//
//  glasses.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 13/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit
import SpriteKit

class glasses: SKScene {
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.clear

        for i in 1...4 {
            let spriteName = "glass\(i)"
            
            let glass = self.childNode(withName: spriteName)!
            glass.physicsBody!.mass = 0.01
            
            let throwGlass = SKAction.repeat( SKAction.sequence([
                
                SKAction.wait(forDuration: TimeInterval( 1 * randomPercent() )),
                
                SKAction.run {
                    glass.physicsBody!.applyImpulse(CGVector(dx: 0, dy : 15))
                },
                SKAction.wait(forDuration: 2.5)

                ])
            , count: 3)
            
            glass.run(SKAction.sequence([
                throwGlass,
                SKAction.run {
                    self.removeAllChildren()
                }
            
            ]))
        }
        
    }

}

func randomPercent() -> CGFloat {
    return CGFloat(Double(arc4random_uniform(100))/100)
}
