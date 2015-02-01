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
        return CGPointMake(0, hexagonHeight);
    }

    var secondPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength / 2, hexagonHeight * 2);
    }

    var thirdPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength * 1.5, hexagonHeight * 2);
    }

    var fourthPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength * 2, hexagonHeight);
    }

    var fifthPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength * 1.5, 0);
    }

    var sixthPoint: CGPoint {
        return CGPointMake(hexagonEdgeLength / 2, 0);
    }

    //MARK: Initializers

    init(hexagonEdgeLength: CGFloat) {
        self.hexagonEdgeLength = hexagonEdgeLength
        var height: CGFloat = HexagonTile.hexagonHeight(hexagonEdgeLength)
        super.init(size: CGSizeMake(hexagonEdgeLength * 2, height * 2))
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
