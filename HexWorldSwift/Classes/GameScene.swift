//
//  GameScene.swift
//  HexWorldSwift
//
//  Created by Stas Kirichok on 17.01.15.
//  Copyright (c) 2015 Stas Kirichok. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        var model = TmxMap(tmxFileName: "map")
        println(model!)

        if model != nil {
            var map: Map = Map(model: model!)
            map.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
            map.render()
            self.addChild(map)
            println(self.frame)
            println(map.frame)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
