//
//  RARandomFactory.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import Foundation
import UIKit

class RARandomFactory {
    static func getRandomPuzzleArray(playSize: RAPlaySize, image: UIImage) -> [[RAPlayZoomPuzzleCellModel]] {
        var resultArray = [[RAPlayZoomPuzzleCellModel]]()

        var imageCoordinateArray = [RAItemCoordinate]()
        for x in 0..<playSize.column {
            for y in 0..<playSize.row {
                if !(x == playSize.column - 1 && y == playSize.row - 1) {
                    //最后一个位置留着
                    imageCoordinateArray.append(RAItemCoordinate.init(x: x, y: y))
                }
            }
        }

        let rowSingleRatio = 1/CGFloat(playSize.row)
        let columnSingleRatio = 1/CGFloat(playSize.column)
        
        for y in 0..<playSize.row {
            var rowDataSource = [RAPlayZoomPuzzleCellModel]()
            for x in 0..<playSize.column {
                let cellModel = RAPlayZoomPuzzleCellModel()
                cellModel.image = image
                cellModel.playSize = playSize
                cellModel.coordinate = RAItemCoordinate.init(x: x, y: y)
                if x == playSize.column - 1 && y == playSize.row - 1 {
                    //最后一个位置留给空白
                    cellModel.contentsRect = CGRect(x: CGFloat(x)*columnSingleRatio, y: CGFloat(y)*rowSingleRatio, width: columnSingleRatio, height: rowSingleRatio)
                    cellModel.imageCoordinate = RAItemCoordinate.init(x: x, y: y)
                    cellModel.isEmpty = true
                }else {
                    //坐标随机
                    let index = Int(arc4random()%UInt32(imageCoordinateArray.count))
                    let imageCoordinate = imageCoordinateArray[index]
                    cellModel.imageCoordinate = imageCoordinate
                    imageCoordinateArray.remove(at: index)

                    let rect = CGRect(x: CGFloat(imageCoordinate.x)*columnSingleRatio, y: CGFloat(imageCoordinate.y)*rowSingleRatio, width: columnSingleRatio, height: rowSingleRatio)
                    cellModel.contentsRect = rect
                }
                rowDataSource.append(cellModel)
            }
            resultArray.append(rowDataSource)
        }
        return resultArray
    }
}
