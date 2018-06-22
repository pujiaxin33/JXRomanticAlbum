//
//  RAPlayZoomReverseCellModel.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/19.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import Foundation
import UIKit

class RAPlayRoomReverseCellModel {
    var playSize: RAPlaySize?
    //cell的坐标，存储cell真实的坐标信息
    var coordinate: RAItemCoordinate?
    var image: UIImage?
    //图片的坐标，用于判断是否拼图完整
    var imageCoordinate: RAItemCoordinate?
    var contentsRect: CGRect?

    var isShow = false

}
