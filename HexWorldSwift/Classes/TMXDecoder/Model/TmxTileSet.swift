//
// Created by Stas Kirichok on 17.01.15.
// Copyright (c) 2015 Stas Kirichok. All rights reserved.
//

import Foundation

class TmxTileSet {
    var name: String
    var firstGid: UInt
    var imageSource: String

    init(name: String, firstGid: UInt, imageSource: String) {
        self.name = name
        self.firstGid = firstGid
        self.imageSource = imageSource
    }

    convenience init (xmlElement: AEXMLElement) {
        let name = xmlElement.attributes["name"] as String
        let firstGid = UInt((xmlElement.attributes["firstgid"] as String).toInt()!)
        let imageSource = xmlElement["image"].attributes["source"] as String

        self.init(name: name, firstGid: firstGid, imageSource: imageSource)
    }

}
