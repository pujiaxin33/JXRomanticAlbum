//
//  UIImage+Utils.swift
//  DQGuess
//
//  Created by Imp on 2018/4/3.
//  Copyright © 2018年 jingbo. All rights reserved.
//

import UIKit
import CoreGraphics

extension UIImage {
    class func imageWithColor(color: UIColor) ->UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: 10, height: 10), false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        color.set()
        context!.fill(CGRect.init(x: 0, y: 0, width: 10, height: 10))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image!
    }
}
