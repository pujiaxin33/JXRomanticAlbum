//
//  RAPlayZoomReverseViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/19.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import Lottie
import SwiftEntryKit
import Photos

class RAPlayRoomReverseViewController: RABaseViewController {
    var playSize = RAPlaySize.init(row: 3, column: 3)
    var dataSource = [[RAPlayRoomReverseCellModel]]()
    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    var currentAsset: PHAsset?
    let dateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "反转"

        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false

        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: SCREEN_WIDTH), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RAPlayRoomReverseCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)

        self.currentAsset = RAPhotoManager.getRandomAsset()
        PHImageManager.default().requestImage(for: self.currentAsset!, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: nil) { (image, info) in
            self.image = image?.cropCenterSquareImage()
            self.reloadData()
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateLabel.isHidden = true
        dateLabel.text = dateFormatter.string(from: self.currentAsset!.creationDate!)
        self.view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(10)
        }

        let dateButton = UIButton(type: .custom)
        dateButton.backgroundColor = RAControlTintColor
        dateButton.setTitleColor(.white, for: .normal)
        dateButton.setTitle("  查看日期  ", for: .normal)
        dateButton.layer.cornerRadius = 15
        dateButton.layer.masksToBounds = true
        dateButton.addTarget(self, action: #selector(dateButtonClicked(btn:)), for: .touchUpInside)
        self.view.addSubview(dateButton)
        dateButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(30)
        }


        let locationButton = UIButton(type: .custom)
        locationButton.backgroundColor = RAControlTintColor
        locationButton.setTitleColor(.white, for: .normal)
        locationButton.setTitle("  查看位置  ", for: .normal)
        locationButton.layer.cornerRadius = 15
        locationButton.layer.masksToBounds = true
        locationButton.addTarget(self, action: #selector(locationButtonClicked(btn:)), for: .touchUpInside)
        self.view.addSubview(locationButton)
        locationButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        locationButton.isHidden = self.currentAsset?.location == nil
    }

    func reloadData() {
        dataSource.removeAll()

        let rowSingleRatio = 1/CGFloat(playSize.row)
        let columnSingleRatio = 1/CGFloat(playSize.column)
        for y in 0..<playSize.row {
            var rowDataSource = [RAPlayRoomReverseCellModel]()
            for x in 0..<playSize.column {
                let cellModel = RAPlayRoomReverseCellModel()
                cellModel.image = image
                cellModel.playSize = playSize
                cellModel.coordinate = RAItemCoordinate.init(x: x, y: y)
                cellModel.imageCoordinate = cellModel.coordinate
                let rect = CGRect(x: CGFloat(cellModel.imageCoordinate!.x)*columnSingleRatio, y: CGFloat(cellModel.imageCoordinate!.y)*rowSingleRatio, width: columnSingleRatio, height: rowSingleRatio)
                cellModel.contentsRect = rect
                rowDataSource.append(cellModel)
            }
            dataSource.append(rowDataSource)
        }

        self.collectionView.reloadData()
    }

    func showCompleted() {
        let view = RACompletedView()
        view.againCallback = {[weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
            SwiftEntryKit.dismiss()
        }
        var attri = EKAttributes.init()
        attri.displayDuration = .infinity
        attri.position = .center
        attri.positionConstraints.size = .init(width: .constant(value: 250), height: .constant(value: 200))
        attri.entryInteraction = .absorbTouches
        attri.screenInteraction = .absorbTouches
        attri.screenBackground = .visualEffect(style: .dark)
        attri.entranceAnimation = .init(translate: EKAttributes.Animation.Translate(duration: 0), scale: EKAttributes.Animation.RangeAnimation(from: 0.1, to: 1, duration: 0.25), fade: EKAttributes.Animation.RangeAnimation(from: 0.5, to: 1, duration: 0.25))
        SwiftEntryKit.display(entry: view, using: attri)
    }

    @objc func locationButtonClicked(btn: UIButton) {
        let vc = RALocationViewController()
        vc.location = self.currentAsset?.location
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func dateButtonClicked(btn: UIButton) {
        dateLabel.isHidden = false
        btn.isHidden = true
    }

    func showDatePickerView() {
        let view: RADatePickerView = Bundle.main.loadNibNamed("RADatePickerView", owner: nil, options: nil)?.first as! RADatePickerView
        view.confirmCallback = {(date) in

        }
        var attri = EKAttributes.init()
        attri.displayDuration = .infinity
        attri.position = .bottom
        attri.positionConstraints.size = .init(width: .constant(value: SCREEN_WIDTH), height: .constant(value: 244))
        attri.positionConstraints.verticalOffset = -10
        attri.entryInteraction = .absorbTouches
        attri.screenInteraction = .absorbTouches
        attri.screenBackground = .color(color: ColorWithHex(0x000000, 0.5))
        attri.entranceAnimation = .init(translate: EKAttributes.Animation.Translate(duration: 0.25), scale: EKAttributes.Animation.RangeAnimation(from: 1, to: 1, duration: 0.25), fade: EKAttributes.Animation.RangeAnimation(from: 1, to: 1, duration: 0.25))
        SwiftEntryKit.display(entry: view, using: attri)
    }
}

extension RAPlayRoomReverseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH/CGFloat(playSize.column), height: SCREEN_WIDTH/CGFloat(playSize.row))
    }

}

extension RAPlayRoomReverseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        let myCell = cell as! RAPlayRoomReverseCell
        myCell.reloadUI(cellModel: cellModel)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModel = dataSource[indexPath.section][indexPath.item]
        cellModel.isShow = true
        let cell = collectionView.cellForItem(at: indexPath) as! RAPlayRoomReverseCell
        cell.showImage()
    }
}
