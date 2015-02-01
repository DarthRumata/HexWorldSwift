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
        self.fillNode = SKSpriteNode(color: UIColor(white: 1, alpha: 0), size: size)
        self.addChild(self.fillNode)
        self.fillNode.zPosition = -1;
        self.fillNode.name = "transparent";
        self.fillNode.position = CGPointMake(size.width / 2, size.height / 2);
    }

    required init(coder: NSCoder) {
        fatalError("Coder isn't allowed")
    }
}
