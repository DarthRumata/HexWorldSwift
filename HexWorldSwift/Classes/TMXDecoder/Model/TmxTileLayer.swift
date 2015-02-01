//
// Created by Stas Kirichok on 17.01.15.
// Copyright (c) 2015 Stas Kirichok. All rights reserved.
//

import Foundation

class TmxTileLayer: TmxLayer, Printable {
    var rows: UInt
    var columns: UInt
    var tiles: Dictionary<Map.TileIndex, TmxTile>

    var description: String {
        return "TmxTileLayer rows: \(rows), columns: \(columns), tiles: \(tiles)"
    }

    init(name: String, rows: UInt, columns: UInt, alpha: Float, tiles: Dictionary<Map.TileIndex, TmxTile>) {
        self.rows = rows
        self.columns = columns
        self.tiles = tiles
        super.init(name: name, alpha: alpha)
    }

    convenience init(xmlElement: AEXMLElement) {
        let layerAttr = xmlElement.attributes
        let name = layerAttr["name"] as String
        let rows = UInt((layerAttr["height"] as String).toInt()!)
        let columns = UInt((layerAttr["width"] as String).toInt()!)
        var alpha: Float = 1
        if let parsedAlpha: Float = (layerAttr["alpha"] as? NSString)?.floatValue {
            alpha = parsedAlpha
        }
        
        let data = xmlElement["data"]
        var tiles: Dictionary<Map.TileIndex, TmxTile> = [:]
        for var index: Int = 0; index < data.children.count; ++index {
            var element = data.children[index]
            var rowFloat: Float = Float(UInt(index) / columns)
            var row: UInt = UInt(floor(rowFloat))
            var column: UInt = UInt(index) - row * rows
            tiles[Map.TileIndex(row: row, column: column)] = TmxTile(xmlElement: element)
        }

        self.init(name: name, rows: rows, columns: columns, alpha: alpha, tiles: tiles)
    }
}
