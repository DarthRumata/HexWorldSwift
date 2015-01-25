//
// Created by Stas Kirichok on 17.01.15.
// Copyright (c) 2015 Stas Kirichok. All rights reserved.
//

import Foundation
import UIKit

enum MapOrientation {
    case Hexagonal, Ortogonal, Isometric, StaggeredIsometric

    static func parseTMX(attr: String) -> MapOrientation? {
        switch attr {
        case "hexagonal":
            return MapOrientation.Hexagonal
        case "isometric":
            return MapOrientation.Isometric
        default:
            return nil
        }
    }
}

enum HexType {
    case EastWest, NorthSouth

    static func parseTMX(attr: String) -> HexType? {
        switch attr {
        case "x":
            return HexType.EastWest
        case "y":
            return HexType.NorthSouth
        default:
            return nil
        }
    }
}

enum HexStagger {
    case Even, Odd

    static func parseTMX(attr: String) -> HexStagger? {
        switch attr {
        case "even":
            return HexStagger.Even
        case "odd":
            return HexStagger.Odd
        default:
            return nil
        }
    }
}

class TmxMap: Printable {
    var version: String
    var orientation: MapOrientation
    var rows: UInt
    var columns: UInt
    var hexType: HexType?
    var hexStagger: HexStagger?
    var hexagonEdgeLength: CGFloat = 0.0

    var tileLayers: Array<TmxTileLayer> = []
    var objectLayers: Array<TmxObjectLayer> = []
    var tileSets: Array<TmxTileSet> = []

    var description: String {
        return "version: \(version), orientation: \(orientation), rows: \(rows), columns: \(columns), hexType: \(hexType), hexStagger: \(hexStagger), " +
                "hexagonEdgeLength \(hexagonEdgeLength), tileLayers: \(tileLayers)"
    }

    init() {
        self.version = ""
        self.orientation = MapOrientation.Hexagonal
        self.rows = 0
        self.columns = 0
    }

    convenience init?(tmxFileName: String) {
        self.init()
        if let xmlData = readFile(tmxFileName) {
            if !parse(xmlData) {
                return nil
            }
        } else {
            println("error while reading file")
            return nil
        }
    }

    private func readFile(filename: String) -> NSData? {
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "tmx") {

            return NSData(contentsOfFile: path)
        }

        return nil
    }

    /**
    *  Parse xml data to map properties
    *  :returns: true - succeded , false - error
    */
    private func parse(xmlData: NSData) -> Bool {
// works only if data is successfully parsed
// otherwise prints information about error with parsing
        var error: NSError?
        if let xmlDoc = AEXMLDocument(xmlData: xmlData, error: &error) {
            // prints the same XML structure as original
            println(xmlDoc.rootElement.name)

            //fill map attributes
            let mapAttr = xmlDoc.rootElement.attributes
            self.version = mapAttr["version"] as String
            self.columns = UInt((mapAttr["width"] as String).toInt()!)
            self.rows = UInt((mapAttr["height"] as String).toInt()!)
            self.hexagonEdgeLength = CGFloat((mapAttr["hexsidelength"] as String)._bridgeToObjectiveC().floatValue)
            self.hexStagger = HexStagger.parseTMX(mapAttr["staggerindex"] as String)
            self.hexType = HexType.parseTMX(mapAttr["staggeraxis"] as String)
            self.orientation = MapOrientation.parseTMX(mapAttr["orientation"] as String)!

            //process children tags
            for child: AEXMLElement in xmlDoc.rootElement.children {
                switch child.name {
                case "layer":
                    let tileLayer = TmxTileLayer(xmlElement: child)
                    self.tileLayers.append(tileLayer)
                case "objectgroup":
                    break
                case "tileset":
                    let tileSet = TmxTileSet(xmlElement: child)
                    self.tileSets.append(tileSet)
                default:
                    break
                }

            }

            return true

        } else {
            println("description: \(error?.localizedDescription)\ninfo: \(error?.userInfo)")
            return false
        }
    }

}
