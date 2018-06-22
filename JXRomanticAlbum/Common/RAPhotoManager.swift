//
//  RAPhotoManager.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/19.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import Foundation
import AVFoundation
import Photos
import UIKit

protocol RAPhotoManagerDelegate {
    func photoManagerDidChooseImage(image: UIImage)
}

class RAPhotoManager: NSObject {
    static let shared = RAPhotoManager()
    private var sourceVC: (UIViewController&RAPhotoManagerDelegate)?

    //请求相机权限
    static func requestCameraPermission(_ handler: @escaping (Bool) -> Swift.Void) {
        AVCaptureDevice.requestAccess(for: .video) { (result) in
            handler(result)
        }
    }

    //请求相册权限
    static func requestPhotoLibraryPermission(_ handler: @escaping (PHAuthorizationStatus) -> Swift.Void) {
        PHPhotoLibrary.requestAuthorization { (status) in
            handler(status)
        }
    }

    //相机功能是否可用
    static func isCameraAvaliable() -> Bool {
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        } else {
            return true
        }
    }

    //相册功能是否可用
    static func isPhotoLibraryAvaliable() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        if(status == PHAuthorizationStatus.denied || status == PHAuthorizationStatus.restricted){
            return false
        }else {
            return true
        }
    }

    static func getRandomAsset() -> PHAsset? {
        let resultOfCollection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        guard resultOfCollection.count != 0 else {
            return nil
        }
        var tempAssets = [PHAsset]()
        resultOfCollection.enumerateObjects { (collection, index, stop) in
            let options = PHFetchOptions()
            options.predicate = NSPredicate(format: "mediaType = %d",
                                            PHAssetMediaType.image.rawValue)
            let resultOfAssets = PHAsset.fetchAssets(in: collection, options: options)
            resultOfAssets.enumerateObjects({ (asset, indexOfAsset, stopOfAsset) in
                if asset.location != nil {
                    tempAssets.append(asset)
                }
            })
        }
        guard tempAssets.count != 0 else {
            return nil
        }

        let index = Int(arc4random())%tempAssets.count
        let asset = tempAssets[index]
        return asset
    }


    func dispalyPictureChooseSheet(sourceVC: UIViewController&RAPhotoManagerDelegate) {
        self.sourceVC = sourceVC
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "拍照", style: .default) { (action) in
            self.startCamera()
        }
        let photo = UIAlertAction(title: "照片", style: .default) { (action) in
            self.startPhoto()
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
        }
        sheet.addAction(camera)
        sheet.addAction(photo)
        sheet.addAction(cancel)
        sourceVC.present(sheet, animated: true, completion: nil)
    }

    func startCamera() {
        //判断有无打开照相机的权限
        if RAPhotoManager.isCameraAvaliable() {
            let imagePicker = UIImagePickerController.init()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            imagePicker.allowsEditing = true

            self.sourceVC?.navigationController?.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "提示", message: "请在设置中打开摄像头权限", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default) { (action) in
                self.jumpToSystemSettings()
            }
            alert.addAction(action)
            self.sourceVC?.present(alert, animated: true, completion: nil)
        }
    }

    func startPhoto() {
        if RAPhotoManager.isPhotoLibraryAvaliable() {
            let imagePicker = UIImagePickerController.init()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            imagePicker.allowsEditing = true
            self.sourceVC?.navigationController?.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "提示", message: "请在设置中打开相册权限", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default) { (action) in
                self.jumpToSystemSettings()
            }
            alert.addAction(action)
            self.sourceVC?.present(alert, animated: true, completion: nil)
        }
    }

    func jumpToSystemSettings() {
//        let url = URL(string: "App-Prefs:root=Photos")
//        if UIApplication.shared.canOpenURL(url!) {
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url!, options: [String : Any](), completionHandler: nil)
//            } else {
//                UIApplication.shared.openURL(url!)
//            }
//        }
        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }




}


extension RAPhotoManager: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //图片选择后
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let image = info["UIImagePickerControllerEditedImage"] as! UIImage
        self.sourceVC?.photoManagerDidChooseImage(image: image)
        self.sourceVC?.dismiss(animated: true, completion: nil)
    }
}
