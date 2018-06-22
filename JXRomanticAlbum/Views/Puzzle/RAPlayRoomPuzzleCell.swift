//
//  RAPlayZoomPuzzleCell.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/14.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlayRoomPuzzleCell: UICollectionViewCell {
    var imageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        imageView.layer.contentsGravity = kCAGravityResizeAspect
        addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reloadUI(cellModel: RAPlayRoomPuzzleCellModel) {
        imageView.image = cellModel.image
        imageView.layer.contentsRect = cellModel.contentsRect!
        imageView.isHidden = cellModel.isEmpty

        if cellModel.isEmpty {
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.borderWidth = 1/UIScreen.main.scale
        }else {
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 1/UIScreen.main.scale
        }
    }


}
