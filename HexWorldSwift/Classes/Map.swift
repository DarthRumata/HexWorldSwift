//
// Created by Stas Kirichok on 17.01.15.
// Copyright (c) 2015 Stas Kirichok. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class Map: SKNode {

    struct TileIndex: Hashable {
        var row: UInt
        var column: UInt

        var hashValue: Int {
            return row.hashValue ^ column.hashValue
        }


    }

    // MARK: stored properties

    var model: TmxMap
    var tiles: Dictionary<TileIndex, Tile>
    var borderNode: SKShapeNode!


    // MARK: computed properties

    var tileEdgeLength: CGFloat {
        return CGFloat(2 * self.model.hexagonEdgeLength);
    }

    var tileHeight: CGFloat {
        return HexagonTile.hexagonHeight(self.model.hexagonEdgeLength) * 2
    }

    var mapSize: CGSize {
        return CGSizeMake((self.model.hexagonEdgeLength * 1.5) * CGFloat(self.model.columns) + 0.5 * self.model.hexagonEdgeLength,
                CGFloat(self.model.rows) * tileHeight + tileHeight / 2)
    }

    // MARK: initializers

    init(model: TmxMap) {
        self.model = model
        self.tiles = Dictionary(minimumCapacity: Int(self.model.columns * model.rows));
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    // MARK: methods

    func render() {
        self.renderBorder()

        //render hex-net
        for row: UInt in 0 ..< self.model.rows {
            for column: UInt in 0 ..< self.model.columns {
                let xPosition: CGFloat = (self.model.hexagonEdgeLength * 1.5) * CGFloat(column) - self.mapSize.width / 2
                let staggerMultiplier: UInt = MathHelper.isEvenNumber(Int(column)) == (self.model.hexStagger == HexStagger.Even) ? 0 : 1
                let yPosition: CGFloat = mapSize.height / 2 - (tileHeight / 2) * CGFloat(staggerMultiplier) - tileHeight * CGFloat(row) - tileHeight

                var tile: HexagonTile = HexagonTile(hexagonEdgeLength: self.model.hexagonEdgeLength)
                tile.position = CGPointMake(xPosition, yPosition)
                self.tiles[TileIndex(row: row, column: column)] = tile
                tile.render()
                self.addChild(tile)
            }
        }
    }

    func renderBorder() {
        var fill: SKSpriteNode = SKSpriteNode(color: UIColor.greenColor(), size: self.mapSize)
        self.addChild(fill);

        self.borderNode = SKShapeNode();
        var path = UIBezierPath(rect: CGRectMake(-self.mapSize.width / 2, -self.mapSize.height / 2, self.mapSize.width, self.mapSize.height))
        self.borderNode.path = path.CGPath;
        self.borderNode.lineWidth = 1;
        self.borderNode.strokeColor = UIColor.grayColor();
        self.addChild(borderNode);

    }

}

func ==(lhs: Map.TileIndex, rhs: Map.TileIndex) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
