//
//  RAPlayRoomReverseCell.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/19.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlayRoomReverseCell: UICollectionViewCell {

    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        contentView.addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reloadUI(cellModel: RAPlayRoomReverseCellModel) {
        imageView.image = cellModel.image
        imageView.layer.contentsRect = cellModel.contentsRect!
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1/UIScreen.main.scale

        imageView.isHidden = !cellModel.isShow
    }

    func showImage() {
        imageView.isHidden = false

        let subtypes = [kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom]
        let index = Int(arc4random())%subtypes.count
        let transition = CATransition()
        transition.type = "cube"
        transition.subtype = subtypes[index]
        self.contentView.layer.add(transition, forKey: "cube")
    }

}
