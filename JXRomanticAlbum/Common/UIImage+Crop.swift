//
//  UIImage+Crop.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/19.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func cropCenterSquareImage() -> UIImage {
        var centerRect: CGRect?
        if self.size.width > self.size.height {
            let imageWH = self.size.height
            let leftMargin = (self.size.width - imageWH)/2
            centerRect = CGRect(x: leftMargin, y: 0, width: imageWH, height: imageWH)
        }else if self.size.width < self.size.height {
            let imageWH = self.size.width
            let topMargin = (self.size.height - imageWH)/2
            centerRect = CGRect(x: 0, y: topMargin, width: imageWH, height: imageWH)
        }else {
            centerRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        }

        let imageRef = self.cgImage?.cropping(to: centerRect!)
        let temp = UIImage(cgImage: imageRef!)
        return temp
    }
}
