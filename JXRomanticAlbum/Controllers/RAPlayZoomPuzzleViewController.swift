//
//  RAPlayZoomPuzzleViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/14.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlayZoomPuzzleViewController: UIViewController {
    var image: UIImage?
    var dataSource = [[RAPlayZoomPuzzleCellModel]]()
    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    var puzzleMode = RAPlayPuzzleMode.move
    var playSize = RAPlaySize.init(row: 3, column: 3)
    var currentEmptyCoordiate = RAItemCoordinate.init(x: 0, y: 0)
    var isMoving = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false

        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: SCREEN_WIDTH), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RAPlayZoomPuzzleCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)

        self.reloadData()
    }

    func reloadData() {
        dataSource = RARandomFactory.getRandomPuzzleArray(playSize: playSize, image: image!)
        //默认空白图在右下角
        currentEmptyCoordiate = RAItemCoordinate.init(x: playSize.column - 1, y: playSize.row - 1)

        self.collectionView.reloadData()
    }
}

extension RAPlayZoomPuzzleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH/CGFloat(playSize.column), height: SCREEN_WIDTH/CGFloat(playSize.row))
    }

}

extension RAPlayZoomPuzzleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cellModel = dataSource[indexPath.section][indexPath.item]
        let myCell = cell as! RAPlayZoomPuzzleCell
        myCell.reloadUI(cellModel: cellModel)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isMoving == false else {
            //正在移动不响应
            return
        }
        let cellModel = dataSource[indexPath.section][indexPath.item]
        guard cellModel.isEmpty == false else {
            //点击了空白item
            return
        }
        //- 检测点击的坐标，是否与空坐标的上下左右相接
        if RARuleManager.checkCoordinateHVConnectted(firstCoordinate: cellModel.coordinate!, secondCoordinate: currentEmptyCoordiate) {
            //相连，进行交换
            //更新坐标
            let emptyCellModel = dataSource[currentEmptyCoordiate.y][currentEmptyCoordiate.x]
            emptyCellModel.coordinate = RAItemCoordinate.init(x: indexPath.item, y: indexPath.section)
            cellModel.coordinate = self.currentEmptyCoordiate
            //交换数据源
            dataSource[currentEmptyCoordiate.y][currentEmptyCoordiate.x] = cellModel
            dataSource[indexPath.section][indexPath.item] = emptyCellModel

            isMoving = true
            collectionView.performBatchUpdates({
                collectionView.moveItem(at: indexPath, to: IndexPath(item: currentEmptyCoordiate.x, section: currentEmptyCoordiate.y))
                collectionView.moveItem(at: IndexPath(item: currentEmptyCoordiate.x, section: currentEmptyCoordiate.y), to: indexPath)
            }) { (finished) in
                self.currentEmptyCoordiate = RAItemCoordinate.init(x: indexPath.item, y: indexPath.section)
                self.isMoving = false
                if RARuleManager.checkPuzzleCompleted(dataSource: self.dataSource) {
                    print("完整的")
                }else {

                }
            }

        }
    }
}




