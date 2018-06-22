//
//  RAMainViewController.swift
//  JXRomanticAlbum
//
//  Created by jiaxin on 2018/6/14.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Lottie
import SnapKit

class RAMainViewController: UIViewController {
    var animationView: LOTAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        animationView = LOTAnimationView(name: "newAnimation")
        animationView.loopAnimation = true
        self.view.addSubview(animationView)
        animationView.snp.makeConstraints { (make) in
            make.width.height.equalTo(200)
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
        }
        animationView.play()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        animationView.play()
    }

    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        takePhoto()
    }
    
    @IBAction func photoAlbumButtonClicked(_ sender: UIButton) {
        infoImage()
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let animationView = LOTAnimationView(name: "completed")
//        animationView.frame = CGRect(x: 100, y: 100, width: 250, height: 150)
//        self.view.addSubview(animationView)
//        animationView.play()
//    }

    //判断相机访问权限
    func cameraPermissions() -> Bool{

        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        AVCaptureDevice.requestAccess(for: .video) { (result) in
            print(result)
        }
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        } else {
            return true
        }
    }

    //判断相册访问权限
    func PhotoLibraryPermissions() -> Bool {

        PHPhotoLibrary.requestAuthorization { (status) in
//            let library:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
            if(status == PHAuthorizationStatus.denied || status == PHAuthorizationStatus.restricted){
//                return false
            }else {
//                return true
            }
        }
        return true
    }

    //从相册
    func infoImage() {
        //判断有无打开相册的权限
        if self.PhotoLibraryPermissions() {

            let imagePicker = UIImagePickerController.init()

            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            imagePicker.allowsEditing = true

            //进入相册
            self.navigationController?.present(imagePicker, animated: true, completion: nil)

        } else {
            UIAlertView.init(title: "提示", message: "请在设置中打开相册权限", delegate: nil, cancelButtonTitle: "确定").show()
        }
    }

    //拍照
    func takePhoto() {
        //判断有无打开照相机的权限
        if self.cameraPermissions() {

            let imagePicker = UIImagePickerController.init()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            imagePicker.allowsEditing = true

            self.navigationController?.present(imagePicker, animated: true, completion: nil)
        } else {
            UIAlertView.init(title: "提示", message: "请在设置中打开摄像头权限", delegate: nil, cancelButtonTitle: "确定").show()
        }
    }


}



extension RAMainViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    //图片选择后
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        let image = info["UIImagePickerControllerEditedImage"] as! UIImage

        //如果是拍照的图片
//        if picker.sourceType == UIImagePickerControllerSourceType.camera {
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        }

        //这就是你要的图片
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let modeVC = storyboard.instantiateViewController(withIdentifier: "RAPlayModeSelectViewController") as! RAPlayModeSelectViewController
        modeVC.image = image
        self.navigationController?.pushViewController(modeVC, animated: false)

//        let puzzleVC = RAPlayZoomPuzzleViewController()
//        puzzleVC.image = image
//        self.navigationController?.pushViewController(puzzleVC, animated: false)

        self.dismiss(animated: true, completion: nil)
    }
}



