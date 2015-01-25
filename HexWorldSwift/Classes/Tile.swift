//
// Created by Stas Kirichok on 17.01.15.
// Copyright (c) 2015 Stas Kirichok. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class Tile: SKNode {
    var fillNode: SKSpriteNode!

    init(size: CGSize) {
        super.init()
        var random = Int(arc4random_uniform(100))
        self.fillNode = SKSpriteNode(color: UIColor(white: CGFloat(random) / 99.0, alpha: 1.0), size: size)
        self.addChild(self.fillNode)
        self.fillNode.zPosition = -1;
        self.fillNode.name = "transparent";
        self.fillNode.position = CGPointMake(size.width / 2, size.height / 2);
    }

    required init(coder: NSCoder) {
        fatalError("Coder isn't allowed")
    }
}
