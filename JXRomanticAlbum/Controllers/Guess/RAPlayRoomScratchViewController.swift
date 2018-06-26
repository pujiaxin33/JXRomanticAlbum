//
//  RAPlayRoomScratchViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/26.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import Photos

class RAPlayRoomScratchViewController: RABaseViewController {
    var currentAsset: PHAsset?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "刮刮乐"

        self.view.backgroundColor = UIColor.white

        self.currentAsset = RAPhotoManager.getRandomAsset()
        PHImageManager.default().requestImage(for: self.currentAsset!, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: nil) { (image, info) in
            self.image = image
            self.showScrathView()
        }
    }

    func showScrathView() {

        let margin: CGFloat = 20
        let width = SCREEN_WIDTH - margin*2
        let height = SCREEN_Height - 64 - margin*3
        let frame = CGRect(x: margin, y: margin, width: width, height: height)

        let imageView = UIImageView(image: self.image)
        imageView.frame = frame
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)

        let maskView = ScratchMask(frame: frame)
        maskView.lineType = CGLineCap.round
        maskView.lineWidth = 30
        maskView.image = UIImage.imageWithColor(color: UIColor.lightGray)
        self.view.addSubview(maskView)
    }

}
