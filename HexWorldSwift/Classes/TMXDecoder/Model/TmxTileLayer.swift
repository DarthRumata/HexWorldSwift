//
// Created by Stas Kirichok on 17.01.15.
// Copyright (c) 2015 Stas Kirichok. All rights reserved.
//

import Foundation

class TmxTileLayer: TmxLayer, Printable {
    var rows: UInt
    var columns: UInt
    var tiles: Array<TmxTile>

    var description: String {
        return "TmxTileLayer rows: \(rows), columns: \(columns), tiles: \(tiles)"
    }

    init(name: String, rows: UInt, columns: UInt, tiles: Array<TmxTile>) {
        self.rows = rows
        self.columns = columns
        self.tiles = tiles
        super.init(name: name)
    }

    convenience init(xmlElement: AEXMLElement) {
        let layerAttr = xmlElement.attributes
        let name = layerAttr["name"] as String
        let rows = UInt((layerAttr["height"] as String).toInt()!)
        let columns = UInt((layerAttr["width"] as String).toInt()!)

        let data = xmlElement["data"]
        var tiles: Array<TmxTile> = []
        for tile: AEXMLElement in data.children {
            tiles.append(TmxTile(xmlElement: tile))
        }

        self.init(name: name, rows: rows, columns: columns, tiles: tiles)
    }
}
