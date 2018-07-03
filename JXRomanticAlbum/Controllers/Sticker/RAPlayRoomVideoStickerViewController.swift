//
//  RAPlayRoomVideoStickerViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import CoreImage
import GPUImage
import AVFoundation
import CoreMedia

class RAPlayRoomVideoStickerViewController: RABaseViewController {
    var videoCamera: GPUImageVideoCamera?
    var element: GPUImageUIElement?
    var filterView: GPUImageView?
    var elementView: UIView?
    var stickerImageView: UIImageView?
    var faceBounds = CGRect.zero
    var faceDetector: CIDetector?
    var isFaceThinking = false

    deinit {
        videoCamera?.stopCapture()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "大头贴"

        self.view.backgroundColor = UIColor.white

        let detectorOptions = [CIDetectorAccuracy: CIDetectorAccuracyLow]
        faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: detectorOptions)

        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSession.Preset.iFrame1280x720.rawValue, cameraPosition: AVCaptureDevice.Position.front)
        videoCamera?.delegate = self
        videoCamera?.outputImageOrientation = .portrait
        videoCamera?.horizontallyMirrorFrontFacingCamera = true

        let filter = GPUImageFilter()
        videoCamera?.addTarget(filter)

        elementView = UIView(frame: self.view.frame)
        elementView?.backgroundColor = UIColor.clear

        stickerImageView = UIImageView(image: UIImage(named: "Sticker"))
        stickerImageView?.frame = CGRect(x: 0, y: 0, width: 200, height: 120)
        elementView?.addSubview(stickerImageView!)

        element = GPUImageUIElement(view: elementView!)

        let blendFilter = GPUImageAlphaBlendFilter()
        blendFilter.mix = 1
        filter.addTarget(blendFilter)
        element?.addTarget(blendFilter)

        filterView = GPUImageView(frame: self.view.frame)
        filterView?.center = self.view.center
        view.addSubview(filterView!)
        blendFilter.addTarget(filterView!)

        filter.frameProcessingCompletionBlock = {[weak self] (output: GPUImageOutput?, time: CMTime) -> Void in
            self?.updateSticker()
            }

        videoCamera?.startCapture()
    }

    func updateSticker() {
        let rect = self.faceBounds
        let size = self.stickerImageView!.bounds.size
        self.stickerImageView?.frame = CGRect(x: rect.origin.x + (rect.size.width - size.width)/2, y: rect.origin.y - size.height, width: size.width, height: size.height)
        self.element?.update()
    }

    @objc func grepFacesForSampleBuffer(sampleBuffer: CMSampleBuffer) {
        isFaceThinking = true
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate)
        let convertedImage = CIImage(cvPixelBuffer: pixelBuffer!, options: attachments as? [String : Any])

//        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: Int = 6

        let features = self.faceDetector?.features(in: convertedImage, options: [CIDetectorImageOrientation:exifOrientation])

        let fdesc = CMSampleBufferGetFormatDescription(sampleBuffer)
        let clap = CMVideoFormatDescriptionGetCleanAperture(fdesc!, false)
        GPUVCWillOutputFeatures(featureArray: features as! [CIFaceFeature], forClap: clap)
        isFaceThinking = false
    }

    func GPUVCWillOutputFeatures(featureArray: [CIFaceFeature], forClap clap: CGRect) {
        DispatchQueue.main.async {
            let previewBox = self.view.frame
            if featureArray.isEmpty == false {
                self.stickerImageView?.isHidden = false
            }else {
                self.stickerImageView?.isHidden = true
            }
            for faceFeature in featureArray {
                var faceRect = faceFeature.bounds
                var temp = faceRect.size.width
                faceRect.size.width = faceRect.size.height
                faceRect.size.height = temp
                temp = faceRect.origin.x
                faceRect.origin.x = faceRect.origin.y
                faceRect.origin.y = temp

                let widthScaleBy = previewBox.size.width/clap.size.height
                let heightScaleBy = previewBox.size.height/clap.size.width
                faceRect.size.width *= widthScaleBy
                faceRect.size.height *= heightScaleBy
                faceRect.origin.x *= widthScaleBy
                faceRect.origin.y *= heightScaleBy

                faceRect = faceRect.offsetBy(dx: previewBox.origin.x, dy: previewBox.origin.y)
                let rect = CGRect(x: previewBox.size.width - faceRect.origin.x - faceRect.size.width, y: faceRect.origin.y, width: faceRect.size.width, height: faceRect.size.height)
                if fabs(rect.origin.x - self.faceBounds.origin.x) > 5 {
                    self.faceBounds = rect
                }
            }
        }
    }
}


extension RAPlayRoomVideoStickerViewController: GPUImageVideoCameraDelegate {
    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
        if !isFaceThinking {
            let allocator = kCFAllocatorDefault

            var sbufCopyOut: CMSampleBuffer?

            CMSampleBufferCreateCopy(allocator, sampleBuffer, &sbufCopyOut)
            self.performSelector(inBackground: #selector(grepFacesForSampleBuffer(sampleBuffer:)), with: sbufCopyOut)
        }
    }
}
