//
//  RADefines.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/14.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
let SCREEN_Height: CGFloat = UIScreen.main.bounds.height

enum RAPlayPrimaryMode {
    case puzzle
    case reverse
}

enum RAPlayPuzzleMode {
    case free
    case exchange
    case move
}

struct RAPlaySize {
    var row: Int
    var column: Int
}

struct RAItemCoordinate {
    var x: Int
    var y: Int
}




