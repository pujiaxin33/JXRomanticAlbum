//
//  RAPlayrRoomFilterViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import GPUImage
import Photos
import SnapKit

class RAPlayRoomFilterViewController: RABaseViewController {
    var imageView: UIImageView!
    var currentAsset: PHAsset?
    var fractionalWidthOfAPixel: CGFloat = 0.04
    var blurRadiusInPixels: CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "马赛克"

        self.view.backgroundColor = UIColor.white

        self.currentAsset = RAPhotoManager.getRandomAsset()
        PHImageManager.default().requestImage(for: self.currentAsset!, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.default, options: nil) { (image, info) in
            self.image = image?.cropCenterSquareImage()
            self.processFilter()
        }

        imageView = UIImageView(frame: CGRect(x: 20, y: 20, width: SCREEN_WIDTH - 40, height: SCREEN_Height - 200))
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)

        let btn = UIButton(type: .custom)
        btn.backgroundColor = RAControlTintColor
        btn.setTitle("再清晰一点", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(reduceFractionalWidthOfAPixel), for: .touchUpInside)
        btn.layer.cornerRadius = 25
        btn.layer.masksToBounds = true
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(44)
            make.trailing.equalTo(self.view.snp.trailing).offset(-44)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    @objc func reduceFractionalWidthOfAPixel() {
        self.fractionalWidthOfAPixel -= 0.005
        self.fractionalWidthOfAPixel = max(self.fractionalWidthOfAPixel, 0)

//        self.blurRadiusInPixels -= 5
//        self.blurRadiusInPixels = max(self.blurRadiusInPixels, 0)

        self.processFilter()
    }

    func processFilter() {
        guard self.image != nil else {
            return
        }

        let imagePicture = GPUImagePicture(image: self.image!)

//        let filter = GPUImageiOSBlurFilter()
//        filter.blurRadiusInPixels = self.blurRadiusInPixels

//        let filter = GPUImagePolkaDotFilter()
//        filter.fractionalWidthOfAPixel = self.fractionalWidthOfAPixel

        let filter = GPUImagePixellateFilter()
        filter.fractionalWidthOfAPixel = self.fractionalWidthOfAPixel

        imagePicture?.addTarget(filter)

        filter.useNextFrameForImageCapture()
        imagePicture?.processImage()

        let newImage = filter.imageFromCurrentFramebuffer()
        imageView.image = newImage
    }

}
