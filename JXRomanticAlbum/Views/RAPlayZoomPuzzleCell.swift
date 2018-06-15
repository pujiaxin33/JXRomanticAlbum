//
//  RAPlayZoomPuzzleCell.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/14.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit

class RAPlayZoomPuzzleCell: UICollectionViewCell {
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

    func reloadUI(cellModel: RAPlayZoomPuzzleCellModel) {
        imageView.image = cellModel.image
        imageView.layer.contentsRect = cellModel.contentsRect!
        imageView.isHidden = cellModel.isEmpty
    }


}
