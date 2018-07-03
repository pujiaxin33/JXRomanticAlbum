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

//MARK: 颜色相关
func ColorWithRGBA(_ red: CGFloat,_  green: CGFloat,_ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}
func ColorWithHex(_ hex: Int, _ alpha: CGFloat) -> UIColor {
    return ColorWithRGBA((CGFloat((hex & 0xFF0000) >> 16)), (CGFloat((hex & 0xFF00) >> 8)), (CGFloat(hex & 0xFF)), alpha)
}

let RAControlTintColor = ColorWithHex(0xFFC0CB, 1)

enum RAPlayPrimaryMode {
    case puzzle
    case guess
    case photoWall
    case sticker
    case bigFace
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





