//
//  RARuleManager.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import Foundation

class RARuleManager {
    //校验两个坐标在水平或垂直方向直接相连
    static func checkCoordinateHVConnectted(firstCoordinate: RAItemCoordinate, secondCoordinate: RAItemCoordinate) -> Bool {
        if firstCoordinate.x == secondCoordinate.x {
            //x相同，表示在一个垂直方向
            if abs(firstCoordinate.y - secondCoordinate.y) == 1 {
                //垂直相连
                return true
            }
        }else if firstCoordinate.y == secondCoordinate.y {
            //y相同，表示在一个水平方向
            if abs(firstCoordinate.x - secondCoordinate.x) == 1 {
                //水平相连
                return true
            }
        }

        return false
    }

    static func checkPuzzleCompleted(dataSource: [[RAPlayRoomPuzzleCellModel]]) -> Bool {
        guard dataSource.last?.last?.isEmpty == true else {
            //右下角必须是空白
            return false
        }
        for (row, rowItems) in dataSource.enumerated() {
            for (column, columnItem) in rowItems.enumerated() {
                if columnItem.imageCoordinate?.y != row {
                    //某一个元素不在当前行
                    return false
                }
                //---当前元素是否与后边的元素相连---//
                var nextItem: RAPlayRoomPuzzleCellModel?
                if column != rowItems.count - 1 {
                    //不是当前行的最后一个元素
                    nextItem = rowItems[column + 1]
                }
                if nextItem != nil {
                    //后面有一个item
                    if columnItem.imageCoordinate!.x + 1 != nextItem!.imageCoordinate!.x {
                        //彼此不相连
                        return false
                    }
                }
                //---当前元素是否与后边的元素相连---//

                //---当前元素是否与下面的元素相连---//
                var underItem: RAPlayRoomPuzzleCellModel?
                if row != dataSource.count - 1 {
                    //不是最后一行
                    underItem = dataSource[row + 1][column]
                }
                if underItem != nil {
                    //后面有一个item
                    if columnItem.imageCoordinate!.y + 1 != underItem!.imageCoordinate!.y {
                        //彼此不相连
                        return false
                    }
                }
                //---当前元素是否与下面的元素相连---//
            }
        }

        return true
    }
}








