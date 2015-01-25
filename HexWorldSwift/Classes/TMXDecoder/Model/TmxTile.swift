//
// Created by Stas Kirichok on 17.01.15.
// Copyright (c) 2015 Stas Kirichok. All rights reserved.
//

import Foundation

class TmxTile: Printable {
    var gid: UInt = 0

    var description: String {
        return "TmxTile gid: \(gid)"
    }

    init(gid: UInt) {
        self.gid = gid
    }

    convenience init(xmlElement: AEXMLElement) {
        self.init(gid:UInt((xmlElement.attributes["gid"] as String).toInt()!))
    }
}
