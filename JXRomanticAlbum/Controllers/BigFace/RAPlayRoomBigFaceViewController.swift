//
//  RAPlayRoomBigFaceViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import SnapKit
import GPUImage

class RAPlayRoomBigFaceViewController: RABaseViewController {
    var faceImageView: UIImageView!
    var value:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        let boyControl = UIView()
        boyControl.backgroundColor = ColorWithHex(0x2196F3, 1)
        self.view.addSubview(boyControl)
        boyControl.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view.snp.height).multipliedBy(0.5)
        }


        faceImageView = UIImageView()
        self.view.addSubview(faceImageView)
        faceImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(faceImageView.snp.width)
        }

        RAPhotoManager.shared.dispalyPictureChooseSheet(sourceVC: self)
    }



    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.value += 0.1
        self.processFilter()
    }

    func processFilter() {
        guard self.image != nil else {
            return
        }

        let imagePicture = GPUImagePicture(image: self.image!, smoothlyScaleOutput: true)

        let imageView  = GPUImageView(frame: faceImageView.bounds)
        faceImageView.addSubview(imageView)

        let group = GPUImageFilterGroup()
        imagePicture?.addTarget(group)

        let filter = GPUImageBulgeDistortionFilter()
        filter.center = CGPoint(x: 0.5, y: 0.2)
        filter.radius = 0.25
        filter.scale = self.value
        group.addFilter(filter)

        let otherfilter = GPUImageBulgeDistortionFilter()
        otherfilter.center = CGPoint(x: 0.5, y: 0.7)
        otherfilter.radius = 0.25
        otherfilter.scale = self.value
        group.addFilter(otherfilter)
        filter.addTarget(otherfilter)

        group.initialFilters = [filter]
        group.terminalFilter = otherfilter

        imagePicture?.processImage()
        group.useNextFrameForImageCapture()

        let newImage = group.imageFromCurrentFramebuffer()
        faceImageView.image = newImage
    }

}

extension RAPlayRoomBigFaceViewController: RAPhotoManagerDelegate {
    func photoManagerDidChooseImage(image: UIImage) {
        self.image = image
        faceImageView.image = image
    }
}
