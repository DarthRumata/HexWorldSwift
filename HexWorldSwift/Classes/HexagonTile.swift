//
// Created by Stas Kirichok on 17.01.15.
// Copyright (c) 2015 Stas Kirichok. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class HexagonTile: Tile {
    private var hexagonBorder: SKShapeNode!
    var hexagonEdgeLength: CGFloat

    class func hexagonHeight(edge: CGFloat) -> CGFloat {
        return sqrt(3) * edge / 2;
    }

    private var hexagonHeight: CGFloat {
        return HexagonTile.hexagonHeight(hexagonEdgeLength)
    }

    var firstPoint: CGPoint {
        return CGPointMake(0, hexagonEdgeLength);
    }

    var secondPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength / 2, hexagonEdgeLength + self.hexagonHeight);
    }

    var thirdPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength * 3 / 2, hexagonEdgeLength + self.hexagonHeight);
    }

    var fourthPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength * 2, hexagonEdgeLength);
    }

    var fifthPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength * 3 / 2, hexagonEdgeLength - self.hexagonHeight);
    }

    var sixthPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength / 2, hexagonEdgeLength - self.hexagonHeight);
    }


    init(hexagonEdgeLength: CGFloat) {
        self.hexagonEdgeLength = hexagonEdgeLength

        super.init(size: CGSizeMake(hexagonEdgeLength * 2, hexagonEdgeLength * 2))
    }

    required init(coder: NSCoder) {
        fatalError("Coder isn't allowed")
    }

    func render() {
        self.hexagonBorder = SKShapeNode();
        var path = UIBezierPath();
        path.moveToPoint(self.firstPoint);
        path.addLineToPoint(self.secondPoint);
        path.addLineToPoint(self.thirdPoint);
        path.addLineToPoint(self.fourthPoint);
        path.addLineToPoint(self.fifthPoint);
        path.addLineToPoint(self.sixthPoint);
        path.addLineToPoint(self.firstPoint);
        self.hexagonBorder.path = path.CGPath;
        self.hexagonBorder.strokeColor = UIColor.blackColor();
        self.hexagonBorder.lineWidth = 1;
        self.addChild(self.hexagonBorder);
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        println("touch: \(self.position)")
    }


}
